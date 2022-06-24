import 'package:brain_tumor/cubit/cubit/cubit.dart';
import 'package:brain_tumor/cubit/states/states.dart';
import 'package:brain_tumor/shared/colors/colors.dart';
import 'package:brain_tumor/shared/component/component.dart';
import 'package:buildcondition/buildcondition.dart';
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
      listener:(context,state){},
      builder:(context,state){
        var cubit =AppCubit.get(context);
        return BuildCondition(
          condition: cubit.mriSave.isNotEmpty,
          builder:(context)=> Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              if( state is UpdateSaveTrueLoading || state is getPatientLoading || state is getPatientSuccess)
                SizedBox(height: 20,),
              if( state is UpdateSaveTrueLoading || state is getPatientLoading || state is getPatientSuccess)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: LinearProgressIndicator(),
                ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child:ListView.separated(
                    shrinkWrap: true,
                      itemBuilder: (context,index)=>buildSavedItem( context,state, cubit.mriSave[index]),
                      separatorBuilder: (context,index)=> const SizedBox(height: 5,),
                      itemCount: cubit.mriSave.length
                  ),
                ),
            ],
          ),
          fallback:(context)=> Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 200.0),
              child: Column(
                children: [
                  SizedBox(height: 150,width: 150,child: saved),
                  SizedBox(height: 5,),
                  Text("NO Data Saved",style: textStyle.copyWith(color: Colors.grey),),
                ],
              ),
            ),
          ),
        );

      } ,
    );
  }
}

