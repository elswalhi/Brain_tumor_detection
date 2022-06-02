import 'package:brain_tumor/cubit/cubit/cubit.dart';
import 'package:brain_tumor/cubit/states/states.dart';
import 'package:brain_tumor/image_painter.dart';
import 'package:brain_tumor/shared/colors/colors.dart';
import 'package:brain_tumor/shared/component/component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

import '../model/MriModel/MriModel.dart';
import '../shared/const/const.dart';

class Details extends StatefulWidget {
  MriModel? model;
  PatientModel? patientModel;
   Details({Key? key,required this.model,required this.patientModel}) : super(key: key);

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    final _imageKey = GlobalKey<ImagePainterState>();

    return BlocConsumer<AppCubit,Appstates>(
      listener: (BuildContext context, state) {  },
      builder: (BuildContext context, Object? state) {
        var cubit = AppCubit.get(context);
        return state is !GetUserLoading ? Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(70.0),
            child: AppBar(
              leadingWidth: 50,
              title: const Padding(
                padding: EdgeInsetsDirectional.only(top: 10),
                child: Text(
                  "Details",
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
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ImagePainter.network("${widget.model!.image}", key: _imageKey
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
                            Text(widget.model!.date!,style: textStyle.copyWith(color:HexColor("#8A8A8A"),),),
                          ],
                        ),
                        const SizedBox(height: 10,),
                        Row(
                          children: [
                            Text("Folder name : ",style: textStyle.copyWith(color:HexColor("#8A8A8A"),fontWeight: FontWeight.w400),),
                            Text("${widget.patientModel!.name}",style: textStyle)
                          ],
                        ),
                        const SizedBox(height: 10,),
                        Row(
                          children: [
                            Text("Brain Tumor: ",style: textStyle.copyWith(color:HexColor("#8A8A8A"),fontWeight: FontWeight.w400),),
                            Text("${widget.model!.result}",style: textStyle.copyWith(color: HexColor("#F41D1D"))),
                          ],
                        ),
                        const SizedBox(height: 25,),
                        Row(
                          children: [
                            Text("Percentage: ",style: textStyle.copyWith(color:HexColor("#8A8A8A"),fontWeight: FontWeight.w400),),
                            const SizedBox(width: 47,),
                            Text("${widget.model!.confidence!.floor()}%",style: textStyle.copyWith(color: cubit.resultColor(widget.model!.confidence!.floor()),fontSize: 40)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ):const Center(child: CircularProgressIndicator());
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
