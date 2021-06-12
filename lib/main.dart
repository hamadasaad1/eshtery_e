import 'package:bloc/bloc.dart';
import 'package:elbya3/constants.dart';
import 'package:elbya3/core/network/local/local_helper.dart';
import 'package:elbya3/core/network/remot/dio_helper.dart';
import 'package:elbya3/core/view_model/login_cubit.dart';
import 'package:elbya3/core/view_model/shop_cubit.dart';
import 'package:elbya3/view/screens/home_layout.dart';
import 'package:elbya3/view/screens/login_screen.dart';
import 'package:elbya3/view/screens/onboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'helper/bloc_observe.dart';
import 'helper/style/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  Widget screenOpen;
  bool onBoarding = await CacheHelper.getDataToSharedPref(key: "OnBoarding");
  KToken = await CacheHelper.getDataToSharedPref(key: "token");
  if (onBoarding != null) {
    if (KToken != null) {
      screenOpen = HomeLayout();
      print("Home Screen");
    } else {
      screenOpen = ShopLoginScreen();
      print("ShopLoginScreen");
    }
  } else {
    screenOpen = OnBoardingScreen();
    print("OnBoardingScreen");
  }
  runApp(MyApp(
    onBoarding: screenOpen,
  ));
}

class MyApp extends StatelessWidget {
  final Widget onBoarding;

  MyApp({this.onBoarding});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => ShopCubit()
            ..getHomeDataFromApi()
            ..getCategoriesDataFromApi(),
        ),
        BlocProvider(create: (BuildContext context) => LoginCubit()),
      ],
      child: MaterialApp(
          title: 'Elbya3',
          debugShowCheckedModeBanner: false,
          theme: buildThemeData(),
          home: onBoarding),
    );
  }
}
