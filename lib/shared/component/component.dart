import 'package:flutter/material.dart';

import '../colors/colors.dart';

void navigateTo(context,Widget)=>Navigator.push(
  context,
  MaterialPageRoute(builder: (context)=>Widget),
);
void navigateAndFinish(context,Widget)=>Navigator.pushAndRemoveUntil(context,
    MaterialPageRoute(builder: (context)=>Widget)
    , (route) => false);
double divider=80;
Widget myAppBar({
 required var PageNum,
  double raduis=30
})=>Container(
  width: double.infinity,
  height: 80,
  color: defultcolor,
  child: Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      CircleAvatar(
        backgroundColor: PageNum==1? primarycolor:Colors.white,
        radius: raduis,
        child: const Text("1",style: TextStyle(fontSize: 24),),
          foregroundColor:PageNum==1? Colors.white: defultcolor

      ),

      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Container(
          width:divider ,
          height: 3,
          color: Colors.white,
        ),
      ),
      CircleAvatar(
        backgroundColor: PageNum==2? primarycolor:Colors.white,
        radius: raduis,
        child: const Text("2",style: TextStyle(fontSize: 24),),
        foregroundColor:PageNum==2? Colors.white: defultcolor
        ,),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Container(
          width: divider,
          height: 3,
          color: Colors.white,
        ),
      ),
      CircleAvatar(
        backgroundColor: PageNum==3? primarycolor:Colors.white,
        radius: raduis,
        child: const Text("3",style: TextStyle(fontSize: 24),),
        foregroundColor:PageNum==3? Colors.white: defultcolor
        ,),
    ],
  ),
);

Widget myBtn({
  required  onPressed,
  required var text,
  double height=60
})=>MaterialButton(
disabledColor: Colors.grey,
  disabledTextColor: textcolor,
  onPressed: onPressed,
  minWidth: 202,
  child: Text("$text",style: TextStyle(color: textcolor,
      fontSize: 16,
  fontWeight: FontWeight.w700),),
  color: primarycolor,
  height: height,);
