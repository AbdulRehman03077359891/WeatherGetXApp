
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/Screen/User/user_screen.dart';

class SplashLogo extends StatefulWidget {
  const SplashLogo({super.key});

  @override
  State<SplashLogo> createState() => _SplashLogoState();
}

class _SplashLogoState extends State<SplashLogo> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), (() {
      Get.offAll(const UserScreen());
    }));
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Image.asset('assets/images/Logo.jpeg'),
        ),
      ),
    );
  }
}
