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
          physics:const BouncingScrollPhysics(),
          child: Column(
            children: [
              buildStaticsItem(),
              const SizedBox(height: 10,),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  boxShadow:const [
                    BoxShadow(
                        color: Colors.black,
                        blurRadius: 20.0, // soften the shadow
                        spreadRadius: 5.0, //extend the shadow
                        offset: Offset(
                          15.0, // Move to right 10  horizontally
                          0.0, // M
                        ) )]  ,
                  borderRadius: const BorderRadius.only(topRight:Radius.circular(50),topLeft: Radius.circular(50) ),
                  color:HexColor("#FFFFFF") ,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.only(top: 30,bottom: 20),
                      child: InkWell(
                        onTap: (){
                          AppCubit.get(context).getPatient();
                        },
                          child: Text("Recent Results",style: TextStyle(color: textcolor,fontSize: 25,fontWeight: FontWeight.w700),)),
                    ),
                    ListView.separated(
                      shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context,index)=>buildResultItem(context, cubit.mriModel[index]),
                        separatorBuilder: (context,index)=>const SizedBox(height: 15,),
                        itemCount: cubit.mriModel.length
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });

  }
}
