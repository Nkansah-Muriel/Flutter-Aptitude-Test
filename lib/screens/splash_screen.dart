import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moviemot/screens/default_screen.dart';

import 'package:moviemot/theme/colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const DefaultHomeScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return SafeArea(
      child: Scaffold(
        backgroundColor: KColors.largeBlack,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/Rectangle 1.png",
              ),
              SizedBox(
                height: 10.h,
              ),
              ShaderMask(
                shaderCallback: (bounds) => const LinearGradient(
                  colors: [
                    KColors.firstGradient,
                    KColors.seocndGradient,
                  ],
                ).createShader(bounds),
                child: Text(
                  "Moviemot",
                  style: textTheme.bodyMedium?.copyWith(
                    color: Colors
                        .white, // Ensure text color is set to white (or any solid color)
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
