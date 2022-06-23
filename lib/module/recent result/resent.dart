import 'package:brain_tumor/cubit/cubit/cubit.dart';
import 'package:brain_tumor/cubit/states/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../shared/colors/colors.dart';
import '../../shared/component/component.dart';
import '../../shared/const/const.dart';

class Recent extends StatelessWidget {
  const Recent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,Appstates>(listener: (BuildContext context, state) {  },
    builder: (BuildContext context, Object? state) {
      var cubit = AppCubit.get(context);
      return
      Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              buildStaticsItem(),
              const SizedBox(height: 10,),
              Container(
                height:  cubit.mriModels.length>=3 ? null:500,
                width: double.infinity,
                decoration: BoxDecoration(
                  boxShadow:const [
                    BoxShadow(
                        color: Colors.black,
                        blurRadius: 10.0, // soften the shadow
                        spreadRadius: .3, //extend the shadow
                        offset: Offset(
                          1.0, // Move to right 10  horizontally
                          0.0, // M
                        ) )]  ,
                  borderRadius: const BorderRadius.only(topRight:Radius.circular(50),topLeft: Radius.circular(50) ),
                  color:HexColor("#FFFFFF") ,
                ),
                child: cubit.mriModels.isNotEmpty? Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.only(top: 30,bottom: 20),
                      child: Text("Recent Results",style: TextStyle(color: textcolor,fontSize: 25,fontWeight: FontWeight.w700),),
                    ),
                     ListView.separated(
                      shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context,index)=>buildResultItem(context, cubit.mriModels[index],cubit.patientModels[index]),
                        separatorBuilder: (context,index)=>const SizedBox(height: 5,),
                        itemCount: cubit.patientModels.length
                    ),
                  ],
                ): const Center(child: Text("No Data Yet")),
              ),
            ],
          ),
        ),
      );
    });

  }
}
