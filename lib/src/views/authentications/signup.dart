import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:perfume/src/components/default_button.dart';
import 'package:perfume/src/components/forgot_components.dart';
import 'package:perfume/src/components/global_variable.dart';
import 'package:perfume/src/components/input_anytext.dart';
import 'package:perfume/src/components/input_email.dart';
import 'package:perfume/src/components/input_password.dart';
import 'package:perfume/src/components/input_phone.dart';
import 'package:perfume/src/components/show_bottomsheet.dart';
import 'package:perfume/src/controllers/authentication_controller.dart';
import 'package:perfume/src/views/authentications/otp.dart';
class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
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
                              'assets/images/1.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                const Text("Selamat datang di nyewa.id", textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontFamily: "SF-Pro-Bold", fontWeight: FontWeight.bold, fontSize: 25)),
                                const Text("Platform sewa jasa apapun", textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontFamily: "SF-Pro-Bold", fontWeight: FontWeight.normal, fontSize: 17)),
                                const SizedBox(height: 10),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    backgroundColor: GlobalVariables.buttonColorBlack.withOpacity(0.5)
                                  ),
                                  onPressed: (){
                                    showBottomSheetCustom(context,title: "Apa itu nyewa.id?");
                                  },
                                  child: const Text("Lebih lanjut", style: TextStyle(color: GlobalVariables.textColorWhite))
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    const SingleChoice()
                  ],
                ),
              ),
            ),
            Positioned(
              top: 0.0,
              left: 0.0,
              right: 0.0,
              child: AppBar(
                elevation: 0,
                scrolledUnderElevation: 0,
                systemOverlayStyle: SystemUiOverlayStyle.light,
                backgroundColor: Colors.transparent,
                leading: IconButton(onPressed: (){
                  Get.back();
                }, icon: const Icon(Icons.arrow_back_ios_new_rounded, color: GlobalVariables.buttonColorWhite, size: 22,)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum Method { login, signup }

class SingleChoice extends StatefulWidget {
  const SingleChoice({super.key});

  @override
  State<SingleChoice> createState() => _SingleChoiceState();
}

class _SingleChoiceState extends State<SingleChoice> with TickerProviderStateMixin {
  Method method = Method.login;
  bool isLoginPage = true;
  AuthenticationController authenticationController = Get.put(AuthenticationController());
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController lupaPassword = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    password.dispose();
    emailController.dispose();
    phoneController.dispose();
    lupaPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width / 1.3,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0, 2),
                  blurRadius: 20
                )
              ]
            ),
            child: SegmentedButton<Method>(
              style: SegmentedButton.styleFrom(
                side: const BorderSide(color: GlobalVariables.buttonColorGreen),
                backgroundColor: Colors.white,
                foregroundColor:  GlobalVariables.buttonColorGreen,
                selectedForegroundColor: Colors.white,
                selectedBackgroundColor: GlobalVariables.buttonColorGreen,
              ),
              showSelectedIcon: false,
              segments: const <ButtonSegment<Method>>[
                ButtonSegment<Method>(
                    value: Method.login,
                    label: Text('Masuk', style: TextStyle(fontWeight: FontWeight.bold, fontFamily: "SF-Pro-Bold", fontSize: 17)),
                  ),
                ButtonSegment<Method>(
                    value: Method.signup,
                    label: Text('Daftar', style: TextStyle(fontWeight: FontWeight.bold, fontFamily: "SF-Pro-Bold", fontSize: 17)),
                  ),
              ],
              selected: <Method>{method},
              onSelectionChanged: (Set<Method> newSelection) {
                setState(() {
                  method = newSelection.first;
                  method == Method.signup ? isLoginPage = false : isLoginPage = true;
                });
              },
            ),
          ),
        ),
        isLoginPage ? bodyLogin() : bodyRegister() 
      ],
    );
  }

  /// Body untuk register
  Widget bodyRegister(){
    return Column(
      children: [
        const SizedBox(height: 15),
        InputTextAnyText(controller: nameController, hintText: "Nama Lengkap", icon: Iconsax.profile_circle_outline),
        Padding(
          padding: const EdgeInsets.only(top:15.0),
          child: InputTextEmail(controller: emailController),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: InputTextPhoneWhatsapp(controller: phoneController),
        ),
        InputTextPasswordForValidate(controller: password),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
          child: Text("Anda akan menerima kode OTP yang dikirimkan ke alamat email atau nomor WhatsApp anda.", style: TextStyle(color: Colors.black45),),
        ),
        defaultButton(context, title: "DAFTAR", onPressed: (){
          Get.to(() => const OTPPage());
        }),
        const Center(
          child: Text("ATAU", style: TextStyle(color: Colors.black45)),
        ),
        defaultButtonWithImage(context, onPressed: (){}, title: "MASUK DENGAN GOOGLE", filename: "google.png"),
        const SizedBox(height: 30)
      ],
    );
  }

  /// Body untuk login page
  Widget bodyLogin(){
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: InputTextEmail(controller: emailController),
        ),
        InputTextPassword(controller: password),
        ForgotComponents(controller: lupaPassword),
        defaultButton(context, onPressed: (){
          Get.to(() => const OTPPage());
        }, title: "MASUK"),
        const Center(
          child: Text("ATAU", style: TextStyle(color: Colors.black45)),
        ),
        defaultButtonWithImage(context, onPressed: (){}, title: "MASUK DENGAN GOOGLE", filename: "google.png")
      ],
    );
  }
}