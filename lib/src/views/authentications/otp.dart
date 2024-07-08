import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:perfume/src/components/global_variable.dart';
import 'package:perfume/src/views/dashboards/mainpage.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:quiver/async.dart';

class OTPPage extends StatefulWidget {
  final String? phone;
  const OTPPage({super.key, this.phone});

  @override
  State<OTPPage> createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
  TextEditingController otpController = TextEditingController();
  StreamController<ErrorAnimationType>? errorController;
  bool hasError = false;
  String currentText = "";
  final formKey = GlobalKey<FormState>();

  formattedTime({required int timeInSecond}) {
    int sec = timeInSecond % 60;
    int min = (timeInSecond / 60).floor();
    String minute = min.toString().length <= 1 ? "0$min" : "$min";
    String second = sec.toString().length <= 1 ? "0$sec" : "$sec";
    return "$minute : $second";
  }

  @override
  initState() {
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    errorController?.close();
    // otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Stack(
          children: [
            Scaffold(
              backgroundColor: GlobalVariables.backgrounColor,
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        ShaderMask(
                          shaderCallback: (rect) {
                            return const LinearGradient(
                              begin: Alignment.center,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.black, Colors.transparent
                              ],
                            ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
                          },
                          blendMode: BlendMode.dstIn,
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height / 3,
                            width: MediaQuery.of(context).size.width,
                            child: Image.asset(
                              'assets/images/signup-image.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          left: 10,
                          top: 30,
                          child: IconButton(
                            onPressed: (){
                              Navigator.pop(context);
                            }, 
                            icon: const Icon(Icons.arrow_back_ios_new_rounded, color: GlobalVariables.buttonColorWhite, size: 22,))
                        ),
                        const Positioned(
                          bottom: 50,
                          left: 0,
                          right: 0,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text("Best Perfume in Indonesia", textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontFamily: "SF-Pro-Bold", fontWeight: FontWeight.normal, fontSize: 20)), 
                                Text("Welcome to Enela", textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontFamily: "SF-Pro-Bold", fontWeight: FontWeight.bold, fontSize: 30)),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  const SizedBox(height: 15),
                  // Center(child: Image.asset('assets/images/otp_image.png')),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                    child: Text("Enter Verification Code", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                    child: Text("We have sent a verification code to the WhatsApp number ${widget.phone ?? 'Unknown Number'}.", style: const TextStyle(fontSize: 15),),
                  ), 
                  const SizedBox(height: 20),
                  Form(
                    key: formKey,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 30,
                      ),
                      child: PinCodeTextField(
                        autoDisposeControllers: true,
                        appContext: context,
                        animationCurve: Curves.bounceInOut,
                        hapticFeedbackTypes: HapticFeedbackTypes.vibrate,
                        pastedTextStyle: TextStyle(
                          color: Colors.green.shade600,
                          fontWeight: FontWeight.bold,
                        ),
                        length: 5,
                        obscureText: true,
                        obscuringCharacter: '*',
                        blinkWhenObscuring: true,
                        animationType: AnimationType.scale,
                        validator: (v) {
                          if (v!.length < 3) {
                            return "Please input OTP Code";
                          } else {
                            return null;
                          }
                        },
                        pinTheme: PinTheme(
                          shape: PinCodeFieldShape.underline,
                          // borderRadius: BorderRadius.circular(5),
                          fieldHeight: 50,
                          fieldWidth: 40,
                          selectedColor: GlobalVariables.buttonColorGreen,
                          activeFillColor: Colors.white,
                          activeColor: GlobalVariables.buttonColorGreen,
                          inactiveColor: GlobalVariables.buttonColorBlack.withOpacity(0.5)
                        ),
                        cursorColor: Colors.black.withOpacity(0.5),
                        animationDuration: const Duration(milliseconds: 300),
                        // enableActiveFill: true,
                        errorAnimationController: errorController,
                        controller: otpController,
                        keyboardType: TextInputType.number,
                        boxShadows: const [
                          BoxShadow(
                            offset: Offset(0, 1),
                            color: Colors.black12,
                            blurRadius: 10,
                          )
                        ],
                        onCompleted: (v) {
                          Get.offAll(() => const MainPage());
                          debugPrint("Completed");
                        },
                        onChanged: (value) {
                          debugPrint(value);
                          setState(() {
                            currentText = value;
                          });
                        },
                        beforeTextPaste: (text) {
                          debugPrint("Allowing to paste $text");
                          return true;
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Didn't receive OTP? ", style: TextStyle(fontSize: 15, color: GlobalVariables.buttonColorBlack.withOpacity(0.6))),
                        _current == 0 ? 
                         TextButton(
                          onPressed: (){
                            startTimer();
                          },
                          child: const Text("Resend", style: TextStyle(fontSize: 15, color: GlobalVariables.buttonColorGreen, fontWeight: FontWeight.bold))
                        ) : Text(formattedTime(timeInSecond: _current),
                        style: const TextStyle(fontWeight: FontWeight.normal),
                      ) 
                      ],
                    ),
                  ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  int start = 10;
  int _current = 10;

  void startTimer() {
    CountdownTimer countDownTimer = CountdownTimer(
      Duration(seconds: start),
      const Duration(seconds: 1),
    );

    var sub = countDownTimer.listen(null);
    sub.onData((duration) {
      if(mounted){
        setState(() { _current = start - duration.elapsed.inSeconds; });
      }
    });

    sub.onDone(() {
      print("Done");
      sub.cancel();
    });
  }
}