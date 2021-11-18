// ignore_for_file: non_constant_identifier_names

import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

kDialog(title, Content, onConfirm) {
  Get.defaultDialog(
    title: title,
    content:
        KTextFont(Content, color: Colors.black, size: 16, CenterText: true),
    cancel: KButton(
        onTap: () {
          Get.back();
        },
        child: Text('Cancel'),
        color: Colors.red),
    confirm: KButton(onTap: onConfirm, child: Text('Yes'), color: Colors.green),
  );
}

KTextFont(text,
    {Color color = Colors.white,
    double? size,
    CenterText = false,
    double pading = 0.0}) {
  return Padding(
    padding: EdgeInsets.all(pading),
    child: Text(
      text,
      textAlign: CenterText ? TextAlign.center : TextAlign.start,
      style: GoogleFonts.lato(
          textStyle: TextStyle(color: color, fontSize: size ?? 20)),
    ),
  );
}

KButton({
  onTap,
  Widget? child,
  Color color = Colors.blue,
  double? Width,
  double? Height,
  double pading = 20,
  DisableElevation = false,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: pading),
    child: ElevatedButton(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: child ?? KTextFont(' Bluetooth'),
        ),
        style: ButtonStyle(
            minimumSize: MaterialStateProperty.all<Size>(
                Size(Width ?? Get.width / 4, Height ?? 20)),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            backgroundColor: MaterialStateProperty.all<Color>(color),
            //shadowColor: MaterialStateProperty.all<Color>(Colors.white),
            elevation:
                DisableElevation ? MaterialStateProperty.all<double?>(0) : null,
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(color: color)))),
        onPressed: onTap),
  );
}
