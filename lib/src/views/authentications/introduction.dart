import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:perfume/src/components/global_variable.dart';
import 'package:perfume/src/views/authentications/signup.dart';

class IntroductionScreen extends StatelessWidget {
  const IntroductionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
        ),
        child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Opacity(
              opacity: 0.5,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Image.asset('assets/images/background.jpg', fit: BoxFit.cover)),
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 4),
                          child: const Text("Welcome to\nEnela", textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontFamily: "SF-Pro-Bold", fontWeight: FontWeight.bold, fontSize: 46)),
                        ),
                        Container(
                          color: Colors.transparent,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 15),
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      elevation: 0,
                                      backgroundColor: GlobalVariables.buttonColorGreen
                                    ),
                                    onPressed: (){
                                      Get.to(() => const SignUp());
                                    }, child: const Text("NEXT", style: TextStyle(color: GlobalVariables.textColorWhite),
                                    )
                                  )
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 15),
                                child: TextButton.icon(
                                    icon: const Icon(Icons.keyboard_double_arrow_right_rounded, color: GlobalVariables.buttonColorWhite,),
                                    onPressed: (){
                                      
                                    }, label: const Text("CONTINUE AS GUEST", style: TextStyle(color: GlobalVariables.buttonColorWhite),
                                    )
                                  )
                                ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 15),
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: Text("By signing in or otherwise proceeding i agree to the\nTerms &Conditions of this app.", textAlign: TextAlign.center, style: TextStyle(color: GlobalVariables.textColorWhite.withOpacity(0.5)),
                                    )
                                  )
                                ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: Text("v1.0.0", textAlign: TextAlign.center, style: TextStyle(color: GlobalVariables.textColorWhite.withOpacity(0.5)),
                                  )
                                )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
          ]
        ),
      ),
    );
  }
}