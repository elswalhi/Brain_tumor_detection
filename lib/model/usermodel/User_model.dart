import '../MriModel/MriModel.dart';

class UserModel
{
  String? name;
  String? job;
  String? email;
  String? uId;
  String? image;
  String? gender;
  bool? isEmailVerified;
  PatientModel? patientModel;
  UserModel({
    this.email,
    this.job,
    this.name,
    this.uId,
    this.image,
    this.isEmailVerified,
    this.gender
});
  UserModel.fromJson(Map<String,dynamic>? json )
  {
    email=json!['email'];
    name=json['name'];
    job=json['job'];
    uId=json['uId'];
    image=json['image'];
    isEmailVerified=json['isEmailVerified'];
    gender=json['gender'];
  }
  Map<String,dynamic> toMap(){
    return{
      'name':name,
      'email':email,
      'job':job,
      'uId':uId,
      'image':image,
      'gender':gender,
      'isEmailVerified':isEmailVerified
    };
  }
}