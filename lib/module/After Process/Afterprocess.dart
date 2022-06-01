import 'package:brain_tumor/cubit/cubit/cubit.dart';
import 'package:brain_tumor/cubit/states/states.dart';
import 'package:brain_tumor/image_painter.dart';
import 'package:brain_tumor/layout/homelayout/homeLayout.dart';
import 'package:brain_tumor/shared/colors/colors.dart';
import 'package:brain_tumor/shared/component/component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../shared/const/const.dart';

class ProcessingDetails extends StatelessWidget {
  const ProcessingDetails({Key? key}) : super(key: key);

  @override
  Widget build( context) {
    return BlocConsumer<AppCubit,Appstates>(
      listener: (BuildContext context, state) {  },
      builder: (BuildContext context, Object? state) {
        final _imageKey = GlobalKey<ImagePainterState>();
        var cubit = AppCubit.get(context);
        return  Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(70.0),
            child: AppBar(
              leadingWidth: 50,
              title: const Padding(
                padding: EdgeInsetsDirectional.only(top: 10),
                child: Text(
                  "Your Process",
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
          body: state is getPatientSuccess ?Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ImagePainter.file(cubit.mriImage!, key: _imageKey
                    ,   scalable: true,
                    height: 350,
                    width: double.infinity,
                    initialStrokeWidth: 2,
                    textDelegate: DutchTextDelegate(),
                    initialColor: Colors.green,
                    initialPaintMode: PaintMode.line,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text("Date : ",style: textStyle.copyWith(color:HexColor("#8A8A8A"),fontWeight: FontWeight.w400),),
                            Text("$formattedDate  ",style: textStyle.copyWith(color:HexColor("#8A8A8A"),),),
                          ],
                        ),
                        const SizedBox(height: 10,),
                        Row(
                          children: [
                            Text("Folder name : ",style: textStyle.copyWith(color:HexColor("#8A8A8A"),fontWeight: FontWeight.w400),),
                            Text("${nameController.text}  ",style: textStyle)
                          ],
                        ),
                        const SizedBox(height: 10,),
                        Row(
                          children: [
                            Text("Brain Tumor: ",style: textStyle.copyWith(color:HexColor("#8A8A8A"),fontWeight: FontWeight.w400),),
                            Text("${cubit.brainResult}",style: textStyle.copyWith(color: HexColor("#F41D1D"))),
                          ],
                        ),
                        const SizedBox(height: 25,),
                        Row(
                          children: [
                            Text("Percentage: ",style: textStyle.copyWith(color:HexColor("#8A8A8A"),fontWeight: FontWeight.w400),),
                            const SizedBox(width: 47,),
                            Text("${((cubit.confidence)!.toInt())}",style: textStyle.copyWith(color: HexColor("#F41D1D"),fontSize: 40)),
                          ],
                        ),
                        const SizedBox(height: 20,),
                        defaultButton(function: (){
                          navigateAndFinish(context, HomeScreen());
                        }, text: "Finish")
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ):const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }


}
class DutchTextDelegate implements TextDelegate {
  @override
  String get arrow => "Arrow";

  @override
  String get changeBrushSize => "changeBrushSize";

  @override
  String get changeColor => " changeColor";

  @override
  String get changeMode => "changeMode";

  @override
  String get circle => "circle";

  @override
  String get clearAllProgress => "clearAll";

  @override
  String get dashLine => "Dashline";

  @override
  String get done => "done";

  @override
  String get drawing => "free drawing";

  @override
  String get line => "line";

  @override
  String get noneZoom => "Geen / Zoom";

  @override
  String get rectangle => "rectangle";

  @override
  String get text => "text";

  @override
  String get undo => "ongedaan maken";
}
