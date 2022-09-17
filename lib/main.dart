import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:udemeabdallahmansor/layout/news_app/cubit/cubit.dart';
import 'package:udemeabdallahmansor/layout/news_app/cubit/states.dart';
import 'package:udemeabdallahmansor/layout/news_app/news_layout.dart';
import 'package:udemeabdallahmansor/modules/counter/counter_screen.dart';
import 'package:udemeabdallahmansor/modules/login/loginScreen.dart';
import 'package:udemeabdallahmansor/shared/blok_observer.dart';
import 'package:udemeabdallahmansor/shared/cubit/cubit.dart';
import 'package:udemeabdallahmansor/shared/cubit/states.dart';
import 'package:udemeabdallahmansor/shared/network/local/cach_helper.dart';
import 'package:udemeabdallahmansor/shared/network/remote/dio_helper.dart';
import 'package:udemeabdallahmansor/shared/cubit/cubit.dart';

void main() async
{
  //بيتاكد ان كل حاجه هنا في الميثود خلصت و بعدين يفتح الابلكيشن
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  bool? isDark = CacheHelper.getBoolean(key: 'isDark');

  //isDark!
  runApp(MyApp(isDark!));

  //isDark
  MyApp app = MyApp(isDark);
  //
  Widget a = MyApp(isDark);
}



class MyApp extends StatelessWidget
{
  final bool isDark;


  //MyApp(this.isDark);//this.isDark);
  //
  MyApp(this.isDark);

  @override
  Widget build(BuildContext context)
  {
    return MultiBlocProvider(
      providers:
      [
        BlocProvider(
          create: (context) =>  NewsCubit()..getBusiness()..getSports()..getScience(),
        ),
        BlocProvider(
          create: (BuildContext context) => AppCubit()..changeAppMode(fromShared: isDark,
          ),
        ),
      ],
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context,stets){},
        builder: (context,stets){
          return MaterialApp(
            debugShowCheckedModeBanner:false,
            theme: ThemeData(
              primarySwatch: Colors.deepOrange,
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: AppBarTheme(
                titleSpacing: 20.0,
                backwardsCompatibility: false,
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.white,
                  statusBarIconBrightness: Brightness.dark,
                ),
                backgroundColor: Colors.white,
                elevation: 0.0,
                titleTextStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
                iconTheme: IconThemeData(
                  color: Colors.black,
                ),
              ),
              floatingActionButtonTheme: FloatingActionButtonThemeData(
                backgroundColor: Colors.deepOrange,
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.deepOrange,
                unselectedItemColor: Colors.grey,
                elevation: 20.0,
                backgroundColor: Colors.white,
              ),
              textTheme: TextTheme(
                bodyText1: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
            darkTheme: ThemeData(
              primarySwatch: Colors.deepOrange,
              scaffoldBackgroundColor: HexColor('333739'),
              appBarTheme: AppBarTheme(
                backwardsCompatibility: false,
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: HexColor('333739'),
                  statusBarIconBrightness: Brightness.light,
                ),
                backgroundColor: HexColor('333739'),
                elevation: 0.0,
                titleTextStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
                iconTheme: IconThemeData(
                  color: Colors.white,
                ),
              ),
              floatingActionButtonTheme: FloatingActionButtonThemeData(
                backgroundColor: Colors.deepOrange,
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.deepOrange,
                unselectedItemColor: Colors.grey,
                elevation: 20.0,
                backgroundColor: HexColor('333739'),
              ),
              textTheme: TextTheme(
                bodyText1: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
            themeMode: AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            home: Directionality(
              textDirection: TextDirection.ltr,
              child: NewsLayout(),
            ),
          );
        },
      ),
    );
  }
}