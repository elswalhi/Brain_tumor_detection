import 'package:brain_tumor/cubit/cubit/cubit.dart';
import 'package:brain_tumor/cubit/states/states.dart';
import 'package:brain_tumor/layout/homelayout/homeLayout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'module/processing screen/processScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>AppCubit()..downloadData(),
      child: BlocConsumer<AppCubit,Appstates>(
        listener: ( context, state) {  },
        builder: ( context,  state) {
          return MaterialApp(
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            debugShowCheckedModeBanner: false,
            home:   HomeScreen(),
          );
        },

      ),
    );
  }
}
//MaterialApp(
//           theme: ThemeData(
//             primarySwatch: Colors.blue,
//           ),
//           debugShowCheckedModeBanner: false,
//           home:   ProcessScreen(),
//         );
