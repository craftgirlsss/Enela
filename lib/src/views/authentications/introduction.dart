import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:perfume/src/components/global_variable.dart';
import 'package:perfume/src/controllers/api.dart';
import 'package:perfume/src/controllers/permission_handler.dart';
import 'package:perfume/src/views/authentications/signup.dart';

class IntroductionScreen extends StatefulWidget {
  const IntroductionScreen({super.key});

  @override
  State<IntroductionScreen> createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroductionScreen> {
  PageController pageController = PageController(initialPage: 0);
  List imageName = ['1.jpg','2.jpg','3.jpg','4.jpg'];
  int activePage = 0;
  Timer? timer;

  void startTimer(){
    timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if(pageController.page == imageName.length - 1){
        pageController.animateToPage(0, duration: const Duration(seconds: 1), curve: Curves.easeInOut);
      }else{
        pageController.nextPage(duration: const Duration(seconds: 1), curve: Curves.easeInOut);
      }
    },);
  }

  Future permissionFirebase(context)async{
    await FirebaseApi().initNotifications();
    permissionServiceCall(context);
  }

  @override
  void initState() {
    permissionFirebase(context);
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
  }

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
          PageView.builder(
            controller: pageController,
            physics: const ScrollPhysics(),
            onPageChanged: (value) => setState(() => activePage = value),
            itemCount: imageName.length,
            pageSnapping: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => Opacity(
              opacity: 0.4,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Image.asset('assets/images/${imageName[index]}', fit: BoxFit.cover)),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Text("sewa.id", textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontFamily: "SF-Pro-Bold", fontWeight: FontWeight.bold, fontSize: 36)),
                          ],
                        ),
                        Text("Solusi sewa jasa appaun yang anda butuhkan", textAlign: TextAlign.start, style: TextStyle(color: Colors.white54, fontFamily: "SF-Pro-Bold", fontWeight: FontWeight.bold, fontSize: 16))
                      ],
                    ),
                    Spacer(),
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
                                }, child: const Text("LANJUT", style: TextStyle(color: GlobalVariables.textColorWhite),
                                )
                              )
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: TextButton.icon(
                                icon: const Icon(Icons.keyboard_double_arrow_right_rounded, color: GlobalVariables.buttonColorWhite,),
                                onPressed: (){

                                }, label: const Text("LOGIN NANTI", style: TextStyle(color: GlobalVariables.buttonColorWhite),
                                )
                              )
                            ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 15, left: 8, right: 8),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Text("Solusi jasa layanan apapun yang anda butuhkan dan memudahkan UMKM mendapatkan rezeki", textAlign: TextAlign.center, style: TextStyle(color: GlobalVariables.textColorWhite.withOpacity(0.5)),
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