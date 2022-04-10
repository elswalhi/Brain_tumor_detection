import 'dart:ui';

import 'package:brain_tumor/layout/homelayout/homeLayout.dart';
import 'package:brain_tumor/module/uploadscreen/UploadScreen.dart';
import 'package:brain_tumor/shared/colors/colors.dart';
import 'package:brain_tumor/shared/component/component.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EndScreen extends StatelessWidget {
  const EndScreen({Key? key}) : super(key: key);

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
                  width: 350,
                  height: 130,
                  child:  Text("It always seems impossible until it’s done.",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        color: textcolor,
                        fontSize: 36,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w700
                    ),),
                ),
                Padding(
                  padding:  EdgeInsetsDirectional.only(top:100),
                  child: myBtn(  text:"BACK TO HOMEPAGE",
                      onPressed:(){ navigateTo(context, HomeScreen());

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
