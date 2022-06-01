import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'package:brain_tumor/model/MriModel/MriModel.dart';
import 'package:brain_tumor/module/After%20Process/Afterprocess.dart';
import 'package:brain_tumor/module/AfterUpload/AfterUpload.dart';
import 'package:brain_tumor/module/Result/result.dart';
import 'package:brain_tumor/module/about/about.dart';
import 'package:brain_tumor/module/saved/saved.dart';
import 'package:brain_tumor/shared/component/component.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:brain_tumor/cubit/states/states.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:tflite/tflite.dart';
import '../../model/usermodel/User_model.dart';
import '../../module/recent result/resent.dart';
import '../../shared/const/const.dart';

class AppCubit extends Cubit<Appstates> {
  AppCubit() : super(InitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  File? mriImage;
  var picker = ImagePicker();

  Future<void> getImage(context) async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      mriImage = File(pickedFile.path);
        navigateTo(context, AfterUpload());
      emit(uploadImageSuccess());
    } else {
      print('No image selected.');
      emit(uploadImageError());
    }
  }

  int? code;
  String? processResult;
  getResult({required image}) async {
    final request = http.MultipartRequest(
        "POST",
        Uri.parse(
            "https://eflask-appas.herokuapp.com/predict"));
    final headers = {
      "Content-Type": "multipart/form-data",
    };
    request.files.add(http.MultipartFile(
        'file', image.readAsBytes().asStream(), image.lengthSync(),
        filename: image.path.split("/").last));
    request.headers.addAll(headers);

    final response = await request.send();
    code = response.statusCode;
    if (response.statusCode == 200) {
      emit(getResultSuccess());
      print("Request Send ");
    } else {
      print("Error and this code is  ${response.statusCode}");
    }
    http.Response res = await http.Response.fromStream(response);
    final restjson = jsonDecode(res.body);
    print(restjson);
    processResult = restjson['Result'];

    print(processResult);
  }

  void endapp() {
    mriImage = null;
    code = null;
  }

  loadModel() async {
    await Tflite.loadModel(
      model: "assets/model.tflite",
      labels: "assets/labels.txt",
    ).then((value) {
      print("done");
    }).catchError((error) {
      print(" ${error.toString()}");
    });
  }

  List? outputs;
  String? brainResult;
   double? confidence;
  classifyImage({required image,
    required context,
    required datetime}) async {
    await Tflite.runModelOnImage(
      path: image.path,
    ).then((value) {
      print("predict = " + value.toString());
      outputs = value;
      confidence = value![0]["confidence"] ;
      confidence=confidence!*100;
      if (value[0]["index"] == 0) {
        brainResult = "Positive ";
      } else {
        brainResult = "Negative ";
      }
      emit(ClassificationSuccess());
    }).then((value){
      navigateAndFinish(context, const ProcessingDetails());
      UploadMriImage(name: nameController.text, datetime: datetime, result: brainResult!, confidence: confidence!, image: image
      );
    }).catchError((error) {
      print("Error of class is ${error.toString()}");
    });
  }

  void getUserData() async {
    try {
      emit(GetUserLoading());
      final value =
          await FirebaseFirestore.instance.collection('users').doc(uId).get();
      usermodel = UserModel.fromJson(value.data()!);
      emit(GetUserSuccess());
    } catch (error) {
      print("get Error is $error");
      emit(GetUserError(error.toString()));
    }
  }

  int currentIndex = 0;
  List<String> Titles = [
    "${usermodel?.name}",
    "All Results",
    "About Us",
    "Saved Results"
  ];
  List<Widget> screens = [
    const Recent(),
    const Result(),
    const AboutUs(),
    const SavedScreen(),
  ];
  void ChangeScreens(int index, context) {
    currentIndex = index;
    emit(changeBottomNav());
  }


  List<Asset> imagesList = <Asset>[];
  List<Asset> resultList = <Asset>[];
  Future<void> loadAssets(context) async {
    String error = 'No Error Detected';

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 5,
        enableCamera: false,
        selectedAssets: imagesList,
        cupertinoOptions: const CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: const MaterialOptions(
          actionBarColor: "#009E82",
          actionBarTitle: "Brain Tumor Detection",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#009E82",
        ),
      );
      resultList.forEach((imageAsset) async {
        final filePath =
            await FlutterAbsolutePath.getAbsolutePath(imageAsset.identifier);

        File tempFile = File(filePath);

        if (tempFile.existsSync()) {
          ImageFile.add(tempFile);
        }
        print("elbta3a ahy $ImageFile");

      });
      imagesList = resultList;
      navigateTo(context, AfterUpload());
      print(resultList);
    } on Exception catch (e) {
      error = e.toString();
      print(e);
    }
  }
  // List<XFile> imageFileList = [];
  // Future<void> getIamges() async {
  //   final List<XFile>? pickedFile = await picker.pickMultiImage();
  //   if (pickedFile!.isNotEmpty) {
  //     imageFileList.addAll(pickedFile);
  //   } else {
  //     print('No image selected.');
  //   }
  //   imageFileList.forEach((element) async {
  //     final filePath =
  //         await FlutterAbsolutePath.getAbsolutePath(element.path);
  //
  //     File tempFile = File(filePath);
  //
  //     if (tempFile.existsSync()) {
  //       ImageFile.add(tempFile);
  //       print(ImageFile);
  //       print(ImageFile[0].path);
  //     }
  //   });
  //
  // }
   Future uploadImageToServer(BuildContext context, {required name}) async {
    var uri = Uri.parse(
        "https://427c-156-196-7-89.eu.ngrok.io/upload?patientName='$name'");
    http.MultipartRequest request = http.MultipartRequest('POST', uri);
    List<http.MultipartFile> newList = <http.MultipartFile>[];
    for (int i = 0; i < imagesList.length; i++) {
      var path =
          await FlutterAbsolutePath.getAbsolutePath(imagesList[i].identifier);
      File imageFile = File(path);

      var stream = http.ByteStream(imageFile.openRead());
      var length = await imageFile.length();

      var multipartFile = http.MultipartFile("pictures", stream, length,
          filename: (imageFile.path));
      newList.add(multipartFile);
    }

    request.files.addAll(newList);
    var response = await request.send();
    print(response.toString());
    response.stream.transform(utf8.decoder).listen((value) {
      print("el value  ${value}");
    });
    if (response.statusCode == 200) {
      print('uploaded');
    } else {
      print('failed');
    }
  }
  void AddMri({
    required String datetime,
    required String result,
    required double confidence,
    required String image,
  }) {
    emit(UploadResultLoading());
    PatientModel patientModel = PatientModel(
      name: nameController.text,
      date: datetime,
      dId: usermodel!.uId,
    );
    MriModel mriModel=MriModel(
      confidence: confidence,
      image: image,
      isSaved: false,
      result: result,
    );
    FirebaseFirestore.instance
        .collection("patient")
        .add(patientModel.toMap())
        .then((value) {
          FirebaseFirestore.instance
          .collection('patient')
          .doc(nameController.text)
          .collection('Mri')
          .add(mriModel.toMap())
          .then((value) {
            emit(UploadResultSuccess());
          })
          .catchError((error) {
            emit(UploadResultError());
          });
    }).catchError((error) {
      print("Error of patint is $error");
      emit(UploadResultError());
    });
  }

var imageLink;
  List<File> ImageFile = [];
  void UploadMriImage({
    required String name,
    required String datetime,
    required String result,
    required double  confidence,
    required  image,
  }) {
    FirebaseStorage.instance
        .ref()
        .child('${nameController.text}/${Uri.file(mriImage!.path).pathSegments.last}')
        .putFile(mriImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        AddMri(
            datetime: datetime,
            result: result,
            confidence: confidence,
            image: value);
      });
    }).catchError((error) {});
  }
  List<PatientModel> processInfo=[];
  void getProcessInfo(){
    emit(GetPostsLoading());
    FirebaseFirestore.instance.collection('patient').doc().get().
        then((value) {
      processInfo.add(PatientModel.fromJson(value.data()!));
      print(value);
          emit(GetPostsSuccess());
          print(processResult);
    }).catchError((error){
      print(error);
      emit(GetPostsError(error.toString()));
    });



}


}
