import 'package:brain_tumor/Network/remote/dio.dart';
import 'package:brain_tumor/blocob.dart';
import 'package:brain_tumor/cubit/cubit/cubit.dart';
import 'package:brain_tumor/cubit/states/states.dart';
import 'package:brain_tumor/layout/homelayout/homeLayout.dart';
import 'package:brain_tumor/module/AfterUpload/AfterUpload.dart';
import 'package:brain_tumor/module/ImageDetails.dart';
import 'package:brain_tumor/module/Login/login.dart';
import 'package:brain_tumor/module/Login/loginCubit/cubit/cubit.dart';
import 'package:brain_tumor/module/Profile/Profile.dart';
import 'package:brain_tumor/module/Register/RegisterCubit/cubit/cubit.dart';
import 'package:brain_tumor/shared/colors/colors.dart';
import 'package:brain_tumor/shared/const/const.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'Network/local/sharedpref.dart';
import 'cubit/Main/cubit/cubit.dart';
import 'cubit/Main/states/states.dart';
import 'module/recent result/resent.dart';


Future<void> main()  async {


  BlocOverrides.runZoned(() async{
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();

     DioHelper.init();
    await CacheHelper.init();

    uId=CacheHelper.getData(key: 'uId');
    Widget widget;
    if(uId !=null){
      widget=HomeScreen();
    }
    else{
      widget=LoginScreen();
    }
    runApp( MyApp(startWidget:widget));

  }, blocObserver: SimpleBlocObserver());
}

class MyApp extends StatelessWidget {
  late final Widget startWidget;
  MyApp({
  required this.startWidget});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => AppCubit()..getUserData()..loadModel().. getPatient()),
        BlocProvider(create: (BuildContext context) => LoginCubit()),
        BlocProvider(create: (BuildContext context) => MainAppCubit()),
        ],
      child: BlocConsumer<MainAppCubit,MainAppstates>(
        listener: ( context, state) {  },
        builder: ( context,  state) {
          return MaterialApp(
            theme: ThemeData(
              floatingActionButtonTheme: FloatingActionButtonThemeData(
                backgroundColor: HexColor("#FFFFFF"),
                shape: StadiumBorder(
                    side: BorderSide(
                        color: unactive, width: 4))
              ),
              appBarTheme: AppBarTheme(

                 color: maincolor,
              ),
              unselectedWidgetColor: HexColor("#009E82"),
              primarySwatch: Colors.green,

              bottomNavigationBarTheme:BottomNavigationBarThemeData(
                selectedItemColor: HexColor("#888888") ,
                unselectedItemColor:HexColor('#888888') ,
                backgroundColor: HexColor('#FFFFFF'),
              ),
            ),
            debugShowCheckedModeBanner: false,
            home: startWidget,
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
