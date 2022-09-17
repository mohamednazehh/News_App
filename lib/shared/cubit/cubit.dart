import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemeabdallahmansor/shared/network/local/cach_helper.dart';
import 'package:udemeabdallahmansor/shared/network/remote/dio_helper.dart';
import 'package:bloc/bloc.dart';
import 'package:udemeabdallahmansor/shared/cubit/states.dart';

class AppCubit extends Cubit<AppStates>
{
  AppCubit() : super(AppInitialState());
  static AppCubit get(context) => BlocProvider.of(context);

  bool isDark = false;

  void changeAppMode({bool? fromShared})
  {
    if(fromShared != null)
    {
      isDark = fromShared;
      emit(AppChangeModeState());
    }

    else
    {
      isDark = !isDark;
      CacheHelper.putBoolean(key: "isDark", value: isDark).then((value)
      {
        emit(AppChangeModeState());
      });
    }
  }
}
