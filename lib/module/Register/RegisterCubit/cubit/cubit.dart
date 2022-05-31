import 'package:brain_tumor/cubit/states/states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../model/usermodel/User_model.dart';
import '../state/states.dart';


// ignore: camel_case_types
class RegisterCubit extends Cubit<RegisterStates>{
  RegisterCubit() : super(RegisterInitial());
  static RegisterCubit get(context)=>BlocProvider.of(context);
  String? errorMessage;
  void userRegister({
    required String email,
    required String password,
    required String name,
    required String job,
    required String gender,
  })
  {
    emit(RegisterLoading());
    FirebaseAuth.instance.
    createUserWithEmailAndPassword(email: email, password: password).then((value){

      print(value.user!.email);
      print(value.user!.uid);
      UserCreate(uId: value.user!.uid,
          email: email,
          job: job,
          name: name
          ,gender:gender);
    }).catchError((error){
      print("Reg error is $error");
      emit(RegisterError(error.message));
      switch(error.code){
    case "ERROR_EMAIL_ALREADY_IN_USE":
    case "account-exists-with-different-credential":
    case "email-already-in-use":
      errorMessage= "Email already used. Go to login page.";
      break;
    case "ERROR_INVALID_EMAIL":
    case "invalid-email":
        errorMessage= "Email address is invalid.";
        break;
     case "ERROR_USER_DISABLED":
     case "user-disabled":
       errorMessage= "User disabled.";
      break;
      }
    });
  }
  void UserCreate({
    required String email,
    required String uId,
    required String name,
    required String job,
    required String gender,

  }){
    UserModel model = UserModel(
      email: email,
      job: job,
      gender: gender,
      name: name,
      uId: uId,
      isEmailVerified: false,
      image: 'https://img.freepik.com/free-vector/emoji-style-style-imagination-sharing-design-concept_320681-98.jpg?size=338&ext=jpg&ga=GA1.2.1869579064.1651062600',
    );
    FirebaseFirestore.instance.collection('users')
        .doc(uId)
        .set(model.toMap()).then((value){

      emit(CreateUserSuccess());
    })
        .catchError((error){

      emit(CreateUserError(error.toString()));
    });
  }
  bool isPassword=true;
  IconData suffix=Icons.remove_red_eye;
  void visiblePass(){
    isPassword=!isPassword;
     suffix=isPassword? Icons.remove_red_eye:Icons.visibility_off;
    emit(RegisterVisiblePassword());
    print(isPassword);
  }
  void Regerror(){
    errorMessage=null;
    emit(ChangeError());
  }
  void changeButtom() {
          emit(Changechecked());
      }
  }

// String getMessageFromErrorCode() {
//   switch (this.errorCode) {
//     case "ERROR_EMAIL_ALREADY_IN_USE":
//     case "account-exists-with-different-credential":
//     case "email-already-in-use":
//       return "Email already used. Go to login page.";
//       break;
//     case "ERROR_WRONG_PASSWORD":
//     case "wrong-password":
//       return "Wrong email/password combination.";
//       break;
//     case "ERROR_USER_NOT_FOUND":
//     case "user-not-found":
//       return "No user found with this email.";
//       break;
//     case "ERROR_USER_DISABLED":
//     case "user-disabled":
//       return "User disabled.";
//       break;
//     case "ERROR_TOO_MANY_REQUESTS":
//     case "operation-not-allowed":
//       return "Too many requests to log into this account.";
//       break;
//     case "ERROR_OPERATION_NOT_ALLOWED":
//     case "operation-not-allowed":
//       return "Server error, please try again later.";
//       break;
//     case "ERROR_INVALID_EMAIL":
//     case "invalid-email":
//       return "Email address is invalid.";
//       break;
//     default:
//       return "Login failed. Please try again.";
//       break;
//   }
// }