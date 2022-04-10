import 'dart:ui';

import 'package:brain_tumor/module/uploadscreen/UploadScreen.dart';
import 'package:brain_tumor/shared/colors/colors.dart';
import 'package:brain_tumor/shared/component/component.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
   HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor:defultcolor,
      body: Padding(
        padding: const EdgeInsetsDirectional.only(top: 300,),
        child: Container(
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
               Container(
                 width: 310,
                 child:  Text("Brain Tumor Detection",
                   textAlign: TextAlign.center,
                   style: TextStyle(
                       color: textcolor,
                     fontSize: 48,
                     fontStyle: FontStyle.normal,
                     fontWeight: FontWeight.w300
                   ),),
               ),
                Padding(
                  padding:  EdgeInsetsDirectional.only(top: 280),
                  child: myBtn(  text:"START THE PROCESS",
                      onPressed:(){ navigateTo(context, UploadScreen());

                  }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
