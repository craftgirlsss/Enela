import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'global_variable.dart';

class ForgotComponents extends StatefulWidget {
  final TextEditingController controller;
  const ForgotComponents({super.key, required this.controller});

  @override
  State<ForgotComponents> createState() => _ForgotComponentsState();
}

class _ForgotComponentsState extends State<ForgotComponents> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(style: const ButtonStyle(padding: WidgetStatePropertyAll(EdgeInsets.only(right: 20, bottom: 0))),
          onPressed: (){
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.white,
              builder: (context) => Padding(
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom, left: 20, right: 20, top: 20),
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
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.black
                              ),
                            )
                          ),
                          const Text('Aduhhh!!!,\ni\'m lupa kata sandi nih', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, fontFamily: "SF-PRO-Bold")),
                          const Text('Mohon input alamat email yang telah terdaftar di platform nyewa.id untuk dapat merubah kata sandi', style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    TextField(
                      controller: widget.controller,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(top: 15),
                        border: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                        hintText: 'Alamat Email',
                        prefixIcon: const Icon(Iconsax.message_2_outline, color: GlobalVariables.buttonColorGreen),
                        suffixIcon: InkWell(
                          borderRadius: BorderRadius.circular(30),
                          onTap: (){},
                          child: Icon(Iconsax.send_1_outline, color: GlobalVariables.buttonColorGreen,),
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
        child: const Text("Lupa Password?", style: TextStyle(color: GlobalVariables.buttonColorGreen),))
      ],
    );
  }
}
