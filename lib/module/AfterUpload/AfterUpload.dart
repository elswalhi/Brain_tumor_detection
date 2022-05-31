import 'package:brain_tumor/cubit/cubit/cubit.dart';
import 'package:brain_tumor/cubit/states/states.dart';
import 'package:brain_tumor/shared/colors/colors.dart';
import 'package:brain_tumor/shared/component/component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

import '../../shared/const/const.dart';

class AfterUpload extends StatelessWidget {
  const AfterUpload({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,Appstates>(
      listener: (BuildContext context, Object? state) {  },
      builder: (BuildContext context, state) {
     
        var cubit= AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text("Processing"),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // SingleChildScrollView(
                //   child: GridView.count(
                //     shrinkWrap: true,
                //     physics: NeverScrollableScrollPhysics(),
                //     crossAxisCount: 2,
                //     children: List.generate(cubit.resultList.length, (index) {
                //       Asset asset = cubit.resultList[index];
                //       return Padding(
                //         padding: const EdgeInsets.all(5.0),
                //         child: Container(
                //           decoration: BoxDecoration(
                //             border: Border.all(color: maincolor,width: 1)
                //           ),
                //           child: AssetThumb(
                //             asset: asset,
                //             width: 200,
                //             height: 200,
                //           ),
                //         ),
                //       );
                //     }),
                //   ),
                // ),
                // Padding(
                //   padding: const EdgeInsetsDirectional.only(bottom: 30),
                //   child: Text("${cubit.resultList.length}/5",style: textStyle,),
                // ),
                Container(
                  width: double.infinity,
                  height: 350,
                  child: Image(image: FileImage(cubit.mriImage!),),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.only(bottom: 70,top: 30),
                  child: Container(child: defaultButton(function: (){
                    cubit.classifyImage(image :cubit.mriImage,datetime:formattedDate, context: context );
                  }, text: "Start Processing")),
                )
              ],
            ),
          ),
        );
      },

    );
  }
}
