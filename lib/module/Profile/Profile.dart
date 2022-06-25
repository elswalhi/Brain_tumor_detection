import 'package:brain_tumor/cubit/cubit/cubit.dart';
import 'package:brain_tumor/cubit/states/states.dart';
import 'package:brain_tumor/shared/colors/colors.dart';
import 'package:brain_tumor/shared/component/component.dart';
import 'package:brain_tumor/shared/const/const.dart';
import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var formkey=GlobalKey<FormState>();
    return BlocConsumer<AppCubit,Appstates>(
      listener: (context,state){
        if(state is UploadProfileImageSuccess){
          showToast(context, message: "Photo updated", state: ToastStates.success);
        }
        if(state is Updateusersuccess){
          showToast(context, message: "Update Success", state: ToastStates.success);
        }
      },
        builder:(context,state){

        return Scaffold(
          appBar:PreferredSize(
            preferredSize: const Size.fromHeight(70.0),
            child: AppBar(
              leadingWidth: 50,
              title: Padding(
                padding: const EdgeInsetsDirectional.only(top: 10),
                child: Text(
                  "Profile",
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
              actions: [
                Column(
                  children: [
                    const SizedBox(
                      height: 2,
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.only(end: 20),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          const CircleAvatar(
                            radius: 27,
                            backgroundColor: Colors.white,
                          ),
                          if(usermodel!=null || state is !GetUserLoading)
                          CircleAvatar(
                            backgroundImage: NetworkImage(usermodel!.image!),
                            radius: 25,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          body: BuildCondition(
            condition: usermodel!=null || state is !GetUserLoading,
            builder:(context)=> SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 30),
                child: Form(
                  key: formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      if(state is UploadProfileImageLoading || state is UpdateuserLoading)
                        LinearProgressIndicator(),
                      SizedBox(height: 10,),
                      Center(
                        child: Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            Container(
                              height: 130,
                              width: 130,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage("${usermodel!.image}"),
                                    fit: BoxFit.cover,),
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.circular(100)
                              ),
                            ),
                            InkWell(
                              onTap: (){
                                AppCubit.get(context).getProfileImage(email: usermodel!.email!,name: usermodel!.name!);
                              },
                              child: CircleAvatar(
                                radius: 20,
                                backgroundColor: HexColor("#D9D9D9"),
                                child: camera,
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 30,),
                      Text("Personal Information",style: textStyle,),
                      SizedBox(height: 15,),
                      Row(
                        children: [
                          BuildCondition(
                            condition:AppCubit.get(context).isEdit==false ,
                              builder:(context)=> Text("${usermodel!.name}",style: textStyle.copyWith(color: HexColor("#535353")),),
                            fallback:(context)=> defaultFormField(controller: EditnameController,
                                width: 250,
                                type: TextInputType.name,
                                validate: (String? value){
                                  if(value!.isEmpty){
                                    return "name cant be empty";
                                  }
                                  return null;
                                }, label: "name", color: maincolor)  ,
                          ),
                          if(AppCubit.get(context).isEdit)
                            IconButton(onPressed: (){
                              if(formkey.currentState!.validate()){
                                AppCubit.get(context).updateUser(name: EditnameController.text, email: usermodel!.email!);
                                AppCubit.get(context).isEdit=false;
                                AppCubit.get(context).editicon=Icons.edit;
                              }
                            }, icon: Icon(Icons.update,color: maincolor,)),
                          Spacer(),
                          IconButton(onPressed: (){
                            AppCubit.get(context).editprofile();
                          }, icon: Icon(AppCubit.get(context).editicon,color: maincolor,))
                        ],
                      ),
                      SizedBox(height: 30,),
                      Row(
                        children: [
                          BuildCondition(
                            condition: AppCubit.get(context).isEEdit==false,
                              builder:(context)=> Text("${usermodel!.email}",style: textStyle.copyWith(color: HexColor("#535353")),),
                            fallback:(context)=> defaultFormField(controller: EditemailController,
                                width: 250,
                                type: TextInputType.emailAddress, validate: (String? value){
                                          if(value!.isEmpty){
                                            return "email cant be empty";
                                          }
                                          return null;
                              }, label: "email", color: maincolor) ,
                          ),
                          if(AppCubit.get(context).isEEdit)
                            IconButton(onPressed: (){
                              if(formkey.currentState!.validate()){
                                AppCubit.get(context).updateUser(name: usermodel!.name!, email: EditemailController.text);
                                AppCubit.get(context).isEEdit=false;
                                AppCubit.get(context).Eediticon=Icons.edit;

                              }
                            }, icon: Icon(Icons.update,color: maincolor,)),
                          Spacer(),
                          IconButton(onPressed: (){
                            AppCubit.get(context).Eeditprofile();

                          }, icon: Icon(AppCubit.get(context).Eediticon,color: maincolor,))
                        ],
                      ),
                      SizedBox(height: 55,),
                      Text("Change Password",style: textStyle,),
                      SizedBox(height: 15,),
                      Changepassword(),




                    ],
                  ),
                ),
              ),
            ),
            fallback:(context)=> Center(child: CircularProgressIndicator()),
          ),
        ); });
  }
}
