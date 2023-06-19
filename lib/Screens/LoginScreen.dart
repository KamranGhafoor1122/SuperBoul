import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:provider/provider.dart';
import 'package:superlotto/Constant/ApiConstant.dart';
import 'package:superlotto/Constant/Color.dart';
import 'package:superlotto/Screens/SingupScreen.dart';
import 'package:superlotto/Screens/Widgets/customLoader.dart';
import 'package:superlotto/Screens/loginwithotp.dart';
import 'package:superlotto/localization/language_constrants.dart';
import 'package:superlotto/models/language_model.dart';
import 'package:superlotto/providers/language_provider.dart';
import 'package:superlotto/providers/localization_provider.dart';
import 'package:superlotto/providers/onbordingProvider.dart';

import '../helpers/helperFunctions.dart';
import 'Widgets/CustomeWidgets.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _phoneController = TextEditingController();

  TextEditingController _passwordController = TextEditingController();

  late String _pin;

  String type = "user";
  LanguageModel? _dropDownValue;

  _onPressSignIn(BuildContext context) async {
    if (_phoneController.text.isEmpty) {
      HelperFunctions.showSnackBar(context: context, alert: "Phone number is required");
    } else if (_pin == null) {
      HelperFunctions.showSnackBar(context: context, alert: "Last name is required");
    } else {
      Provider.of<OnboradingProvider>(context, listen: false).signInMap = {
        "phone": _phoneController.text,
        "password": _pin,
      };

      Provider.of<OnboradingProvider>(context, listen: false).callSignInAPI(context);
    }
  }

  _onPressSellerSignIn(BuildContext context) async {
      Provider.of<OnboradingProvider>(context, listen: false).signInMap = {
        "phone": _phoneController.text,
        "password": _passwordController.text.trimRight(),
      };
      Provider.of<OnboradingProvider>(context, listen: false).callSellerSignInAPI(context,_phoneController.text);
  }

  @override
  Widget build(BuildContext context) {

    Provider.of<LanguageProvider>(context, listen: false).initializeAllLanguages(context);
     final languageProvider = Provider.of<LanguageProvider>(context, listen: false);

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
                        height: 120.h,
                      ),
                      Container(
                        height: 700.h,
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

                              SizedBox(height: 80.h),
                              CustomeText(FontWeight.w600, 24.sp, getTranslated("Welcome SuperBoul,", context), AppColor.redcolor),
                              CustomeText(FontWeight.w400, 14.sp, 'Thank you for remember...', const Color(0xff666666)),
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
                                  keyboardType: TextInputType.phone,

                                  showDropdownIcon: false,
                                  // disableLengthCheck: true,
                                  flagsButtonMargin:EdgeInsets.only(left: 20),
                                  initialCountryCode: 'HT',
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
                                  },
                                ),
                              ),
                              // CustomTextfeild(10,_phoneController,'Phone No',''),
                              SizedBox(height: 20.h),
                              type == "user" ? OTPTextField(
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
                                onChanged: (va) {},
                                onCompleted: (pin) {
                                  _pin = pin;
                                  debugPrint("Completed:$pin");
                                },
                              ):CustomTextfeild(null, _passwordController, "Password", "Enter password",obscureText: true,),


                              SizedBox(height: 20.h),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => SendOTPScreen(),
                                            ));
                                      },
                                      child: CustomeText(FontWeight.w400, 14.sp, 'Forgot Pin?', const Color(0xff666666))),
                                ],
                              ),


                              SizedBox(height: 15.h),
                              CustomButton('Login', onpressed: () {
                                if(type == "user"){
                                  if (_pin.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                      content: Text("Pin Is Required"),
                                      duration: Duration(seconds: 3),
                                    ));
                                  } else {
                                    _onPressSignIn(context);
                                  }
                                }
                                else{
                                   if(_phoneController.text.isEmpty){
                                     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                       content: Text("Phone is required"),
                                       duration: Duration(seconds: 3),
                                     ));
                                     return;
                                   }
                                   if(_passwordController.text.isEmpty){
                                     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                       content: Text("Password is required"),
                                       duration: Duration(seconds: 3),
                                     ));
                                     return;
                                   }

                                   _onPressSellerSignIn(context);
                                }

                              }),

                              SizedBox(height: 10.h),

                              Center(
                                child: TextButton(onPressed: (){
                                  setState(() {
                                    if(type == "user"){
                                      type = "seller";
                                    }
                                    else{
                                      type = "user";
                                    }
                                  });
                                }, child:

                                type == "user"?CustomeText(FontWeight.w600,15,"Continue as Seller?",Colors.black,):
                                CustomeText(FontWeight.w600,15,"Continue as User?",Colors.black,)
                              ),
                              ),


                              // Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen(),));

                              SizedBox(height: 25.h),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CustomeText(FontWeight.w400, 12.sp, 'Don’t have account! ', const Color(0xff666666)),
                                  /*InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => SingUpScreen(),
                                            ));
                                      },
                                      child: CustomeText(FontWeight.w600, 16.sp, 'Sign Up', AppColor.redcolor)),*/
                                ],
                              ),
                              SizedBox(height: 7.h),

                              CustomButton('Signup', onpressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SingUpScreen(),
                                    ));
                              }),




                          DropdownButton<LanguageModel>(
                            hint: _dropDownValue == null
                                ? Text('Choose Language')
                                : Text(
                              _dropDownValue?.languageName??"",
                              style: TextStyle(color: Colors.black),
                            ),
                            isExpanded: true,
                            iconSize: 30.0,
                            style: TextStyle(color: Colors.black),
                            items: languageProvider.languages.map(
                                  (language) {
                                return DropdownMenuItem<LanguageModel>(
                                  value: language,
                                  child: Text(language.languageName),
                                );
                              },
                            ).toList(),
                            onChanged: (LanguageModel? language) {
                              setState(
                                    () {
                                  _dropDownValue = language;

                                  if(language?.languageName == "English"){
                                    Provider.of<LocalizationProvider>(context, listen: false).setLanguage(Locale(
                                      ApiConst.languages[0].languageCode,
                                      ApiConst.languages[0].countryCode,
                                    ));
                                  }
                                  else{
                                    Provider.of<LocalizationProvider>(context, listen: false).setLanguage(Locale(
                                      ApiConst.languages[1].languageCode,
                                      ApiConst.languages[1].countryCode,
                                    ));
                                  }
                                },
                              );
                            },
                          )

                            ],
                          ),
                        ),
                      ),
                    ],
                  ),


                  Positioned(
                      top: 1.h,
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
