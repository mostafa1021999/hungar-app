import 'package:bloc/bloc.dart';
import 'package:delivery/shared%20prefernace/shared%20preferance.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'app_dark_light_state.dart';

class AppDarkLightCubit extends Cubit<AppDarkLightState> {
  AppDarkLightCubit() : super(AppDarkLightInitial());
  static AppDarkLightCubit get(context) => BlocProvider.of(context);
  bool isdark = false;

  void changeapppmode({bool? formshare}) {
    if (formshare != null) {
      isdark = formshare;
      emit(ChangeMode());
    }
    else {
      isdark = !isdark;
      Save.putdata(key: 'isdark', value: isdark).then((value) =>
          emit(ChangeMode()));
    }
  }

}
