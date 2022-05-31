import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:brain_tumor/model/MriModel/MriModel.dart';
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

  Future<void> getImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      mriImage = File(pickedFile.path);
      emit(uploadImageSuccess());
    } else {
      print('No image selected.');
      emit(uploadImageError());
    }
  }

  int? code;
  String? result;
  getResult({required image}) async {
    final request = http.MultipartRequest(
        "POST",
        Uri.parse(
            "https://206a-154-178-182-188.eu.ngrok.io/upload?patientName='name'"));
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
    result = restjson['Result'];

    print(result);
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
  late double confidence;
  classifyImage(image) async {
    var output = await Tflite.runModelOnImage(
      path: image.path,
    ).then((value) {
      print("predict = " + value.toString());
      outputs = value;
      confidence = value![0]["confidence"];
      if (value[0]["index"] == 0) {
        brainResult = "Positive Brain tumor";
      } else {
        brainResult = "Nigative Brain tumor";
      }
      emit(ClassificationSuccess());
    }).catchError((error) {
      print("Error of class is ${error.toString()}");
    });
  }

  // List<File> selectedimages=[];
  // List<XFile> imageFileList = [];
  // var picker2 = ImagePicker();
  // Future<void> getProfileImages() async {
  //   final List<XFile>? pickedFile = await picker.pickMultiImage().then((value){
  //     value!.forEach((element) async {
  //       print("upload done");
  //     });
  //     print(selectedimages);
  //   });
  // }
  void getHttp() async {
    try {
      var response = await Dio()
          .post('https://206a-154-178-182-188.eu.ngrok.io/upload', data: {
        'file':
            "data:image/jpeg;base64,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"
      });
      print(response.data);
    } catch (e) {
      print(e);
    }
  }
  // void selectImages()  {
  //   Future _listImagePaths =  ImagePickers.pickerPaths(
  //       galleryMode: GalleryMode.image,
  //       selectCount: 5,
  //       showGif: false,
  //       showCamera: true,
  //       compressSize: 500,
  //       uiConfig: UIConfig(uiThemeColor: Color(0xffff0f50)),
  //       cropConfig: CropConfig(enableCrop: false, width: 2, height: 1)).then((value){
  //         value.forEach((element) {
  //
  //         });
  //   });
  // }
  // List<String> links=[];

  // @override
  // void dispose() {
  //   Tflite.close();
  //   dispose();
  // }
  // void upload(img){
  //   firebase_storage.FirebaseStorage.instance.ref().child('users/${Uri.file(img.path).pathSegments.last}')
  //       .putFile(img!).then((value) {
  //     value.ref.getDownloadURL().then((value) {
  //
  //     });
  //   });
  // }
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

  // Future uploadmultipleimage(List images) async {
  //   var uri = Uri.parse("");
  //   http.MultipartRequest request = new http.MultipartRequest('POST', uri);
  //   request.headers[''] = '';
  //   request.fields['user_id'] = '10';
  //   request.fields['post_details'] = 'dfsfdsfsd';
  //   //multipartFile = new http.MultipartFile("imagefile", stream, length, filename: basename(imageFile.path));
  //   List<MultipartFile> newList = <MultipartFile>[];
  //   for (int i = 0; i < images.length; i++) {
  //     File imageFile = File(images[i].toString());
  //     var stream =
  //     new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
  //     var length = await imageFile.length();
  //     var multipartFile = new http.MultipartFile("imagefile", stream, length,
  //         filename: basename(imageFile.path));
  //     newList.add(multipartFile);
  //   }
  //   request.files.addAll(newList);
  //   var response = await request.send();
  //   if (response.statusCode == 200) {
  //     print("Image Uploaded");
  //   } else {
  //     print("Upload Failed");
  //   }
  //   response.stream.transform(utf8.decoder).listen((value) {
  //     print(value);
  //   });
  // }
  List<Asset> imagesList = <Asset>[];
  List<Asset> resultList = <Asset>[];
  Future<void> loadAssets(context) async {
    String error = 'No Error Detected';

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 5,
        enableCamera: false,
        selectedAssets: imagesList,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
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
          a.add(tempFile);
        }
        print("elbta3a ahy $a");

      });
      imagesList = resultList;
      navigateTo(context, AfterUpload());
      print(resultList);
    } on Exception catch (e) {
      error = e.toString();
      print(e);
    }
  }
  Future uploadImageToServer(BuildContext context, {required name}) async {
    var uri = Uri.parse(
        "https://8298-156-196-194-13.eu.ngrok.io/upload?patientName='$name'");
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
      print("el value  $value");
    });
    if (response.statusCode == 200) {
      print('uploaded');
    } else {
      print('failed');
    }
  }
  void AddMri({
    required String name,
    required String datetime,
    required String result,
    required String confidence,
    required String image,
  }) {
    emit(UploadResultLoading());
    PatientModel patientModel = PatientModel(
      name: name,
      dateTime: datetime,
    );
    MriModel mriModel=MriModel(
      confidence: confidence,
      image: image,
      result: this.result
    );
    FirebaseFirestore.instance
        .collection("users")
        .doc(usermodel!.uId)
        .collection("process")
        .add(patientModel.toMap())
        .then((value) {
      emit(UploadResultSuccess());
    }).catchError((error) {
      print("Error of patint is $error");
      emit(UploadResultError());
    });
    FirebaseFirestore.instance
        .collection("users")
        .doc(usermodel!.uId)
        .collection('process')
        .doc()
        .set(MriModel().toMap());
  }

  List<File> a = [];
  void s() {}
  void UploadMriImage({
    required String name,
    required String datetime,
    required String result,
    required String confidence,
    required String image,
    required index,
  }) {
    FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(a[index].path).pathSegments.last}')
        .putFile(a[index])
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        AddMri(
            name: name,
            datetime: datetime,
            result: result,
            confidence: confidence,
            image: image);
      });
    }).catchError((error) {});
  }
  // void CreatePost({
  //   required String dateTime,
  //   required String text,
  //   required BuildContext context,
  //   String? postImage,
  // }) {
  //   emit(UploadResultLoading());
  //   // PostModel postmodel = PostModel(
  //   //   name: usermodel!.name,
  //   //   image: usermodel!.image!,
  //   //   uId: usermodel!.uId,
  //   //   postImage: postImage??'',
  //   //   text: text,
  //   //   dateTime: dateTime,
  //
  //   // );
  //   FirebaseFirestore.instance
  //       .collection('posts')
  //       .add(postmodel.toMap())
  //       .then((value) {
  //     emit(UploadResultSuccess());
  //   }).catchError((error) {
  //     emit(UploadResultError());
  //   });
  // }

}
