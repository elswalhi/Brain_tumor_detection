import 'package:flutter_bloc/flutter_bloc.dart';
import '../states/states.dart';



class MainAppCubit extends Cubit<MainAppstates> {
  MainAppCubit() : super(InitialState());

  static MainAppCubit get(context) => BlocProvider.of(context);


}