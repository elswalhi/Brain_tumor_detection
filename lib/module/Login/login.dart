
import 'package:brain_tumor/shared/colors/colors.dart';
import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../Network/local/sharedpref.dart';
import '../../layout/homelayout/homeLayout.dart';
import '../../shared/component/component.dart';
import '../Register/register.dart';
import 'loginCubit/cubit/cubit.dart';
import 'loginCubit/state/states.dart';
class LoginScreen extends StatelessWidget {
   LoginScreen({Key? key}) : super(key: key);
  var formkey=GlobalKey<FormState>();
  var emailController=TextEditingController();
   var passwordController=TextEditingController();

   @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit,LoginStates>(
      listener:(context, state){
        final cubit =LoginCubit.get(context);

        if(state is GetUserSuccess){
          CacheHelper.SaveData(key: 'uId',
              value:state.uId ).then((value){
                navigateAndFinish(context, HomeScreen());
          });
        }
      },
    builder: (context,state){
      final cubit =LoginCubit.get(context);
      if(state is LoginError){
        if(cubit.serverError!=null){
          showToast(context, message: "${cubit.serverError}", state: ToastStates.error);
      }

      }
      return Scaffold(
          body: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //text
                        Text("Login"
                          ,style: TextStyle(fontSize: 25,fontWeight: FontWeight.w700,color: HexColor("#009E82")),),
                        const SizedBox(height: 40,),
                        //email
                        Container(
                          child: defaultFormField(
                            color: cubit.emailError!=null? HexColor("#Da1d19"):borderColor,
                              controller: emailController,
                              type: TextInputType.emailAddress,
                              validate: (String? value){
                                if(value!.isEmpty){
                                  cubit.ChangeError();
                                  return 'please Enter your Email Adress ';
                                }

                                else if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
                                  cubit.ChangeError();
                                   return ("Please Enter a valid email");}
                                return null;
                              },
                              label: 'EmailAdress',

                          ),
                        ),
                        if (cubit.emailError!=null)
                          Padding(
                            padding: const EdgeInsetsDirectional.only(top: 3,start: 11),
                            child: Text(cubit.emailError!,style:  TextStyle(color: HexColor("#Da1d19"),fontSize: 12),),
                          ),
                        //password
                        const SizedBox(height: 20,),
                        //button
                        Container(
                          child: defaultFormField(
                            color: borderColor,
                            controller: passwordController,
                            type: TextInputType.visiblePassword,
                            isPassword: LoginCubit.get(context).isPassword,
                            validate: (String? value){
                              if(value!.isEmpty){
                                return 'please Enter your password ';
                              }
                              return null;
                            },
                            label: 'password',
                            suffix: LoginCubit.get(context).suffix,
                            suffixPressed:(){ LoginCubit.get(context).visiblePass();},
                          ),
                        ),
                        if (cubit.passError!=null)
                          Padding(
                            padding: const EdgeInsetsDirectional.only(top: 3,start: 11),
                            child: Text(cubit.passError!,style:  TextStyle(color: HexColor("#Da1d19"),fontSize: 12),),
                          ),
                        const SizedBox(height: 25,),
                        BuildCondition(
                          condition: state is! LoginLoading,
                          builder:(context)=> defaultButton(function: (){
                            cubit.ChangeError();
                            if(formkey.currentState!.validate()){

                              LoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text);
                            }


                          }, text: "Login")
                          ,
                          fallback:(context)=> const Center(child: CircularProgressIndicator()),),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                             Text("Don’t have and account?",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 14
                                ,color: HexColor("#1A1B1C")),),
                            //Reg now text Button
                            Container(
                              child: defultTextButton(text: "Register"
                                  , function: (){
                                    navigateTo(context, Register());
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
          ),
        );
    },);

  }
}
