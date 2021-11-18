// ignore_for_file: file_names, non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Ui {
  static Future Error(message) async =>
      await Ui.ErrorSnackBar(message: message).show();
  static Future Success(message) async =>
      await Ui.SuccessSnackBar(message: message).show();

  static GetBar SuccessSnackBar(
      {String title = 'Status', @required String? message}) {
    return GetBar(
      titleText: Text(title, style: TextStyle(color: Colors.white)),
      messageText: Text(
        message!,
        style: TextStyle(color: Colors.white),
      ),
      snackPosition: SnackPosition.BOTTOM,
      margin: EdgeInsets.all(20),
      backgroundColor: Colors.green,
      icon: Icon(Icons.check_circle_outline, size: 32, color: Colors.white),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      borderRadius: 8,
      // dismissDirection: SnackDismissDirection.HORIZONTAL,
      duration: Duration(seconds: 2),
    );
  }

  static GetBar ErrorSnackBar({String title = 'Error', String? message}) {
    return GetBar(
      titleText: Visibility(
          visible: !message!.contains('Exception'),
          child: Text(title, style: TextStyle(color: Colors.white))),
      messageText: Text(
        message,
        style: TextStyle(color: Colors.white),
      ),
      snackPosition: SnackPosition.BOTTOM,
      margin: EdgeInsets.all(20),
      backgroundColor: Colors.redAccent,
      icon: Icon(Icons.remove_circle_outline, size: 32, color: Colors.white),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      borderRadius: 8,
      duration: Duration(seconds: 2),
    );
  }

  static GetBar defaultSnackBar({String title = 'Alert', String? message}) {
    Get.log("[$title] $message", isError: false);
    return GetBar(
      titleText: Text(
        title,
        style: TextStyle(color: Colors.white),
      ),
      messageText: Text(
        message!,
        style: TextStyle(color: Colors.white),
      ),
      snackPosition: SnackPosition.BOTTOM,
      margin: EdgeInsets.all(20),
      backgroundColor: Get.theme.primaryColor,
      borderColor: Get.theme.focusColor.withOpacity(0.1),
      icon: Icon(Icons.warning_amber_rounded, size: 32, color: Colors.white),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      borderRadius: 8,
      duration: Duration(seconds: 2),
    );
  }

  static GetBar notificationSnackBar(
      {String title = 'Notification', String? message}) {
    Get.log("[$title] $message", isError: false);
    return GetBar(
      titleText: Text(title),
      messageText: Text(
        message!,
      ),
      snackPosition: SnackPosition.TOP,
      margin: EdgeInsets.all(20),
      backgroundColor: Get.theme.primaryColor,
      borderColor: Get.theme.focusColor.withOpacity(0.1),
      icon:
          Icon(Icons.notifications_none, size: 32, color: Get.theme.hintColor),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      borderRadius: 8,
      duration: Duration(seconds: 5),
    );
  }

  static void ShowLoadingBar() {
    Get.dialog(Center(
      child: CircularProgressIndicator(),
    ));
  }

  static void CloseLoading() {
    if (Get.isDialogOpen == true) Get.back();
  }
}
