import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:perfume/src/components/global_variable.dart';

class InputTextPhone extends StatefulWidget {
  final TextEditingController controller;
  const InputTextPhone({super.key, required this.controller});

  @override
  State<InputTextPhone> createState() => _InputTextPhoneState();
}

class _InputTextPhoneState extends State<InputTextPhone> {
  PhoneNumber number = PhoneNumber(isoCode: 'ID');
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      padding: const EdgeInsets.symmetric(horizontal: 18),
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
          // print(number.phoneNumber);
        },
        onInputValidated: (bool value) {
          // print(value);
        },
        selectorConfig: const SelectorConfig(
          selectorType: PhoneInputSelectorType.DIALOG,
          useBottomSheetSafeArea: false,
        ),
        ignoreBlank: false,
        hintText: "Nomor WhatsApp",
        autoValidateMode: AutovalidateMode.disabled,
        selectorTextStyle: const TextStyle(color: Colors.black),
        initialValue: number,
        spaceBetweenSelectorAndTextField: 0,
        autoFocusSearch: false,
        textFieldController: widget.controller,
        formatInput: true,
        inputBorder: const OutlineInputBorder(
            borderSide: BorderSide.none
        ),
        keyboardType: const TextInputType.numberWithOptions(signed: true, decimal: true),
        onSaved: (PhoneNumber number) {
          // print('On Saved: $number');
        },
      ),
    );
  }

  void getPhoneNumber(String phoneNumber) async {
    PhoneNumber number = await PhoneNumber.getRegionInfoFromPhoneNumber(phoneNumber, 'ID');
    setState(() => this.number = number);
  }
}

class InputTextPhoneWhatsapp extends StatefulWidget {
  final TextEditingController controller;
  const InputTextPhoneWhatsapp({super.key, required this.controller});

  @override
  State<InputTextPhoneWhatsapp> createState() => _InputTextPhoneWhatsappState();
}

class _InputTextPhoneWhatsappState extends State<InputTextPhoneWhatsapp> {
  bool isPhoneNumber = false;
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
        keyboardType: TextInputType.phone,
        onChanged: (value) {
          // validatePhone(value);
        },
        decoration: InputDecoration(
          prefixIcon: const Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Icon(Iconsax.whatsapp_outline, color: GlobalVariables.buttonColorGreen),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          hintText: "Nomor WhatsApp",
          hintStyle: const TextStyle(color: Colors.black45),
          fillColor: Colors.white,
          filled: true,
          // suffix: AnimatedContainer(
          //   duration: const Duration(milliseconds: 500),
          //   decoration: const BoxDecoration(
          //     color: GlobalVariables.buttonColorGreen,
          //     shape: BoxShape.circle),
          //   child: isPhoneNumber == false ? const Icon(Icons.close, color: Colors.white, size: 16) : const Icon(Icons.done, color: Colors.white, size: 16),
          // ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none
          ),
        ),
      ),
    );
  }

  /// regex ref: https://ihateregex.io/expr/phone/
  bool isValidPhoneNumber(String? value) => RegExp(r'(^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$)').hasMatch(value ?? '');

  bool? validatePhone(String value){
    const pattern = r'(^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$)';
    final regex = RegExp(pattern);
    if(!regex.hasMatch(value)) {
      setState(() => isPhoneNumber = false);
    }else{
      setState(() => isPhoneNumber = true);
    }
  }

}

