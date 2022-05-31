import 'package:brain_tumor/layout/homelayout/homeLayout.dart';
import 'package:brain_tumor/module/Login/loginCubit/cubit/cubit.dart';
import 'package:brain_tumor/module/Login/loginCubit/state/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
// ignore: import_of_legacy_library_into_null_safe
import '../../shared/colors/colors.dart';
import '../../shared/component/component.dart';
import '../Login/login.dart';
// ignore: camel_case_types, must_be_immutable
class Register extends StatelessWidget {
  var formkey=GlobalKey<FormState>();
  var emailController=TextEditingController();
  var passwordController=TextEditingController();
  var rePasswordController=TextEditingController();
  var nameController=TextEditingController();
  var jobController=TextEditingController();

  Register({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<LoginCubit,LoginStates>(
      listener: (context,state){
        if(state is GetUserSuccess){
          navigateAndFinish(context, HomeScreen());
       }
        },
      builder: (context,state){
    final cubit  =  LoginCubit.get(context);
    String? gender=genderM;
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 81,horizontal: 20),
                child: Form(
                  key: formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      //text
                      Text("Sign Up"
                        ,style: TextStyle(fontSize: 25,fontWeight: FontWeight.w700,color: HexColor("#009E82"))
                        ),
                      const SizedBox(height: 30,),
                      Container(
                        child: defaultFormField(
                            color: borderColor,

                            controller:nameController,
                            type: TextInputType.name,
                            validate: (String? value){
                              if(value!.isEmpty){
                                return 'please Enter your  name ';
                              }
                              return null;
                            },
                            label: 'Name',
                            prefix: Icons.person
                        ),
                      ),
                      const SizedBox(height: 15,),
                      //email
                      Container(
                        child: defaultFormField(
                            color: cubit.errorMessage!=null? HexColor("#Da1d19"):Colors.grey,
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            validate: (String? value){
                              if(value!.isEmpty){
                                cubit.Regerror();
                                return 'please Enter your Email Adress ';
                              }
                              else if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
                                cubit.Regerror();
                                return ("Please Enter a valid email");
                              }

                            },
                            label: 'EmailAdress',
                            prefix: Icons.email_outlined
                        ),
                      ),
                      if (cubit.errorMessage!=null)
                        Padding(
                          padding: const EdgeInsetsDirectional.only(top: 3,start: 11),
                          child: Text(cubit.errorMessage!,style:  TextStyle(color: HexColor("#Da1d19"),fontSize: 12),),
                        ),
                      //password
                      const SizedBox(height: 20,),
                      //button
                      Container(
                        child: defaultFormField(
                          color: borderColor,
                          controller: passwordController,
                          onSubmit: (value){
                          },
                          type: TextInputType.visiblePassword,
                          isPassword: LoginCubit.get(context).isPassword,
                          validate: (String? value){
                            if(value!.isEmpty){
                              return 'please Enter your password ';
                            }
                            if(value.length <6){
                              return 'Password should be at least 6 characters';
                            }
                            return null;
                          },
                          label: 'password',
                          prefix: Icons.lock_open_outlined,
                          suffix: LoginCubit.get(context).suffix,
                          suffixPressed: (){
                            LoginCubit.get(context).visiblePass();
                          },

                        ),
                      ),
                      const SizedBox(height: 20,),
                      Container(
                        child: defaultFormField(
                          color: borderColor,
                          controller: rePasswordController,
                          onSubmit: (value){
                          },
                          type: TextInputType.visiblePassword,
                          isPassword: LoginCubit.get(context).isPassword,
                          validate: (String? value){
                            if(value!.isEmpty){
                              return 'please confirm your password ';
                            }
                            if(value != passwordController.text){
                              return 'Password is not matching';
                            }
                            return null;
                          },
                          label: 'Confirm Password',
                          prefix: Icons.lock_open_outlined,
                          suffix: LoginCubit.get(context).suffix,
                          suffixPressed: (){
                            LoginCubit.get(context).visiblePass();
                          },

                        ),
                      ),
                      const SizedBox(height: 20,),

                      Container(
                        child: defaultFormField(
                            color: borderColor,
                            controller:jobController,
                            type: TextInputType.text,
                            validate: (String? value){
                              if(value!.isEmpty){
                                return 'please Enter your job ';
                              }
                              return null;
                            },
                            label: 'current job',
                        ),
                      ),
                      const SizedBox(height: 15,),
                      radio(),
                      checkbox(),
                         SizedBox(height: 35,),
                      state is ! RegisterLoading?
                      ConstrainedBox(
                        constraints: BoxConstraints.tightFor(width: double.infinity,height: 40),
                        child: ElevatedButton(style:ElevatedButton.styleFrom(
                          primary: HexColor("#009E82"),
                        ) ,
                            onPressed: checkedValue==true?(){
                                              cubit.errorMessage=null;
                                              if(formkey.currentState!.validate()){
                                              cubit.userRegister(
                                              email: emailController.text,
                                              password: passwordController.text,
                                              name: nameController.text,
                                              job: jobController.text,
                                              gender: gender);
                                              }
                            }: null , child: Text("sign up",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 16),)),
                      ):const Center(child: CircularProgressIndicator()),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Already have an account?"),
                          //Reg now text Button
                          Container(
                            child: defultTextButton(text: "Login"
                                , function: (){
                                   navigateTo(context, LoginScreen());
                                }),
                          )
                        ],
                      ),

                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
