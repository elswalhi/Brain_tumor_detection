import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:brain_tumor/module/Result/result.dart';
import 'package:brain_tumor/module/about/about.dart';
import 'package:brain_tumor/module/saved/saved.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:bloc/bloc.dart';
import 'package:brain_tumor/cubit/states/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:image_pickers/image_pickers.dart';
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
  getResult(
  {required File image}
      ) async {
    final request =http.MultipartRequest("POST",Uri.parse("https://eflask-appas.herokuapp.com/predict"));
    final headers={
      "Content-Type":"multipart/form-data",
    };
    request.files.add(http.MultipartFile('file',image.readAsBytes().asStream(),image.lengthSync(),filename: image.path.split("/").last));
    request.headers.addAll(headers);
    final response= await request.send();
    code= response.statusCode;
    if(response.statusCode==200){
      emit(getResultSuccess());
      print("Request Send ");
    }
    else{
      print("Error and this code is  ${response.statusCode}");
    }
    http.Response res =await http.Response.fromStream(response);
    final restjson=jsonDecode(res.body);
    print(restjson);
    result=restjson['Result'];

    print(result);

  }
  void endapp(){
    mriImage=null;
    code=null;
  }
  loadModel() async {
    await Tflite.loadModel(
      model: "assets/model.tflite",
      labels: "assets/labels.txt",
    ).then((value){
      print("done");
    })
    .catchError((error){
      print(" ${error.toString()}");
    });
  }
  List? outputs;
  String? brainResult;
  late double confidence;
  classifyImage( image) async {
    var output = await Tflite.runModelOnImage(
      path:image.path,
    ).then((value){
      print("predict = "+value.toString());
      outputs = value;
      confidence=value![0]["confidence"];
      if(value[0]["index"]==0){
        brainResult="Positive Brain tumor";
      }
      else{
        brainResult="Nigative Brain tumor";
      }
      emit(ClassificationSuccess());
    }).catchError((error){
      print("Error of class is ${error.toString()}");
    });
  }

  List<File> selectedimages=[];
  List<XFile> imageFileList = [];
  // var picker = ImagePicker();
  // Future<void> getProfileImages() async {
  //   final List<XFile>? pickedFile = await picker.pickMultiImage().then((value){
  //     value!.forEach((element) {
  //       File file= File(element.path);
  //       print("upload done");
  //       selectedimages.add(file);
  //     });
  //     print(selectedimages);
  //   });
  // }
  // void selectImages()  {
  //   Future _listImagePaths =  ImagePickers.pickerPaths(
  //       galleryMode: GalleryMode.image,
  //       selectCount: 5,
  //       showGif: false,
  //       showCamera: true,
  //       compressSize: 500,
  //       uiConfig: UIConfig(uiThemeColor: Color(0xffff0f50)),
  //       cropConfig: CropConfig(enableCrop: false, width: 2, height: 1)).then((value){
  //      value.forEach((element) {
  //
  //      });
  //   });
  // }
  List<String> links=[];

  @override
  void dispose() {
    Tflite.close();
    dispose();
  }
  void upload(img){
    firebase_storage.FirebaseStorage.instance.ref().child('users/${Uri.file(img.path).pathSegments.last}')
        .putFile(img!).then((value) {
      value.ref.getDownloadURL().then((value) {
        links.add(value);
      }).then((value){
        classifyImage(links[0]);
        print("classification done");
      });
    });
  }
   UserModel? usermodel;
  void getUserData() {
    emit(GetUserLoading());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      usermodel = UserModel.fromJson(value.data());
      emit(GetUserSuccess());
    }).catchError((error) {
      print("get Error is $error");
      emit(GetUserError(error.toString()));
    });
  }
  int currentIndex = 0;

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


}


