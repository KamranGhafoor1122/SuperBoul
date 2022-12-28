import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:provider/provider.dart';
import 'package:superlotto/Constant/Color.dart';
import 'package:superlotto/Screens/SingupScreen.dart';
import 'package:superlotto/Screens/Widgets/customLoader.dart';
import 'package:superlotto/Screens/loginwithotp.dart';
import 'package:superlotto/providers/onbordingProvider.dart';

import '../helpers/helperFunctions.dart';
import 'Widgets/CustomeWidgets.dart';

// ignore: must_be_immutable
class SendOTPScreen extends StatelessWidget {
  SendOTPScreen({Key? key}) : super(key: key);

  final TextEditingController _phoneController = TextEditingController();

  late String _pin;

  _onPressSendOTP(BuildContext context) async {
    if (_phoneController.text.isEmpty) {
      HelperFunctions.showSnackBar(context: context, alert: "Phone number is required");
    } else {
      Provider.of<OnboradingProvider>(context, listen: false).phoneNumber = _phoneController.text;

      Provider.of<OnboradingProvider>(context, listen: false).callsendOTPAPI(context);
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
                          borderRadius: BorderRadius.only(topLeft: const Radius.circular(20), topRight: Radius.circular(20)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 0.h),

                              SizedBox(height: 130.h),
                              CustomeText(FontWeight.w600, 24.sp, 'Welcome SuperBoul,', AppColor.redcolor),
                              CustomeText(FontWeight.w400, 14.sp, 'Enter the phone number to receive the pin ..', const Color(0xff666666)),
                              SizedBox(height: 30.h),
                              SizedBox(
                                height: 70.h,
                                child: IntlPhoneField(
                                  // controller: _phoneController,
                                  pickerDialogStyle: PickerDialogStyle(
                                    searchFieldCursorColor: AppColor.redcolor,
                                  ),
                                  dropdownIcon: const Icon(
                                    Icons.arrow_drop_down,
                                    color: Colors.black,
                                  ),
                                  showDropdownIcon: false,
                                  flagsButtonMargin:EdgeInsets.only(left: 20),
                                  initialCountryCode: 'HT',
                                  keyboardType: TextInputType.phone,
                                  cursorColor: AppColor.redcolor,
                                  decoration: InputDecoration(
                                    fillColor: const Color(0xffEAEAEA),
                                    filled: true,
                                    border: InputBorder.none,
                                    hintText: "Phone Number",
                                    // label: const Text(
                                    //   "Phone Number",
                                    //   style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                                    // ),
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

                                  onChanged: (phone) {
                                    _phoneController.text = phone.completeNumber;
                                  },
                                  onCountryChanged: (country) {
                                    debugPrint('Country changed to: ${country.name} ');
                                    debugPrint('Country changed to:s ${country.code} ');
                                  },
                                ),
                              ),
                              // CustomTextfeild(10,_phoneController,'Phone No',''),
                              SizedBox(height: 50.h),

                              CustomButton('Send OTP', onpressed: () {
                                _onPressSendOTP(context);
                              }),

                              // Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen(),));

                              Spacer(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CustomeText(FontWeight.w400, 12.sp, 'Go back to ', const Color(0xff666666)),
                                  InkWell(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: CustomeText(FontWeight.w600, 16.sp, 'Login', AppColor.redcolor)),
                                ],
                              ),
                              SizedBox(height: 25.h),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                      top: 15.h,
                      left: 50.w,
                      child: Image.asset(
                        'assets/Images/splashlogo.png',
                        scale: 6,
                      )),
                ],
              ),
            ),
          );
        }));
  }
}
