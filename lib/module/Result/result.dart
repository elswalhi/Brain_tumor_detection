import 'package:brain_tumor/cubit/cubit/cubit.dart';
import 'package:brain_tumor/cubit/states/states.dart';
import 'package:brain_tumor/shared/colors/colors.dart';
import 'package:brain_tumor/shared/component/component.dart';
import 'package:brain_tumor/shared/const/const.dart';
import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/EndLAyout/end.dart';

class Result extends StatelessWidget {
  const Result({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,Appstates>(
      listener:(context,state){},
      builder:(context,state){
        var cubit =AppCubit.get(context);
        return BuildCondition(
          condition: cubit.patientModels.isNotEmpty,
          builder:(context)=> SingleChildScrollView(
            child: Column(
              children: [
                buildStaticsItem(),
                const SizedBox(height: 20,),
                ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context,index)=>buildFolderItem(context,index, cubit.patientModels[index], cubit.mriModels[index]),
                    separatorBuilder: (context,index)=>const SizedBox(height: 5,),
                    itemCount: cubit.patientModels.length),
              ],
            ),
          ),
          fallback:(context)=>Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 250.0),
              child: Column(
                children: [
                  SizedBox(height: 150,
                      width: 150,
                      child: result),
                  Text("No Data Yet Or getting Data ...",style: textStyle.copyWith(color: Colors.grey),),
                ],
              ),
            ),
          ),
        );
      } ,
    );
  }
}
