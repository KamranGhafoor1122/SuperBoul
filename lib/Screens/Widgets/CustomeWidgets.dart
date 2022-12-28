import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:superlotto/Constant/Color.dart';

class CustomeText extends StatelessWidget {
  String title;
  Color textcolor;
  double fontsize;
  FontWeight fontWeight;


  CustomeText(this.fontWeight, this.fontsize, this.title, this.textcolor, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(color: textcolor, fontSize: fontsize, fontWeight: fontWeight),
    );
  }
}

class CustomTextfeild extends StatelessWidget {
  final String? hint;
  final String? title;
  final TextEditingController? controller;
  final int? maxnumber;
  bool readOnly;
  final TextInputType textInputType;

   CustomTextfeild(this.maxnumber, this.controller, this.title, this.hint, {Key? key, this.textInputType = TextInputType.text,this.readOnly=false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.h,
      child: TextFormField(
        controller: controller,
        keyboardType: textInputType,
        cursorColor: AppColor.redcolor,
        decoration: InputDecoration(
          fillColor: const Color(0xffEAEAEA),
          filled: true,
          border: InputBorder.none,
          hintText: hint,

          label: Text(
            title!,
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
          ),
          labelStyle: const TextStyle(fontWeight: FontWeight.w600, color: Colors.black),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 0),
            borderRadius: BorderRadius.circular(10.r),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 0),
            borderRadius: BorderRadius.circular(10.r),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 0),
            borderRadius: BorderRadius.circular(10.r),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 0),
            borderRadius: BorderRadius.circular(10.r),
          ),
        ),
        inputFormatters: [
          LengthLimitingTextInputFormatter(maxnumber),
        ],
        readOnly:readOnly,
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  String text;
  double width;
  VoidCallback onpressed;
  CustomButton(this.text, {Key? key, this.width = double.infinity, required this.onpressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onpressed,
      child: Container(
        height: 60,
        width: width,
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.orangeAccent, AppColor.redcolor],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.all(Radius.circular(15))
            // image: DecorationImage(
            //   // scale: 1,
            //   fit: BoxFit.cover,
            //   image: AssetImage(
            //     'assets/Images/Rectangle 7.png',
            //   ),
            // ),
            ),
        child: Center(child: CustomeText(FontWeight.w500, 20.sp, text, const Color(0xffFFFFFF))),
      ),
    );
  }
}
