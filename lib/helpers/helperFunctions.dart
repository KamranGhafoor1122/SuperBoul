import 'dart:io';
import 'dart:math';
import 'package:connectivity/connectivity.dart';
// import 'package:flutter/foundation.dart' show TargetPlatform;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

import 'package:superlotto/Constant/Color.dart';

class HelperFunctions {
  static BoxShadow shadowEffect(BuildContext context) {
    return const BoxShadow(color: Colors.grey, offset: Offset(4, 4), blurRadius: 8, spreadRadius: 0.1);
  }

  static BoxShadow shadowEffectForFields(BuildContext context) {
    return BoxShadow(offset: const Offset(0, 0), spreadRadius: 1, blurRadius: 2, color: Colors.grey.withOpacity(0.3));
  }

  static String formatTimeOfDay(TimeOfDay tod) {
    final now = new DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    final format = DateFormat.jm(); //"6:00 AM"
    return format.format(dt);
  }

  static Future<void> saveInPreference(String preName, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(preName, value);
    print('Bismillah: In save preference function');
  }

  static Future<void> removeFromPreference(String preName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(preName);
    print('Bismillah: In save preference function');
  }

  static Future<void> clearPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  static Future<String> getFromPreference(String preName) async {
    String returnValue = "";

    final prefs = await SharedPreferences.getInstance();
    returnValue = prefs.getString(preName) ?? "";
    return returnValue;
  }

  static checkNetwork() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true; //connected to mobile data
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true; // connected to a wifi network.
    } else {
      return false;
    }
  }

  static showAlert({
    required BuildContext context,
    required String header,
    required Widget widget,
    String btnDoneText = "",
    String btnCancelText = "",
    bool isDissmissOnTapAround = true,
    required VoidCallback onDone,
    required VoidCallback onCancel,
  }) {
    var platform = Theme.of(context).platform;

    Widget doneButton = platform == TargetPlatform.iOS
        ? CupertinoDialogAction(
            child: Text(
              btnDoneText,
              style: const TextStyle(fontSize: 15, color: Colors.black),
            ),
            onPressed: () {
              Navigator.of(context).pop();
              onDone();
            })
        : MaterialButton(
            child: Text(
              btnDoneText,
              style: const TextStyle(color: Colors.black),
            ),
            onPressed: () {
              Navigator.of(context).pop();
              onDone();
            },
          );

    Widget cancelButton = platform == TargetPlatform.iOS
        ? CupertinoDialogAction(
            child: Text(
              btnCancelText,
              style: const TextStyle(fontSize: 15, color: Colors.black),
            ),
            onPressed: () {
              Navigator.of(context).pop();
              onCancel();
            })
        : MaterialButton(
            child: Text(
              btnCancelText,
              style: const TextStyle(color: Colors.black),
            ),
            onPressed: () {
              Navigator.of(context).pop();
              onCancel();
            },
          );

    showDialog(
      barrierDismissible: isDissmissOnTapAround,
      context: context,
      builder: (context) {
        return Container(
            width: double.infinity,
            child: ShowCustomAlert(
              header: header,
              widget: widget,
              cancelButton: cancelButton,
              doneButton: doneButton,
              btnDoneText: btnDoneText,
              btnCancelText: btnCancelText,
            ));
      },
    );
  }

  static showMessageWithImage(BuildContext context, String message, String image) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(MediaQuery.of(context).size.width * 0.06),
            ),
          ),
          title: Container(
            height: MediaQuery.of(context).size.width * 0.15,
            width: MediaQuery.of(context).size.width * 0.15,
            child: Image(
              image: AssetImage(image),
            ),
          ),
          content: Text(
            message,
            textAlign: TextAlign.center,
          ),
        );
      },
    );
  }

  static bool isValidPassword(String value) {
    String pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,16}$';
    //r"^(?-i)(?=^.{8,}$)((?!.*\s)(?=.*[A-Z])(?=.*[a-z]))((?=(.*\d){1,})|(?=(.*\W){1,}))^.*$";
    // r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!(value.contains(regex))) {
      return false;
    } else {
      return true;
    }
  }

  static bool isValidEmail(String value) {
    String pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$";

    RegExp regex = RegExp(pattern);
    if (!(value.contains(regex))) {
      return false;
    } else {
      return true;
    }
  }

  static Future<File?> pickImage(ImageSource imageSource) async {
    File? imageFile;
    final file = await ImagePicker().pickImage(source: imageSource);
    if (file != null) {
      imageFile = File(file.path);
      return imageFile;
    } else {
      debugPrint("No image selected");
      return imageFile;
    }
  }

  static Future<File?> videoPick(ImageSource imageSource) async {
    File? videoFile;
    final file = await ImagePicker().pickVideo(source: imageSource);
    if (file != null) {
      videoFile = File(file.path);
      return videoFile;
    } else {
      debugPrint("No video selected");
      return videoFile;
    }
  }

  static double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 - c((lat2 - lat1) * p) / 2 + c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  static showSnackBar({required BuildContext context, required String alert}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.red,
      content: Text(alert),
      duration: const Duration(seconds: 1),
    ));
  }

  static clearPrefs() {
    HelperFunctions.saveInPreference('dbUserId', '');
    HelperFunctions.saveInPreference('token', '');
    HelperFunctions.saveInPreference('referral', '');
    HelperFunctions.saveInPreference('fcm_token', '');
    HelperFunctions.saveInPreference('fname', '');
    HelperFunctions.saveInPreference('lname', '');
  }
}

class ShowCustomAlert extends StatelessWidget {
  final String header;
  final Widget widget;
  final Widget cancelButton;
  final Widget doneButton;
  final String btnDoneText;
  final String btnCancelText;

  const ShowCustomAlert(
      {required this.header,
      required this.widget,
      required this.cancelButton,
      required this.doneButton,
      required this.btnDoneText,
      required this.btnCancelText});

  @override
  Widget build(BuildContext context) {
    var platform = Theme.of(context).platform;

    return platform == TargetPlatform.iOS
        ? CupertinoAlertDialog(
            title: Text(
              header,
              style: const TextStyle(
                color: AppColor.redcolor,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: Padding(
              padding: const EdgeInsets.all(8.0),
              child: widget,
            ),
            actions: [
              btnCancelText == "" ? Container() : cancelButton,
              btnDoneText == "" ? Container() : doneButton,
            ],
          )
        : AlertDialog(
            insetPadding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.04),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(MediaQuery.of(context).size.width * 0.02),
              ),
            ),
            title: Container(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.width * 0.03,
              ),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 0.1),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    header,
                    style: const TextStyle(
                      color: AppColor.redcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            content: widget,
            actions: <Widget>[
              btnCancelText == "" ? Container() : cancelButton,
              btnDoneText == "" ? Container() : doneButton,
            ],
          );
  }
}
