import 'package:flutter/material.dart';
import 'package:perfume/src/components/global_variable.dart';

class InputTextAnyText extends StatefulWidget {
  final TextEditingController controller;
  final IconData? icon;
  final String? hintText;
  const InputTextAnyText({super.key, required this.controller, this.hintText, this.icon});

  @override
  State<InputTextAnyText> createState() => _InputTextAnyTextState();
}

class _InputTextAnyTextState extends State<InputTextAnyText> {

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
        keyboardType: TextInputType.name,
        decoration: InputDecoration(
          prefixIcon:  Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Icon(widget.icon, color: GlobalVariables.buttonColorGreen),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          hintText: widget.hintText ?? "Input",
          hintStyle: const TextStyle(color: Colors.black45),
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none
          ),
        ),
      ),
    );
  }
}
