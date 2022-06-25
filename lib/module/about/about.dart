import 'package:brain_tumor/shared/colors/colors.dart';
import 'package:brain_tumor/shared/const/const.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 40),
        child: Column(
          children: [
            // who we are
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Who We Are?",style:h1,),
                  const SizedBox(height: 10,),
                  Text("It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English.",
                  style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: HexColor("#8A8A8A")),
                  ),
                  const SizedBox(height: 40,),
                ],
              ),
            ),
            // our mission
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Our Mission",style:h1,),
                  const SizedBox(height: 10,),
                  Text("It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. ",
                  style: abouttext,
                  ),
                  const SizedBox(height: 40,),
                ],
              ),
            ),
            // our vision
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Our Vision",style:h1,),
                  const SizedBox(height: 10,),
                  Text("It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. ",
                  style: abouttext,
                  ),
                  const SizedBox(height: 40,),
                ],
              ),
            ),
            //Team members
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Imhotep Team ",style:h1,),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      // Abdelrhman
                      Expanded(
                        child: Column(
                          children: [
                            SizedBox(height: 10,),
                            Container(
                              height: 130,
                              width: 130,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage("assets/picture/swalhi.jpg"),
                                    fit: BoxFit.cover,),
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(100)
                              ),
                            ),
                            SizedBox(height: 10,),
                            Text("Abdelrhman Elswalhi",style: memberName,),
                            SizedBox(height: 5,),
                            Text("Team Leader",style: memberName.copyWith( color: HexColor("#888888")
                            ),)
                          ],
                        ),
                      ),
                      SizedBox(width: 40,),
                      Expanded(
                        child: Column(
                          children: [
                            SizedBox(height: 10,),
                            Container(
                              height: 130,
                              width: 130,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage("assets/picture/Rauof.jpg"),
                                    fit: BoxFit.cover,),
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.circular(100)
                              ),
                            ),
                            SizedBox(height: 10,),
                            Text("Raouf",style: memberName,),
                            SizedBox(height: 5,),
                            Text("Team Member",style: memberName.copyWith( color: HexColor("#888888")
                            ),)
                          ],
                        ),
                      ),

                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      // Abdelrhman
                      Expanded(
                        child: Column(
                          children: [
                            SizedBox(height: 10,),
                            Container(
                              height: 130,
                              width: 130,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage("assets/picture/ahmed.jpg"),
                                    fit: BoxFit.cover,),
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(100)
                              ),
                            ),
                            SizedBox(height: 10,),
                            Text("Ahmed Gamal",style: memberName,),
                            SizedBox(height: 5,),
                            Text("Team Member",style: memberName.copyWith( color: HexColor("#888888")
                            ),)
                          ],
                        ),
                      ),
                      SizedBox(width: 40,),
                      Expanded(
                        child: Column(
                          children: [
                            SizedBox(height: 10,),
                            Container(
                              height: 130,
                              width: 130,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage("assets/picture/marawan.jpg"),
                                    fit: BoxFit.cover,),
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.circular(100)
                              ),
                            ),
                            SizedBox(height: 10,),
                            Text("Marwan Galaxy",style: memberName,),
                            SizedBox(height: 5,),
                            Text("Team Member",style: memberName.copyWith( color: HexColor("#888888")
                            ),)
                          ],
                        ),
                      ),

                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Expanded(
                        //jihad
                        child: Column(
                          children: [
                            SizedBox(height: 10,),
                            Container(
                              height: 130,
                              width: 130,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage("assets/picture/jihad.jpg"),
                                    fit: BoxFit.contain,),
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.circular(100)
                              ),
                            ),
                            SizedBox(height: 10,),
                            Text("jihad",style: memberName,),
                            SizedBox(height: 5,),
                            Text("Team Member",style: memberName.copyWith( color: HexColor("#888888")
                            ),)
                          ],
                        ),
                      ),
                      SizedBox(width: 40,),
                      // manar
                      Expanded(
                        child: Column(
                          children: [
                            SizedBox(height: 10,),
                            Container(
                              height: 130,
                              width: 130,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage("assets/picture/user.jpg"),
                                    fit: BoxFit.cover,),
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.circular(100)
                              ),
                            ),
                            SizedBox(height: 10,),
                            Text("Manar Yasser",style: memberName,),
                            SizedBox(height: 5,),
                            Text("Team Member",style: memberName.copyWith( color: HexColor("#888888")
                            ),)
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Center(
                    child: Column(
                      children: [
                        SizedBox(height: 10,),
                        Container(
                          height: 130,
                          width: 130,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/picture/user.jpg"),
                                fit: BoxFit.cover,),
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(100)
                          ),
                        ),
                        SizedBox(height: 10,),
                        Text("Alaa Elsanour",style: memberName,),
                        SizedBox(height: 5,),
                        Text("Team Member",style: memberName.copyWith( color: HexColor("#888888")
                        ),)
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
