import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:perfume/src/components/global_variable.dart';

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

class _SingleChoiceState extends State<SingleChoice> {
  Calendar calendarView = Calendar.login;
  final _formKey = GlobalKey<FormState>();
  bool isLoginPage = true;
  final TextEditingController controller = TextEditingController();
  String initialCountry = 'ID';
  PhoneNumber number = PhoneNumber(isoCode: 'ID');

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width / 1.3,
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
                }
              });
            },
          ),
        ),
        isLoginPage ? bodyLogin(): Text("Hello World Sign UP")
      ],
    );
  }

  Widget bodyLogin(){
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black38,
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
              selectorTextStyle: TextStyle(color: Colors.black),
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
        ],
      ),
    );
  }

  void getPhoneNumber(String phoneNumber) async {
    PhoneNumber number = await PhoneNumber.getRegionInfoFromPhoneNumber(phoneNumber, 'ID');
    setState(() => this.number = number);
  }
}