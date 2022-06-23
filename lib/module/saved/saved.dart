import 'package:brain_tumor/cubit/cubit/cubit.dart';
import 'package:brain_tumor/cubit/states/states.dart';
import 'package:brain_tumor/shared/colors/colors.dart';
import 'package:brain_tumor/shared/component/component.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/EndLAyout/end.dart';
import '../../shared/const/const.dart';
import '../uploadscreen/UploadScreen.dart';

class SavedScreen extends StatelessWidget {
  const SavedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,Appstates>(
      listener:(context,sate){},
      builder:(context,sate){
        var cubit =AppCubit.get(context);
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: ListView.separated(
              itemBuilder: (context,index)=>buildSavedItem( context,cubit.mriModels[index],cubit.patientModels[index]),
              separatorBuilder: (context,index)=> const SizedBox(height: 5,),
              itemCount: cubit.mriModels.length ?? 0),
        );

      } ,
    );
  }
}

