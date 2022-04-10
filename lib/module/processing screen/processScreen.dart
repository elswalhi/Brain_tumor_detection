import 'package:brain_tumor/cubit/cubit/cubit.dart';
import 'package:brain_tumor/module/Result/result.dart';
import 'package:brain_tumor/shared/colors/colors.dart';
import 'package:brain_tumor/shared/component/component.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProcessScreen extends StatelessWidget {
   const ProcessScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var cubit =AppCubit.get(context);

    return Scaffold(
      body: SafeArea(
          child: Column(
            children: [
              myAppBar(PageNum: 2),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40,vertical: 40),
                child: SizedBox(
                  child: Stack(
                    children: [
                      Container(
                        height: 350,
                        width: double.infinity,
                        child: CircularProgressIndicator(
                          strokeWidth: 10,
                          backgroundColor: defultcolor,
                          color:primarycolor ,
                          value: cubit.value,
                        ),
                      ),
                      Text("${AppCubit.get(context).value*100.round()}%",style: TextStyle(
                        fontSize: 40,
                        color: defultcolor
                      ),),
                    ],
                    alignment: Alignment.center,
                  ),
                  height: 350,
                  width: double.infinity,
                ),
              ),
              Row(
                children: [
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsetsDirectional.only(end: 40),
                    child:ElevatedButton(onPressed: cubit.value==1?(){
                      navigateTo(context, Result());
                    } : null
                        , child: const Text("SHOW THE RESULT",style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700
                      ),),style:ElevatedButton.styleFrom(fixedSize:Size(202,60)) ,),
                  ),
                ],
              )

            ],
          )),
    );
  }
}
