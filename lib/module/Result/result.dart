import 'package:brain_tumor/cubit/cubit/cubit.dart';
import 'package:brain_tumor/cubit/states/states.dart';
import 'package:brain_tumor/shared/colors/colors.dart';
import 'package:brain_tumor/shared/component/component.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/EndLAyout/end.dart';

class Result extends StatelessWidget {
  const Result({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,Appstates>(
      listener:(context,sate){},
      builder:(context,sate){
        var cubit =AppCubit.get(context);
        return SingleChildScrollView(
          child: Column(
            children: [
              buildStaticsItem(),
              const SizedBox(height: 20,),
              ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context,index)=>buildFolderItem(context,index, cubit.patientModel[index], cubit.mriModel[index]),
                  separatorBuilder: (context,index)=>const SizedBox(height: 15,),
                  itemCount: cubit.patientModel.length),
            ],
          ),
        );
      } ,
    );
  }
}
