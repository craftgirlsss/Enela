import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:perfume/src/components/global_variable.dart';

class InputTextEmail extends StatefulWidget {
  final TextEditingController controller;
  const InputTextEmail({super.key, required this.controller});

  @override
  State<InputTextEmail> createState() => _InputTextEmailState();
}

class _InputTextEmailState extends State<InputTextEmail> {
  bool isEmail = false;
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
        keyboardType: TextInputType.emailAddress,
        controller: widget.controller,
        onChanged: (value) {
          validateEmailBool(value: value);
        },
        decoration: InputDecoration(
          prefixIcon: Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Icon(Iconsax.message_2_outline, color: GlobalVariables.buttonColorGreen),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          hintText: "Alamat Email",
          hintStyle: const TextStyle(color: Colors.black45),
          fillColor: Colors.white,
          filled: true,
          suffix: AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            decoration: const BoxDecoration(
                color: GlobalVariables.buttonColorGreen,
                shape: BoxShape.circle),
            child: isEmail == false ? const Icon(Icons.close, color: Colors.white, size: 16) : const Icon(Icons.done, color: Colors.white, size: 16),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none
          ),
        ),
      ),
    );
  }

  bool? validateEmailBool({String? value}) {
    const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
    final regex = RegExp(pattern);
    if(!regex.hasMatch(value!)){
      setState(() => isEmail = false);
    }else{
      setState(() => isEmail = true);
    }
    return isEmail;
  }
}
