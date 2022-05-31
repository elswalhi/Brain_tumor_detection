//
// import 'package:brain_tumor/cubit/cubit/cubit.dart';
// import 'package:brain_tumor/cubit/states/states.dart';
// import 'package:brain_tumor/module/Result/result.dart';
// import 'package:brain_tumor/shared/colors/colors.dart';
// import 'package:brain_tumor/shared/component/component.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:http/http.dart';
//
// class ProcessScreen extends StatelessWidget {
//    const ProcessScreen({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     var cubit =AppCubit.get(context);
//
//     return BlocConsumer<AppCubit,Appstates>(
//       listener: (BuildContext context, Object? state) {
//
//         },
//       builder: (BuildContext context, state) {
//         var cubit =AppCubit.get(context);
//         return Scaffold(
//           body: SafeArea(
//               child: Column(
//                 children: [
//                   myAppBar(PageNum: 2),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 40,vertical: 40),
//                     child: SizedBox(
//                       child: Stack(
//                         children: [
//                           Container(
//                             height: 350,
//                             width: double.infinity,
//                             child: CircularProgressIndicator(
//                               strokeWidth: 10,
//                               backgroundColor: defultcolor,
//                               color:primaryColor ,
//                               value:cubit.code==200? 1 :.8  ,
//                             ),
//                           ),
//                           Text(cubit.code==200?'100%':"80%",style: TextStyle(
//                               fontSize: 40,
//                               color: defultcolor
//                           ),),
//                         ],
//                         alignment: Alignment.center,
//                       ),
//                       height: 350,
//                       width: double.infinity,
//                     ),
//                   ),
//                   Row(
//                     children: [
//                       const Spacer(),
//                       Padding(
//                         padding: const EdgeInsetsDirectional.only(end: 40),
//                         child:ElevatedButton(onPressed:cubit.code==200?(){
//                           navigateTo(context, Result());
//                         } : null
//                           , child: const Text("SHOW THE RESULT",style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.w700
//                           ),),style:ElevatedButton.styleFrom(fixedSize:const Size(202,60)) ,),
//                       ),
//                     ],
//                   )
//
//                 ],
//               )),
//         );
//
//       },
//     );
//   }
//    Future<void> makeGetRequest() async {
//      final url = Uri.parse('https://eflask-appas.herokuapp.com/predict/posts');
//      Response response = await get(url);
//      print('Status code: ${response.statusCode}');
//      print('Headers: ${response.headers}');
//      print('Body: ${response.body}');
//    }
// }
