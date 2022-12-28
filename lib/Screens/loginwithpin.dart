import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:otp_timer_button/otp_timer_button.dart';
import 'package:http/http.dart' as http;

import '../Constant/ApiConstant.dart';
import '../Constant/Color.dart';
import 'setPin.dart';
import 'SingupScreen.dart';
import 'Widgets/CustomeWidgets.dart';

class LoginWithPin extends StatefulWidget {
  final String phonenumber;

  const LoginWithPin(this.phonenumber, {Key? key}) : super(key: key);

  @override
  State<LoginWithPin> createState() => _LoginWithPinState();
}

var accesstoken;

class _LoginWithPinState extends State<LoginWithPin> {
  bool _isloading = false;
  var TAG = "LoginWithPin";
  Future<void> _verifyotp(var code) async {
    var url = ApiConst.BASE_URL + ApiConst.verify_code;
    setState(() {
      _isloading = true;
    });
    Map<String, dynamic> body = {"phone": widget.phonenumber, "code": code};
    var response = await http.post(Uri.parse(url), body: body);
    var responsedata = json.decode(response.body);
    debugPrint("$TAG response : ${response.body}");
    debugPrint("$TAG parameter : $body");
    var success = responsedata['success'];
    if (responsedata['success'] == true) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(responsedata['message']),
        duration: Duration(seconds: 3),
      ));
      accesstoken = responsedata['access_token'];
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => SetPin(),
          ));
    } else {
      setState(() {
        _isloading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Invalid Code"),
        duration: Duration(seconds: 3),
      ));
    }
    setState(() {
      _isloading = false;
    });
  }

  void initState() {
    debugPrint('${widget.phonenumber}');
  }

  OtpTimerButtonController controller = OtpTimerButtonController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundcolor,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  height: 150.h,
                ),
                Container(
                  height: 620.h,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Color(0xffFFFFFF),
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 0.h),
                        SizedBox(height: 130.h),
                        CustomeText(FontWeight.w600, 24.sp, 'Enter Pin,', AppColor.redcolor),
                        CustomeText(FontWeight.w400, 14.sp, 'Please enter 4 digit secret pin...', Color(0xff666666)),
                        SizedBox(height: 70.h),
                        OTPTextField(
                          length: 4,
                          width: MediaQuery.of(context).size.width,
                          fieldWidth: 50,
                          style: const TextStyle(
                            fontSize: 17,
                          ),
                          textFieldAlignment: MainAxisAlignment.spaceBetween,
                          fieldStyle: FieldStyle.underline,
                          otpFieldStyle: OtpFieldStyle(
                              borderColor: Colors.black,
                              disabledBorderColor: Colors.black,
                              enabledBorderColor: Colors.black,
                              focusBorderColor: Colors.black),
                          onCompleted: (pin) {
                            _verifyotp(pin);
                            debugPrint("Completed:  $pin");
                          },
                        ),
                        SizedBox(height: 10.h),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 0.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: const [
                              /*    InkWell(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => ChangePin(),));
                                },
                                  child: CustomeText(FontWeight.w500,14.sp,'Reset Pin',Color(0xff666666))),*/
                            ],
                          ),
                        ),
                        SizedBox(height: 20.h),
                        /*  Row(
                        children: [
                          InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
                              },
                              child: CustomeText(FontWeight.w500,14.sp,' Login with Phone No',Colors.black))
                        ],
                      ),*/
                        SizedBox(height: 150.h),
                        _isloading == false
                            ? CustomButton(
                                'Verify',
                                onpressed: () {},
                              )
                            : Container(height: 55, width: double.infinity, child: Center(child: CircularProgressIndicator())),
                        SizedBox(height: 30.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomeText(FontWeight.w400, 12.sp, 'Don’t have account! ', Color(0xff666666)),
                            InkWell(
                                onTap: () {
                                  _verifyotp;
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SingUpScreen(),
                                      ));
                                },
                                child: CustomeText(FontWeight.w600, 16.sp, 'Sing Up', AppColor.redcolor)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
                top: 70.h,
                left: 120.w,
                child: Image.asset(
                  'assets/Images/Pose3 1.png',
                  scale: 4,
                )),
          ],
        ),
      ),
    );
  }
}
