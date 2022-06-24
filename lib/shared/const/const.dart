
import 'dart:convert';

import 'package:brain_tumor/cubit/cubit/cubit.dart';
import 'package:brain_tumor/model/usermodel/User_model.dart';
import 'package:brain_tumor/shared/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../module/Result/result.dart';

late String uId;
UserModel? usermodel ;
final Widget savedi = SvgPicture.string('<svg xmlns="http://www.w3.org/2000/svg" height="48" width="48"><path d="M8.9 43.7V9.25Q8.9 7.4 10.275 6.025Q11.65 4.65 13.45 4.65H34.55Q36.35 4.65 37.75 6.025Q39.15 7.4 39.15 9.25V43.7L24 37.25Z"/></svg>'
,color: textcolor,
);final Widget saved = SvgPicture.string('<svg xmlns="http://www.w3.org/2000/svg" height="48" width="48"><path d="M8.9 43.7V9.25Q8.9 7.4 10.275 6.025Q11.65 4.65 13.45 4.65H34.55Q36.35 4.65 37.75 6.025Q39.15 7.4 39.15 9.25V43.7L24 37.25Z"/></svg>'
    ,color: unactive,
);
final Widget homei = SvgPicture.string('<svg xmlns="http://www.w3.org/2000/svg" height="48" width="48"><path d="M9.6 40.35V24.4H2.9L24 5.45L33.55 13.85V8.75H38.4V18.35L45.1 24.4H38.4V40.35H28.5V28.8H19.5V40.35ZM19.5 20.45H28.5Q28.5 18.6 27.175 17.4Q25.85 16.2 24 16.2Q22.2 16.2 20.85 17.4Q19.5 18.6 19.5 20.45Z"/></svg>', color: textcolor,
);
final Widget home = SvgPicture.string('<svg xmlns="http://www.w3.org/2000/svg" height="48" width="48"><path d="M9.6 40.35V24.4H2.9L24 5.45L33.55 13.85V8.75H38.4V18.35L45.1 24.4H38.4V40.35H28.5V28.8H19.5V40.35ZM19.5 20.45H28.5Q28.5 18.6 27.175 17.4Q25.85 16.2 24 16.2Q22.2 16.2 20.85 17.4Q19.5 18.6 19.5 20.45Z"/></svg>', color: unactive);


final Widget abouti = SvgPicture.string('<svg xmlns="http://www.w3.org/2000/svg" height="48" width="48"><path d="M1.1 41.5V35.7Q1.1 33.6 2.175 31.925Q3.25 30.25 5.15 29.4Q8.9 27.8 11.925 27.05Q14.95 26.3 18.15 26.3Q21.45 26.3 24.45 27.05Q27.45 27.8 31.2 29.4Q33.1 30.2 34.2 31.85Q35.3 33.5 35.3 35.7V41.5ZM18.2 23.3Q14.6 23.3 12.425 21.125Q10.25 18.95 10.25 15.4Q10.25 11.8 12.45 9.6Q14.65 7.4 18.2 7.4Q21.7 7.4 23.95 9.6Q26.2 11.8 26.2 15.35Q26.2 18.95 23.95 21.125Q21.7 23.3 18.2 23.3ZM37.5 15.35Q37.5 18.9 35.275 21.1Q33.05 23.3 29.55 23.3Q28.9 23.3 28.375 23.225Q27.85 23.15 27.15 22.9Q28.45 21.55 29.075 19.65Q29.7 17.75 29.7 15.4Q29.7 13 29.075 11.175Q28.45 9.35 27.15 7.8Q27.7 7.6 28.35 7.5Q29 7.4 29.55 7.4Q33.05 7.4 35.275 9.625Q37.5 11.85 37.5 15.35ZM38.85 41.5V35.8Q38.85 32.55 37.225 30.4Q35.6 28.25 32.95 26.4Q35.95 26.9 38.6 27.625Q41.25 28.35 43.05 29.2Q44.8 30.15 45.875 31.875Q46.95 33.6 46.95 35.95V41.5Z"/></svg>',color: textcolor,
);
final Widget about = SvgPicture.string('<svg xmlns="http://www.w3.org/2000/svg" height="48" width="48"><path d="M1.1 41.5V35.7Q1.1 33.6 2.175 31.925Q3.25 30.25 5.15 29.4Q8.9 27.8 11.925 27.05Q14.95 26.3 18.15 26.3Q21.45 26.3 24.45 27.05Q27.45 27.8 31.2 29.4Q33.1 30.2 34.2 31.85Q35.3 33.5 35.3 35.7V41.5ZM18.2 23.3Q14.6 23.3 12.425 21.125Q10.25 18.95 10.25 15.4Q10.25 11.8 12.45 9.6Q14.65 7.4 18.2 7.4Q21.7 7.4 23.95 9.6Q26.2 11.8 26.2 15.35Q26.2 18.95 23.95 21.125Q21.7 23.3 18.2 23.3ZM37.5 15.35Q37.5 18.9 35.275 21.1Q33.05 23.3 29.55 23.3Q28.9 23.3 28.375 23.225Q27.85 23.15 27.15 22.9Q28.45 21.55 29.075 19.65Q29.7 17.75 29.7 15.4Q29.7 13 29.075 11.175Q28.45 9.35 27.15 7.8Q27.7 7.6 28.35 7.5Q29 7.4 29.55 7.4Q33.05 7.4 35.275 9.625Q37.5 11.85 37.5 15.35ZM38.85 41.5V35.8Q38.85 32.55 37.225 30.4Q35.6 28.25 32.95 26.4Q35.95 26.9 38.6 27.625Q41.25 28.35 43.05 29.2Q44.8 30.15 45.875 31.875Q46.95 33.6 46.95 35.95V41.5Z"/></svg>'
    ,color: unactive
);

final Widget braini=SvgPicture.string('<svg xmlns="http://www.w3.org/2000/svg" height="48" width="48"><path d="M15.75 41.05Q15.05 41.05 14.525 40.75Q14 40.45 13.75 39.9L9.35 32.15H13.1L15.45 36.45H19.95V34.95H16.35L14 30.65H8.55L5.45 25.1Q5.35 24.85 5.25 24.6Q5.15 24.35 5.15 24.05Q5.15 23.7 5.225 23.425Q5.3 23.15 5.45 22.85L8.55 17.35H14L16.35 13.05H19.95V11.55H15.5L13.1 15.85H9.35L13.75 8.05Q13.95 7.6 14.5 7.25Q15.05 6.9 15.75 6.9H20.95Q21.95 6.9 22.6 7.575Q23.25 8.25 23.25 9.2V17.9H18.75L17.25 19.4H23.25V26.65H18L15.9 22.4H11L9.5 23.9H14.85L17.05 28.15H23.25V38.8Q23.25 39.75 22.6 40.4Q21.95 41.05 20.95 41.05ZM27.05 41.05Q26.05 41.05 25.4 40.4Q24.75 39.75 24.75 38.8V28.15H31L33.2 23.9H38.55L37.05 22.4H32.2L30.05 26.65H24.75V19.4H30.75L29.25 17.9H24.75V9.2Q24.75 8.25 25.4 7.575Q26.05 6.9 27.05 6.9H32.35Q33 6.9 33.525 7.225Q34.05 7.55 34.3 8.05L38.65 15.85H35L32.6 11.55H28.05V13.05H31.7L34 17.3H39.45L42.6 22.9Q42.7 23.2 42.8 23.45Q42.9 23.7 42.9 24Q42.9 24.3 42.8 24.575Q42.7 24.85 42.6 25.1L39.45 30.65H34L31.7 34.95H28.05V36.45H32.6L34.95 32.15H38.65L34.3 39.9Q34.05 40.4 33.55 40.725Q33.05 41.05 32.35 41.05Z"/></svg>'
  ,color: textcolor,
);
final Widget brain=SvgPicture.string('<svg xmlns="http://www.w3.org/2000/svg" height="48" width="48"><path d="M15.75 41.05Q15.05 41.05 14.525 40.75Q14 40.45 13.75 39.9L9.35 32.15H13.1L15.45 36.45H19.95V34.95H16.35L14 30.65H8.55L5.45 25.1Q5.35 24.85 5.25 24.6Q5.15 24.35 5.15 24.05Q5.15 23.7 5.225 23.425Q5.3 23.15 5.45 22.85L8.55 17.35H14L16.35 13.05H19.95V11.55H15.5L13.1 15.85H9.35L13.75 8.05Q13.95 7.6 14.5 7.25Q15.05 6.9 15.75 6.9H20.95Q21.95 6.9 22.6 7.575Q23.25 8.25 23.25 9.2V17.9H18.75L17.25 19.4H23.25V26.65H18L15.9 22.4H11L9.5 23.9H14.85L17.05 28.15H23.25V38.8Q23.25 39.75 22.6 40.4Q21.95 41.05 20.95 41.05ZM27.05 41.05Q26.05 41.05 25.4 40.4Q24.75 39.75 24.75 38.8V28.15H31L33.2 23.9H38.55L37.05 22.4H32.2L30.05 26.65H24.75V19.4H30.75L29.25 17.9H24.75V9.2Q24.75 8.25 25.4 7.575Q26.05 6.9 27.05 6.9H32.35Q33 6.9 33.525 7.225Q34.05 7.55 34.3 8.05L38.65 15.85H35L32.6 11.55H28.05V13.05H31.7L34 17.3H39.45L42.6 22.9Q42.7 23.2 42.8 23.45Q42.9 23.7 42.9 24Q42.9 24.3 42.8 24.575Q42.7 24.85 42.6 25.1L39.45 30.65H34L31.7 34.95H28.05V36.45H32.6L34.95 32.15H38.65L34.3 39.9Q34.05 40.4 33.55 40.725Q33.05 41.05 32.35 41.05Z"/></svg>'
    ,color: unactive);
// Container(
//   color: maincolor,
//   width: double.infinity,
//   height: 80,
//   child: Row(
//     children:  [
//       const Padding(
//         padding: EdgeInsetsDirectional.only(start: 15),
//         child: CircleAvatar(child: Text("L",style: TextStyle(fontSize: 20),),backgroundColor: Colors.white,radius: 23,),
//       ),
//       Padding(
//         padding: const EdgeInsetsDirectional.only(start: 5),
//         child: Text(cubit.usermodel!.name!,style: const TextStyle(fontSize: 16,color: Colors.white),),
//       ),
//       const Spacer(),
//       Padding(
//         padding: const EdgeInsetsDirectional.only(end: 20),
//         child: Stack(alignment:Alignment.center ,
//           children: [
//             const CircleAvatar(radius: 27,backgroundColor: Colors.white,),
//             CircleAvatar(
//               backgroundImage: NetworkImage(cubit.usermodel!.image!) ,
//               radius: 25,
//             ),
//           ],
//         ),
//       ),
//     ],
//   ),
// ),
final Widget result = SvgPicture.string('<svg xmlns="http://www.w3.org/2000/svg" height="48" width="48"><path d="M5.3 17.75V9.1H13.95V17.75ZM16.25 17.75V9.1H42.75V17.75ZM16.25 28.35V19.7H42.75V28.35ZM16.25 39.05V30.35H42.75V39.05ZM5.3 39.05V30.35H13.95V39.05ZM5.3 28.35V19.7H13.95V28.35Z"/></svg>'
  ,color: unactive
);
final Widget resulti = SvgPicture.string('<svg xmlns="http://www.w3.org/2000/svg" height="48" width="48"><path d="M5.3 17.75V9.1H13.95V17.75ZM16.25 17.75V9.1H42.75V17.75ZM16.25 28.35V19.7H42.75V28.35ZM16.25 39.05V30.35H42.75V39.05ZM5.3 39.05V30.35H13.95V39.05ZM5.3 28.35V19.7H13.95V28.35Z"/></svg>'
  ,color: maincolor
);
TextStyle h1 = TextStyle(fontSize: 25,fontWeight:FontWeight.w700,color: maincolor);
TextStyle memberName = TextStyle(fontSize: 14,fontWeight:FontWeight.w700,color: maincolor);
TextStyle abouttext =TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: HexColor("#8A8A8A"));

TextStyle textStyle =TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.w700,
  color: maincolor,
);
var nameController=TextEditingController();
var date = new DateTime.now().toString();

var dateParse = DateTime.parse(date);

var formattedDate = "${dateParse.day}/${dateParse.month}/${dateParse.year}";