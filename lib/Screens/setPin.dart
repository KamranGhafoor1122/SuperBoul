import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:otp_timer_button/otp_timer_button.dart';
import 'package:provider/provider.dart';
import '../Constant/Color.dart';
import '../helpers/helperFunctions.dart';
import '../providers/onbordingProvider.dart';
import 'Widgets/CustomeWidgets.dart';
import 'Widgets/customLoader.dart';

// ignore: must_be_immutable
class SetPin extends StatelessWidget {
  SetPin({Key? key}) : super(key: key);

  OtpTimerButtonController controller = OtpTimerButtonController();

  String? passswordFieldController;
  String? confirmPassswordFieldController;

  var TAG = "LoginWithPin";

  _onPressSetPin(BuildContext context) async {
    if (passswordFieldController == null) {
      HelperFunctions.showSnackBar(context: context, alert: "Password is required");
    } else if (confirmPassswordFieldController == null) {
      HelperFunctions.showSnackBar(context: context, alert: "Confirm password is required");
    } else {
      Provider.of<OnboradingProvider>(context, listen: false).setPinMap = {
        "password": passswordFieldController,
        "password_confirmation": passswordFieldController,
      };
      Provider.of<OnboradingProvider>(context, listen: false).callSetPinAPI(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundcolor,
      body: Consumer<OnboradingProvider>(builder: (context, signupProvider, child) {
        return CustomLoader(
          isLoading: signupProvider.isLoading,
          child: SingleChildScrollView(
            child: Stack(
              // fit: StackFit.expand,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
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
                      child: SingleChildScrollView(
                        physics: const NeverScrollableScrollPhysics(),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 100.h),
                              CustomeText(FontWeight.w600, 24.sp, 'Set pin', AppColor.redcolor),
                              CustomeText(FontWeight.w400, 14.sp, 'Please set the pin for login...', const Color(0xff666666)),
                              SizedBox(height: 50.h),
                              CustomeText(FontWeight.w500, 16.sp, 'Enter pin', Colors.black),
                              SizedBox(height: 10.h),
                              OTPTextField(
                                length: 4,
                                width: MediaQuery.of(context).size.width,
                                fieldWidth: 50,
                                style: const TextStyle(
                                  fontSize: 17,
                                ),
                                textFieldAlignment: MainAxisAlignment.spaceBetween,
                                fieldStyle: FieldStyle.box,
                                otpFieldStyle: OtpFieldStyle(
                                    borderColor: Colors.black,
                                    disabledBorderColor: Colors.black,
                                    enabledBorderColor: Colors.black,
                                    focusBorderColor: Colors.black),
                                onChanged: (pin) {},
                                onCompleted: (pin) {
                                  passswordFieldController = pin;
                                },
                              ),
                              SizedBox(height: 10.h),
                              CustomeText(FontWeight.w500, 16.sp, 'Re-enter pin', Colors.black),
                              SizedBox(height: 10.h),
                              OTPTextField(
                                length: 4,
                                width: MediaQuery.of(context).size.width,
                                fieldWidth: 50,
                                style: const TextStyle(
                                  fontSize: 17,
                                ),
                                textFieldAlignment: MainAxisAlignment.spaceBetween,
                                fieldStyle: FieldStyle.box,
                                otpFieldStyle: OtpFieldStyle(
                                    borderColor: Colors.black,
                                    disabledBorderColor: Colors.black,
                                    enabledBorderColor: Colors.black,
                                    focusBorderColor: Colors.black),
                                onChanged: (pin) {},
                                onCompleted: (pin) {
                                  confirmPassswordFieldController = pin;
                                },
                              ),
                              // SizedBox(height: 50.h),
                              SizedBox(height: 140.h),
                              CustomButton(
                                'Confirm',
                                onpressed: () {
                                  if (passswordFieldController == confirmPassswordFieldController) {
                                    _onPressSetPin(context);
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                      content: Text("Pin Not Match"),
                                      duration: Duration(seconds: 3),
                                    ));
                                  }
                                },
                              ),

                              /*       InkWell(
                            onTap: () {
                              if(pin1 == pin2){
                                _verifyotp(pin1,pin2);
                              }else{
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content:  Text("Pin Not Match"),
                                  duration: Duration(seconds: 3),
                                ));
                              }
                        
                            },
                            child: CustomButton('Confirm')),*/
                              SizedBox(height: 30.h),
                            ],
                          ),
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
      }),
    );
  }
}
