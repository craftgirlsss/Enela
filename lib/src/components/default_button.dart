import 'package:flutter/material.dart';
import 'package:perfume/src/components/global_variable.dart';

Widget defaultButton(context, {Function()? onPressed, String? title}){
  return Padding(
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
        style: ElevatedButton.styleFrom(elevation: 0, backgroundColor: GlobalVariables.buttonColorGreen),
        onPressed: onPressed,
        child: Text(title ?? "Title", style: const TextStyle(color: GlobalVariables.textColorWhite),
        )
      )
    ),
  );
}

Widget defaultButtonWithImage(context, {Function()? onPressed, String? title, String? filename}){
  return Padding(
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
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: GlobalVariables.buttonColorWhite
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/icons/$filename', width: 20,),
            const SizedBox(width: 10),
            Text(title ?? "Title", style: const TextStyle(color: GlobalVariables.buttonColorBlack),
            ),
          ],
        )
      ),
    )
  );
}