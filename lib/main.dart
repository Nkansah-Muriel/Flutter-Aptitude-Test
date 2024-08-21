import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moviemot/screens/splash_screen.dart';

import 'package:moviemot/theme/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'moviemot',
        theme: ThemeData(
          scaffoldBackgroundColor: KColors.white,
          textTheme: const TextTheme(
              bodyLarge: TextStyle(
                fontFamily: "Poppins",
                fontSize: 21,
                color: KColors.largeBlack,
                fontWeight: FontWeight.bold,
              ),
              bodyMedium: TextStyle(
                fontFamily: "Poppins",
                fontSize: 16,
                color: KColors.mediumBlack,
                fontWeight: FontWeight.w500,
              ),
              bodySmall: TextStyle(
                fontFamily: "Poppins",
                fontSize: 12,
                color: KColors.smallBlack,
                fontWeight: FontWeight.w400,
              )),
          useMaterial3: true,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
