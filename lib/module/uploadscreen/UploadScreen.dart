
import 'package:brain_tumor/cubit/cubit/cubit.dart';
import 'package:brain_tumor/cubit/states/states.dart';
import 'package:brain_tumor/module/processing%20screen/processScreen.dart';
import 'package:brain_tumor/shared/colors/colors.dart';
import 'package:brain_tumor/shared/component/component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UploadScreen extends StatelessWidget {
    const UploadScreen() : super();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,Appstates>(
      listener: ( context, state) {

      },
      builder: ( context,  state) {
        var cubit =AppCubit.get(context);
        return Scaffold(
          body:SafeArea(
              child: Column(
                children: [
                  myAppBar(PageNum: 1),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 30),
                    child: InkWell(
                      onTap: (){
                        cubit.getImage();
                      },
                      child: Container(
                        width: double.infinity,
                        height: 300,
                        decoration: BoxDecoration(
                          color:Colors.transparent ,
                          shape: BoxShape.rectangle,
                          border: Border.all(
                            color: primarycolor,
                          ),
                        ),
                        child: Center(child: Container(
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(color: primarycolor),
                          ),
                          child:cubit.mriImage==null? IconButton(onPressed: (){
                            AppCubit.get(context).getImage();
                          }
                            , icon: const Icon(Icons.add),
                            color:primarycolor ,):Image.file(cubit.mriImage!,
                          width: double.infinity,
                          height: 300,
                          fit: BoxFit.cover,) ,
                        )),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsetsDirectional.only(end: 20),
                        child: myBtn(onPressed: (){
                          cubit.mriImage==null? cubit.getImage():navigateTo(context, ProcessScreen());
                        }, text: cubit.mriImage==null?  "UPLOAD THE MRI": "START THE PROCESS",),
                      ),
                    ],
                  )
                ],
              )
          ) ,
        );
      },

    );
  }
}
