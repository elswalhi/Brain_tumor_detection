import 'package:brain_tumor/cubit/cubit/cubit.dart';
import 'package:brain_tumor/cubit/states/states.dart';
import 'package:brain_tumor/shared/colors/colors.dart';
import 'package:brain_tumor/shared/component/component.dart';
import 'package:brain_tumor/shared/const/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/homelayout/homeLayout.dart';

class UploadScreen extends StatelessWidget {
  const UploadScreen() : super();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, Appstates>(
      listener: (context, state) {},
      builder: (context, state) {
        var key = GlobalKey<FormState>();
        var cubit = AppCubit.get(context);
        return Scaffold(
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
                border: Border(top: BorderSide(color: maincolor, width: 2.0))),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              items: [
                BottomNavigationBarItem(
                  icon: SizedBox(height: 50, width: 50, child: home),
                  label: "Home",
                ),
                BottomNavigationBarItem(
                  icon: SizedBox(
                    child: result,
                    height: 50,
                    width: 50,
                  ),
                  label: "Result",
                ),
                BottomNavigationBarItem(
                    icon: SizedBox(
                      child: about,
                      height: 50,
                      width: 50,
                    ),
                    label: "About us"),
                BottomNavigationBarItem(
                  icon: SizedBox(
                    child: saved,
                    height: 50,
                    width: 50,
                  ),
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
            child: braini, //icon inside button
            shape: StadiumBorder(
              side: BorderSide(color: maincolor, width: 4),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(70.0),
            child: AppBar(
              leadingWidth: 50,
              title: Padding(
                padding: const EdgeInsetsDirectional.only(top: 10),
                child: Text(
                  "Upload MRI(s)",
                  style: const TextStyle(fontSize: 16, color: Colors.white),
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
          body: SafeArea(
              child: Form(
            key: key,
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/picture/b1.png"),
                    fit: BoxFit.contain,
                    opacity: .2),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    defaultFormField(
                        controller: nameController,
                        type: TextInputType.text,
                        validate: (String? value) {
                          if(value!.isEmpty){
                            return "please insert patient name";
                          }
                          return null;
                        },
                        label: "Enter Patient Name",
                        color: maincolor),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.only(top: 20, bottom: 10),
                      child: InkWell(
                        onTap: () {
                          if(key.currentState!.validate()){
                            cubit.getImage(context);
                          }
                          // AppCubit.get(context).getImage();
                          //cubit.getProfileImages();
                          // cubit.getProfileImages();
                          // cubit.selectImages();
                          // cubit.mriImage==null? cubit.selectImages():navigateTo(context, ProcessScreen());
                        },
                        child: Container(
                          width: double.infinity,
                          height: 230,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            shape: BoxShape.rectangle,
                            border: Border.all(
                              color: maincolor,
                            ),
                          ),
                          child: Center(
                              child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(30),
                                    border: Border.all(color: maincolor),
                                  ),
                                  child: IconButton(
                                    onPressed: () {
                                      // AppCubit.get(context).getImage();
                                      //cubit.getProfileImages();
                                      if(
                                      key.currentState!.validate()
                                      ){
                                        cubit.loadAssets(context);
                                      }
                                      // cubit.selectImages();
                                      // cubit.mriImage==null? cubit.selectImages():navigateTo(context, ProcessScreen());
                                    },
                                    icon: const Icon(Icons.add),
                                    color: maincolor,
                                  ))),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
        );
      },
    );
  }
}
