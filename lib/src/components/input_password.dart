import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:perfume/src/components/global_variable.dart';
import 'password_validator.dart';

class InputTextPassword extends StatefulWidget {
  final Function(String)? onChange;
  final TextEditingController controller;
  const InputTextPassword({super.key, required this.controller, this.onChange});

  @override
  State<InputTextPassword> createState() => _InputTextPasswordState();
}

class _InputTextPasswordState extends State<InputTextPassword> {
  bool showPassword = true;

  @override
  Widget build(BuildContext context) {
    return Container(
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
        controller: widget.controller,
        obscureText: showPassword,
        obscuringCharacter: '*',
        onChanged: widget.onChange,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          hintText: "Kata Sandi",
          hintStyle: const TextStyle(color: Colors.black45),
          fillColor: Colors.white,
          filled: true,
          prefixIcon: const Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Icon(Iconsax.password_check_outline, color: GlobalVariables.buttonColorGreen),
          ),
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
              child: showPassword ? const Icon(CupertinoIcons.eye, color: GlobalVariables.buttonColorGreen, size: 22) : const Icon(CupertinoIcons.eye_slash, color: GlobalVariables.buttonColorGreen, size: 22),
            ),
          )
        ),
      ),
    );
  }
}

class InputTextPasswordForValidate extends StatefulWidget {
  final TextEditingController controller;
  const InputTextPasswordForValidate({super.key, required this.controller});

  @override
  State<InputTextPasswordForValidate> createState() => _InputTextPasswordForValidateState();
}

class _InputTextPasswordForValidateState extends State<InputTextPasswordForValidate> {
  bool showPassword = true;
  bool tampilsandipasswordsekarang = true;
  bool tampilsandipasswordbaru1 = true;
  bool tampilsandipasswordbaru2 = true;
  bool isPasswordEightCharacters = false;
  bool hasPasswordOneNumber = false;
  bool hasLowerUpper = false;
  bool hasPasswordSame = false;

  @override
  void initState() {
    widget.controller.addListener((){});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
            controller: widget.controller,
            obscureText: showPassword,
            obscuringCharacter: '*',
            onChanged: onPasswordChanged,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 20),
              hintText: "Kata Sandi",
              hintStyle: const TextStyle(color: Colors.black45),
              fillColor: Colors.white,
              filled: true,
              prefixIcon: const Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Icon(Iconsax.password_check_outline, color: GlobalVariables.buttonColorGreen,),
              ),
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
                  child: showPassword ? const Icon(CupertinoIcons.eye, color: GlobalVariables.buttonColorGreen, size: 22) : const Icon(CupertinoIcons.eye_slash, color: GlobalVariables.buttonColorGreen, size: 22),
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
            ],
          ),
        ),
      ],
    );
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
}
