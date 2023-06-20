import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:superlotto/Constant/ApiConstant.dart';
import 'package:superlotto/Constant/Color.dart';
import 'package:superlotto/Screens/HomeScreen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:superlotto/localization/app_localization.dart';
import 'package:superlotto/providers/historyProvider.dart';
import 'package:superlotto/providers/language_provider.dart';
import 'package:superlotto/providers/localization_provider.dart';
import 'package:superlotto/providers/lottteryProvider.dart';
import 'package:superlotto/providers/onbordingProvider.dart';
import 'package:superlotto/providers/sellerTicketsProvider.dart';
import 'package:superlotto/providers/sellerTransationsProvider.dart';
import 'package:superlotto/providers/winnerProvider.dart';

import 'Screens/LoginScreen.dart';
import 'Screens/SplashScreen.dart';
import 'Screens/Weather.dart';

void main() {
  
  runApp( MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => OnboradingProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => LotteryProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => HistoryProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => WinnerProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => SellerTicketsProvider(),
        ),

        ChangeNotifierProvider(
          create: (context) => SellerTransactionsProvider(),
        ),

        ChangeNotifierProvider(
          create: (context) => LocalizationProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => LanguageProvider(languageRepo: LanguageRepo()),
        ),
      ],
      child: MyApp()

  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    List<Locale> _locals = [];
    ApiConst.languages.forEach((language) {
      _locals.add(Locale(language.languageCode, language.countryCode));
    });


    return MaterialApp(
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
      locale: Provider.of<LocalizationProvider>(context).locale,
      localizationsDelegates: [
        AppLocalization.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: _locals,
      debugShowCheckedModeBanner: false,
      home: AppSplashScreen()
    );





  }
}
