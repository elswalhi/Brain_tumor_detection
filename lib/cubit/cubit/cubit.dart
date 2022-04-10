import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:brain_tumor/cubit/states/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class AppCubit extends Cubit<Appstates> {
  AppCubit() : super(InitialState());
  static AppCubit get(context)=>BlocProvider.of(context);
  double value = 0;
  void downloadData(){
    value=0;
    Timer.periodic(
        const Duration(seconds: 1),
            (Timer timer){
            if(value == 1) {
              timer.cancel();

            }
            else {
              value = value + 0.2;
            }

            emit(testState());
        }
    );
  }
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
}