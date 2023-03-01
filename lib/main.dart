import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:superlotto/Constant/Color.dart';
import 'package:superlotto/Screens/HomeScreen.dart';
import 'package:superlotto/providers/historyProvider.dart';
import 'package:superlotto/providers/lottteryProvider.dart';
import 'package:superlotto/providers/onbordingProvider.dart';
import 'package:superlotto/providers/sellerTicketsProvider.dart';
import 'package:superlotto/providers/winnerProvider.dart';

import 'Screens/LoginScreen.dart';
import 'Screens/SplashScreen.dart';
import 'Screens/Weather.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => OnboradingProvider(),
            child: const AppSplashScreen(),
          ),
          ChangeNotifierProvider(
            create: (context) => LotteryProvider(),
            child: const AppSplashScreen(),
          ),
          ChangeNotifierProvider(
            create: (context) => HistoryProvider(),
            child: const AppSplashScreen(),
          ),
          ChangeNotifierProvider(
            create: (context) => WinnerProvider(),
            child: const AppSplashScreen(),
          ),
          ChangeNotifierProvider(
            create: (context) => SellerTicketsProvider(),
            child: const AppSplashScreen(),
          ),
        ],
        child: ScreenUtilInit(
          designSize: const Size(375, 770),
          builder: (BuildContext context, Widget? child) => MaterialApp(
            theme: ThemeData(
              primaryColor: AppColor.redcolor.withOpacity(0.5),
              accentColor: Colors.orangeAccent,
              fontFamily: "Sk-Modernist-Regular",
              pageTransitionsTheme: PageTransitionsTheme(
                builders: Map<TargetPlatform, PageTransitionsBuilder>.fromIterable(
                  TargetPlatform.values,
                  value: (dynamic _) => const ZoomPageTransitionsBuilder(),
                ),
              ), textSelectionTheme: TextSelectionThemeData(cursorColor: AppColor.redcolor),
            ),
            debugShowCheckedModeBanner: false,
            home: AppSplashScreen(),
          ),
        ));
  }
}
