import 'package:brain_tumor/shared/colors/colors.dart';
import 'package:brain_tumor/shared/component/component.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../layout/EndLAyout/end.dart';

class Result extends StatelessWidget {
  const Result({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body:Column(
          children: [
            myAppBar(PageNum: 3),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 59),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Text("Result",style: TextStyle(
                    fontSize: 39,
                    fontWeight: FontWeight.w300,
                    color: primarycolor,
                  ),),
                  Padding(
                    padding: const EdgeInsets.only(top: 500),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        myBtn(onPressed: (){
                          navigateTo(context, EndScreen());
                        }, text: "DOWNLOAD RESULT")
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
