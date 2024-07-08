import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:perfume/src/components/global_variable.dart';
import 'package:perfume/src/components/password_validator.dart';
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
                              'assets/images/signup-image.jpg',
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
                                const Text("Best Perfume in Indonesia", textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontFamily: "SF-Pro-Bold", fontWeight: FontWeight.normal, fontSize: 20)), 
                                const Text("Welcome to Enela", textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontFamily: "SF-Pro-Bold", fontWeight: FontWeight.bold, fontSize: 30)),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: GlobalVariables.buttonColorBlack.withOpacity(0.7)
                                    ),
                                    onPressed: (){

                                    }, child: const Text("More Informations", style: TextStyle(color: GlobalVariables.textColorWhite))),
                                )
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

enum Calendar { login, signup }

class SingleChoice extends StatefulWidget {
  const SingleChoice({super.key});

  @override
  State<SingleChoice> createState() => _SingleChoiceState();
}

class _SingleChoiceState extends State<SingleChoice> with TickerProviderStateMixin {
  Calendar calendarView = Calendar.login;
  final _formKey = GlobalKey<FormState>();
  bool isLoginPage = true;
  AuthenticationController authenticationController = Get.put(AuthenticationController());
  final TextEditingController controller = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController emailForgot = TextEditingController();
  String initialCountry = 'ID';
  bool showPassword = true;
  PhoneNumber number = PhoneNumber(isoCode: 'ID');
  bool tampilsandipasswordsekarang = true;
  bool tampilsandipasswordbaru1 = true;
  bool tampilsandipasswordbaru2 = true;
  bool isPasswordEightCharacters = false;
  bool hasPasswordOneNumber = false;
  bool hasLowerUpper = false;
  bool hasPasswordSame = false;
  // bool _shouldFade = false;

  // late AnimationController animation;
  // late Animation<double> _fadeInFadeOut;


  @override
  void initState() {
    super.initState();
    password.addListener((){});
    // animation = AnimationController(vsync: this, duration: const Duration(milliseconds: 700),);
    // _fadeInFadeOut = Tween<double>(begin: 0.0, end: 1).animate(animation);
    // animation.addStatusListener((status){
    //   if(status == AnimationStatus.completed){
    //     animation.reverse();
    //   }
    //   else if(status == AnimationStatus.dismissed){
    //     animation.stop();
    //   }
    // });
    // animation.forward();
  }

  onPasswordChanged(String password) {
    final numericRegex = RegExp(r'[0-9]');
    final upperLowerRegex = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z]).{8,}$');

    setState(() {
      isPasswordEightCharacters = false;
      if (password.length > 7) isPasswordEightCharacters = true;

      hasPasswordOneNumber = false;
      if (numericRegex.hasMatch(password)) hasPasswordOneNumber = true;
    
      hasLowerUpper = false;
      if (upperLowerRegex.hasMatch(password)) hasLowerUpper = true;
    });
  }

  onPasswordChangeConfirm(String password1, String password2){
    setState(() {
      hasPasswordSame = false;
      if (password1 == password2) hasPasswordSame = true;
    });
  }

  @override
  void dispose() {
    password.dispose();
    controller.dispose();
    emailForgot.dispose();
    // animation.dispose();
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
            child: SegmentedButton<Calendar>(
              style: SegmentedButton.styleFrom(
                side: const BorderSide(color: GlobalVariables.buttonColorGreen),
                backgroundColor: Colors.white,
                foregroundColor:  GlobalVariables.buttonColorGreen,
                selectedForegroundColor: Colors.white,
                selectedBackgroundColor: GlobalVariables.buttonColorGreen,
              ),
              showSelectedIcon: false,
              segments: const <ButtonSegment<Calendar>>[
                ButtonSegment<Calendar>(
                    value: Calendar.login,
                    label: Text('Login'),
                  ),
                ButtonSegment<Calendar>(
                    value: Calendar.signup,
                    label: Text('Register'),
                  ),
              ],
              selected: <Calendar>{calendarView},
              onSelectionChanged: (Set<Calendar> newSelection) {
                setState(() {
                  calendarView = newSelection.first;
                  if(calendarView == Calendar.signup){
                    isLoginPage = false;
                  }else{
                    isLoginPage = true;
                    // setState(() {
                    //   _shouldFade = true;
                    //   Future.delayed(const Duration(seconds: 2), () => _shouldFade = false);
                    // });
                  }
                });
              },
            ),
          ),
        ),
        isLoginPage ? bodyLogin() : bodyRegister() 
      ],
    );
  }

  Widget bodyRegister(){
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0, 2),
                  blurRadius: 20
                )
              ]
            ),
            child: InternationalPhoneNumberInput(
              onInputChanged: (PhoneNumber number) {
                print(number.phoneNumber);
              },
              onInputValidated: (bool value) {
                print(value);
              },
              selectorConfig: const SelectorConfig(
                selectorType: PhoneInputSelectorType.DIALOG,
                useBottomSheetSafeArea: false,
              ),
              ignoreBlank: false,
              autoValidateMode: AutovalidateMode.disabled,
              selectorTextStyle: const TextStyle(color: Colors.black),
              initialValue: number,
              spaceBetweenSelectorAndTextField: 0,
              autoFocusSearch: false,
              textFieldController: controller,
              formatInput: true,
              inputBorder: const OutlineInputBorder(
                borderSide: BorderSide.none
              ),
              keyboardType: const TextInputType.numberWithOptions(signed: true, decimal: true),
              onSaved: (PhoneNumber number) {
                print('On Saved: $number');
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0, 2),
                  blurRadius: 20
                )
              ]
            ),
            child: TextFormField(
              controller: password,
              obscureText: showPassword,
              obscuringCharacter: '*',
              onChanged: (text) => onPasswordChanged(text),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                hintText: "Choose Password",
                hintStyle: const TextStyle(color: Colors.black45),
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none
                ),
                suffixIcon: Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: GestureDetector(
                    onTap: (){
                      setState(() {
                        showPassword = !showPassword;
                      });
                    },
                    child: showPassword ? const Icon(CupertinoIcons.eye_fill, color: Colors.black45, size: 22) : const Icon(CupertinoIcons.eye_slash_fill, color: Colors.black45, size: 22),
                  ),
                )
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            color: Colors.transparent,
            child: Column(
              children: [
                const SizedBox(height: 15),
                Roweliminatenumber(
                isPasswordEightCharacters: isPasswordEightCharacters),
                const SizedBox(height: 10),
                Roweliminatelowup(hasLowerUpper: hasLowerUpper),
                const SizedBox(height: 10),
                Roweliminateonenum(hasPasswordOneNumber: hasPasswordOneNumber),
                const SizedBox(height: 20),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Text("You are starting registration process as Online Customer. Please find our Privacy Policy and Terms and Conditions for Online Customers. By clicking on the buttons below, you consent to receive messages from Enela related to your registration process.", style: TextStyle(color: Colors.black45),),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
            child: Container(
              width: MediaQuery.of(context).size.width,
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
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: GlobalVariables.buttonColorGreen
                ),
                onPressed: (){
                  Get.to(() => const OTPPage());
                }, child: const Text("CREATE ACCOUNT", style: TextStyle(color: GlobalVariables.textColorWhite),
                )
              )
            ),
          ),
          const Center(
            child: Text("OR CONTINUE WITH", style: TextStyle(color: Colors.black45)),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 10),
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0, 2),
                  blurRadius: 20
                )
              ]
            ),
              child: Obx(() => ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: GlobalVariables.buttonColorWhite
                  ),
                  onPressed: authenticationController.isLoading.value ? (){} : (){
                    authenticationController.signInWithGoogle();
                  }, 
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/icons/google.png', width: 20,),
                      const SizedBox(width: 10),
                      const Text("SIGN UP WITH GOOGLE", style: TextStyle(color: GlobalVariables.buttonColorBlack),
                      ),
                    ],
                  )
                ),
              )
            ),
          ),
        ],
      ),
    );
  }

  Widget bodyLogin(){
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0, 2),
                  blurRadius: 20
                )
              ]
            ),
            child: InternationalPhoneNumberInput(
              onInputChanged: (PhoneNumber number) {
                print(number.phoneNumber);
              },
              onInputValidated: (bool value) {
                print(value);
              },
              selectorConfig: const SelectorConfig(
                selectorType: PhoneInputSelectorType.DIALOG,
                useBottomSheetSafeArea: false,
              ),
              ignoreBlank: false,
              autoValidateMode: AutovalidateMode.disabled,
              selectorTextStyle: const TextStyle(color: Colors.black),
              initialValue: number,
              spaceBetweenSelectorAndTextField: 0,
              autoFocusSearch: false,
              textFieldController: controller,
              formatInput: true,
              inputBorder: const OutlineInputBorder(
                borderSide: BorderSide.none
              ),
              keyboardType: const TextInputType.numberWithOptions(signed: true, decimal: true),
              onSaved: (PhoneNumber number) {
                print('On Saved: $number');
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 15, right: 15, bottom: 0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0, 2),
                  blurRadius: 20
                )
              ]
            ),
            child: TextFormField(
              controller: password,
              obscureText: showPassword,
              obscuringCharacter: '*',
              onChanged: (text) => onPasswordChanged(text),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                hintText: "Input Password",
                hintStyle: const TextStyle(color: Colors.black45),
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none
                ),
                suffixIcon: Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: GestureDetector(
                    onTap: (){
                      setState(() {
                        showPassword = !showPassword;
                      });
                    },
                    child: showPassword ? const Icon(CupertinoIcons.eye_fill, color: Colors.black45, size: 22) : const Icon(CupertinoIcons.eye_slash_fill, color: Colors.black45, size: 22),
                  ),
                )
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                style: const ButtonStyle(
                  padding: WidgetStatePropertyAll(EdgeInsets.only(right: 20, bottom: 0))
                ),
                onPressed: (){
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) => Padding(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom,
                        left: 20,
                        right: 20,
                        top: 20
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: Container(
                                    width: 70,
                                    height: 5,
                                    padding: const EdgeInsets.only(bottom: 10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.black
                                    ),
                                  )
                                ),
                                const Text('Oh no!,\ni\'m forgot password', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, fontFamily: "SF-PRO-Bold")),
                                const Text('Please type your email address where registered in this platform', style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal)),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          TextField(
                            controller: emailForgot,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.only(top: 15),
                              border: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black
                                )
                              ),
                              hintText: 'Email Address',
                              prefixIcon: const Icon(Icons.email),
                              suffixIcon: InkWell(
                                borderRadius: BorderRadius.circular(30),
                                onTap: (){},
                                child: Icon(Icons.send, color: Colors.blue.shade600,),
                              )
                            ),
                            autofocus: false,
                            ),
                            const SizedBox(height: 30),
                        ],
                      ),
                    )
                  );
                }, 
                child: const Text("Forgot Password?", style: TextStyle(color: GlobalVariables.buttonColorGreen),))
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 7, bottom: 10),
            child: Container(
              width: MediaQuery.of(context).size.width,
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
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: GlobalVariables.buttonColorGreen
                ),
                onPressed: (){
                  Get.to(() => const OTPPage());
                }, child: const Text("Login", style: TextStyle(color: GlobalVariables.textColorWhite),
                )
              )
            ),
          ),
          const Center(
            child: Text("OR CONTINUE WITH", style: TextStyle(color: Colors.black45)),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 10),
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    offset: Offset(0, 2),
                    blurRadius: 20
                  )
                ]
              ),
              child: Obx(() => ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: GlobalVariables.buttonColorWhite
                  ),
                  onPressed: authenticationController.isLoading.value ? (){} : (){
                    authenticationController.signInWithGoogle();
                  }, 
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/icons/google.png', width: 20,),
                      const SizedBox(width: 10),
                      const Text("SIGN IN WITH GOOGLE", style: TextStyle(color: GlobalVariables.buttonColorBlack),
                      ),
                    ],
                  )
                ),
              )
            ),
          ),
        ],
      ),
    );
  }

  void getPhoneNumber(String phoneNumber) async {
    PhoneNumber number = await PhoneNumber.getRegionInfoFromPhoneNumber(phoneNumber, 'ID');
    setState(() => this.number = number);
  }
}