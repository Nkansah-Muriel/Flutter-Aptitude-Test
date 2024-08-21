import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:moviemot/screens/home_page.dart';

import 'favourite_screen.dart';
import 'settings_screen.dart';

class DefaultHomeScreen extends StatefulWidget {
  const DefaultHomeScreen({super.key});

  @override
  State<DefaultHomeScreen> createState() => _DefaultHomeScreenState();
}

class _DefaultHomeScreenState extends State<DefaultHomeScreen> {
  List<Widget> body = [
    const HomePage(),
    const FavouriteScreen(),
    const SettingScreen(),
  ];
  final currentPage = ValueNotifier<int>(0);
  updatePage(int page) {
    setState(() {
      currentPage.value = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: body[currentPage.value],
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
          child: GNav(
            tabBorderRadius: 18,
            backgroundColor: Colors.transparent,
            activeColor: Colors.white,
            tabBackgroundColor: const Color.fromRGBO(7, 200, 212, 1),
            gap: 8.0,
            onTabChange: (index) => setState(() {
              currentPage.value = index;
            }),
            padding: EdgeInsets.all(12.w),
            tabs: const [
              GButton(
                icon: Icons.home_rounded,
                iconColor: Colors.grey,
                text: 'Home',
              ),
              GButton(
                icon: Icons.favorite_rounded,
                iconColor: Colors.grey,
                text: 'Favourite',
              ),
              GButton(
                icon: Icons.settings_rounded,
                iconColor: Colors.grey,
                text: 'Settings',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
