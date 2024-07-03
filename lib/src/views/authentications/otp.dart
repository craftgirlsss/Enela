import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:perfume/src/components/global_variable.dart';

class OTPPage extends StatefulWidget {
  final String? phone;
  const OTPPage({super.key, this.phone});

  @override
  State<OTPPage> createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
  OtpFieldController otpController = OtpFieldController();
  String? otpResult;
  int secondsRemaining = 60;
  bool enableResend = false;
  Timer? timer;

  formattedTime({required int timeInSecond}) {
    int sec = timeInSecond % 60;
    int min = (timeInSecond / 60).floor();
    String minute = min.toString().length <= 1 ? "0$min" : "$min";
    String second = sec.toString().length <= 1 ? "0$sec" : "$sec";
    return "$minute : $second";
  }

  @override
  initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (secondsRemaining != 0) {
        setState(() {
          secondsRemaining--;
        });
      } else {
        setState(() {
          timer?.cancel();
          enableResend = true;
        });
      }
    });
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
                  //   const Padding(
                  //   padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                  //   child: Text("VERIFICATION CODE", style: TextStyle()),
                  // ),
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
                  Center(
                    child: OTPTextField(
                      otpFieldStyle: OtpFieldStyle(
                        backgroundColor: Colors.transparent,
                        borderColor: Colors.black.withOpacity(0.2),
                        enabledBorderColor: Colors.black.withOpacity(0.2),
                      ),
                      controller: otpController,
                      keyboardType: TextInputType.number,
                      length: 4,
                      width: MediaQuery.of(context).size.width,
                      textFieldAlignment: MainAxisAlignment.spaceEvenly,
                      fieldWidth: 45,
                      fieldStyle: FieldStyle.box,
                      outlineBorderRadius: 7,
                      style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                      onChanged: (pin) {
                      },
                      onCompleted: (pin) {
                        // otpController.clear();
                        setState(() {
                          otpResult = pin;
                        });
                      },
                    ),
                  ),
                  
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Didn't receive OTP? ", style: TextStyle(fontSize: 15, color: GlobalVariables.buttonColorBlack.withOpacity(0.6))),
                        enableResend ? 
                         TextButton(
                          onPressed: (){},
                          child: const Text("Resend", style: TextStyle(fontSize: 15, color: GlobalVariables.buttonColorGreen, fontWeight: FontWeight.bold))
                        ) : Text(formattedTime(timeInSecond: secondsRemaining),
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

   void resendCode() {
    //other code here
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (secondsRemaining != 0) {
        setState(() {
          secondsRemaining--;
        });
      } else {
        setState(() {
          enableResend = true;
        });
      }
    });
    setState((){
      enableResend = false;
    });
  }  
  
  @override
  dispose(){
    timer?.cancel();
    super.dispose();
  }
}