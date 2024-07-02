import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:perfume/src/components/global_variable.dart';
import 'package:perfume/src/views/authentications/introduction.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), (){
      Get.off(() => const IntroductionScreen());
    });
  }
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
        ),
        child: Scaffold(
        backgroundColor: GlobalVariables.backgrounColor,
        body: Center(child: Image.asset('assets/images/logo-splash.png', width: MediaQuery.of(context).size.width / 1.7,)),
      ),
    );
  }
}