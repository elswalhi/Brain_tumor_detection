import 'package:brain_tumor/cubit/cubit/cubit.dart';
import 'package:brain_tumor/cubit/states/states.dart';
import 'package:brain_tumor/model/MriModel/MriModel.dart';
import 'package:brain_tumor/shared/colors/colors.dart';
import 'package:brain_tumor/shared/component/component.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/EndLAyout/end.dart';
import '../../shared/const/const.dart';
import '../uploadscreen/UploadScreen.dart';

class ResultName extends StatelessWidget {
  List<MriModel>? mriModel;
  ResultName({Key? key, required this.mriModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,Appstates>(
      listener:(context,sate){},
      builder:(context,sate){
        var cubit =AppCubit.get(context);
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(70.0),
            child: AppBar(
              leadingWidth: 50,
              title: const Padding(
                padding: EdgeInsetsDirectional.only(top: 10),
                child: Text(
                  "Result name",
                  style: TextStyle(fontSize: 16, color: Colors.white),
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
          body: SingleChildScrollView(
            child: Column(
              children: [
                buildStaticsItem(),
                const SizedBox(height: 20,),
                ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context,index)=>buildResultItem(context, mriModel![index]),
                    separatorBuilder: (context,index)=>const SizedBox(height: 15,),
                    itemCount: mriModel!.length
                ),
              ],
            ),
          ),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
                border: Border(top: BorderSide(color: maincolor, width: 2.0))),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              items: [
                BottomNavigationBarItem(
                  icon: SizedBox(height: 50, width: 50, child: home),
                  activeIcon: homei,
                  label: "Home",
                ),
                BottomNavigationBarItem(
                  icon: SizedBox(
                    child: result,
                    height: 50,
                    width: 50,
                  ),
                  activeIcon: resulti,
                  label: "Result",
                ),
                BottomNavigationBarItem(
                    icon: SizedBox(
                      child: about,
                      height: 50,
                      width: 50,
                    ),
                    activeIcon: abouti,
                    label: "About us"),
                BottomNavigationBarItem(
                  icon: SizedBox(
                    child: saved,
                    height: 50,
                    width: 50,
                  ),
                  activeIcon: savedi,
                  label: "Saved",
                ),
              ],
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.ChangeScreens(index, context);
                Navigator.pop(context);
              },
            ),
          ),
          floatingActionButton: FloatingActionButton(
            mini: false,
            //Floating action button on Scaffold
            onPressed: () {
              navigateTo(context, const UploadScreen());
              //code to execute on button press
            },
            child: brain, //icon inside button
            shape: StadiumBorder(
              side: BorderSide(color: unactive, width: 4),
            ),
          ),
          floatingActionButtonLocation:
          FloatingActionButtonLocation.centerDocked,
        );
      } ,
    );
  }
}
