import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Constant/Color.dart';

class CustomToast{
  void showToast(String title,String body,bool error){
    Get.closeAllSnackbars();
    Get.showSnackbar(GetBar(
      title: title,
      message: body,
      backgroundColor: error?AppColor.redcolor:Colors.orangeAccent,
      // backgroundColor: error?colors.errorColor:colors.primaryColor,
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: 2),
    ));
  }

}