import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';
import 'package:superlotto/Constant/Color.dart';
import 'package:superlotto/Screens/Widgets/customLoader.dart';
import 'package:superlotto/helpers/helperFunctions.dart';
import 'package:superlotto/providers/onbordingProvider.dart';
import 'Widgets/CustomeWidgets.dart';

class SingUpScreen extends StatelessWidget {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _referralcodeController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  var TAG = "SingUpScreen";
  DateTime? pickedDate;

  SingUpScreen({Key? key}) : super(key: key);

  _onPressSignUp(BuildContext context) async {
    if (_firstnameController.text.isEmpty) {
      HelperFunctions.showSnackBar(context: context, alert: "First name is required");
    } else if (_lastnameController.text.isEmpty) {
      HelperFunctions.showSnackBar(context: context, alert: "Last name is required");
    } else if (_phoneController.text.isEmpty) {
      HelperFunctions.showSnackBar(context: context, alert: "Phone is required");
      if (_phoneController.text.length < 10 || _phoneController.text.length > 12) {
        HelperFunctions.showSnackBar(context: context, alert: "Phone number is invalid");
      }
    } else if (_dateController.text.isEmpty) {
      HelperFunctions.showSnackBar(context: context, alert: "Please Choose Date");
    } else {
      Provider.of<OnboradingProvider>(context, listen: false).map = {
        "first_name": _firstnameController.text,
        "last_name": _lastnameController.text,
        "phone": _phoneController.text,
        "dob": pickedDate.toString(),
        "lat": '23.0555',
        "long": '69.65',
        "fcm_token": "sdvxavvddvvvvvavav",
        "referral": _referralcodeController.text.isEmpty ? " " : _referralcodeController.text,
      };

      Provider.of<OnboradingProvider>(context, listen: false).callSignUpAPI(context);
    }
  }

  var selectedDate = DateTime.now();
  var selectedDate1 = "Select Birthdate";

  TextEditingController intialdateval = TextEditingController();

  late String formattedDate;
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
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                      ),
                      child: SingleChildScrollView(
                        physics: NeverScrollableScrollPhysics(),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //       SizedBox(height: 0.h),
                              SizedBox(height: 100.h),
                              CustomeText(FontWeight.w600, 24.sp, 'Register', AppColor.redcolor),
                              CustomeText(FontWeight.w400, 14.sp, 'Please give us some details...', const Color(0xff666666)),
                              SizedBox(height: 30.h),
                              CustomTextfeild(15, _firstnameController, 'First Name', ''),
                              SizedBox(height: 15.h),
                              CustomTextfeild(15, _lastnameController, 'Last Name', ''),
                              SizedBox(height: 15.h),
                              GestureDetector(
                                  onTap: () async {
                                    pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1950),
                                      //DateTime.now() - not to allow to choose before today.
                                      lastDate: DateTime(2100),
                                      builder: (context, child) {
                                        return Theme(
                                          data: Theme.of(context).copyWith(
                                            colorScheme: const ColorScheme.light(
                                              primary: Colors.redAccent, // header background color
                                              onPrimary: Colors.black, // header text color
                                              // onSurface: Colors.green, // body text color
                                            ),
                                            textButtonTheme: TextButtonThemeData(
                                              style: TextButton.styleFrom(
                                                primary: Colors.red, // button text color
                                              ),
                                            ),
                                          ),
                                          child: child!,
                                        );
                                      },
                                    );

                                    if (pickedDate != null) {
                                      log(pickedDate.toString()); //pickedDate output format => 2021-03-10 00:00:00.000
                                      formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate!);
                                      log(formattedDate); //formatted date output using intl package =>  2021-03-16
                                      // setState(() {
                                      selectedDate = pickedDate!;
                                      _dateController.text = formattedDate; //set output date to TextField value.
                                      // });
                                    } else {}
                                  },
                                  child: AbsorbPointer(child: CustomTextfeild(15, _dateController, 'Date Of Birth', '',readOnly: true,))),

                              /*    SizedBox(
                              height: 55.h,
                              width: double.infinity,
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: TextFormField(
                                  controller: _dateController,
                                  readOnly: true,
        
                                  // maxLines: maxlines,
                                  //  focusNode: _focusNode,
                                  onTap: () async {
                                    DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1950),
                                      //DateTime.now() - not to allow to choose before today.
                                      lastDate: DateTime(2100),
                                    );
        
                                    if (pickedDate != null) {
                                      print(
                                          pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                      String formattedDate =
                                          DateFormat('dd-MM-yyyy')
                                              .format(pickedDate);
                                      print(
                                          formattedDate); //formatted date output using intl package =>  2021-03-16
                                      setState(() {
                                        _dateController.text =
                                            formattedDate; //set output date to TextField value.
                                      });
                                    } else {}
                                  },
                                  decoration: InputDecoration(
                                    border: const UnderlineInputBorder(),
                                    labelText: 'Date Of Birth',
                                    labelStyle: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black),
                                    alignLabelWithHint: false,
                                    hintText: 'Date Of Birth',
                                    filled: true,
                                    fillColor: Color(0xffEAEAEA),
                                    contentPadding: const EdgeInsets.only(
                                        left: 14.0,
                                        bottom: 6.0,
                                        top: 8.0,
                                        right: 14.0),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 0.5.w,),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.auto,
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          const BorderSide(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                ),
                              ),
                            ),*/
                              /*TextFormField(
                            // focusNode: _focusNode,
                            keyboardType: TextInputType.phone,
                            autocorrect: false,
                            controller: intialdateval,
                            onSaved: (value) {
                              //data.registrationdate = value;
                            },
                            onTap: () {
                              _selectDate1();
                              FocusScope.of(context).requestFocus(new FocusNode());
                            },
                            maxLines: 1,
                            decoration: InputDecoration(
                              labelText: 'Registration Date.',
                              //filled: true,
                              icon: const Icon(Icons.calendar_today),
                              labelStyle:
                              TextStyle(decorationStyle: TextDecorationStyle.solid),
                            ),
                          ),*/
                              /*      InkWell(
                              onTap: (){
                                _selectDate(context);
                              },
                              child: CustomTextField(label: Text('DOB'))),*/
                              //   CustomTextfeild(20,_emailController,'DOB',''),
                              SizedBox(height: 15.h),
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
                                  cursorColor: AppColor.redcolor,

                                  showDropdownIcon: false,
                                  flagsButtonMargin:EdgeInsets.only(left: 20),
                                  initialCountryCode: 'HT',
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
                                    // print(phone.completeNumber);
                                    _phoneController.text = phone.completeNumber;
                                  },
                                  onCountryChanged: (country) {
                                    debugPrint('Country changed to: ${country.name}');
                                  },
                                ),
                              ),
                              // SizedBox(
                              //     height: 50.h,
                              //     child: CustomTextfeild(
                              //       15,
                              //       _phoneController,
                              //       'Phone Number',
                              //       '',
                              //       textInputType: TextInputType.number,
                              //     )),
                              SizedBox(height: 15.h),
                              CustomTextfeild(15, _referralcodeController, 'Referral Code', ''),
                              /*      Row(
                            children: [
                              SizedBox(
                                height: 30.h,
                                width: 30.w,
                                child:Checkbox(
                                  value: _value,onChanged: (value)
                                {
                                  setState(() {_value = !_value;});
                                },
                                )
                              ),
                              CustomeText(FontWeight.w600,14.sp,'18+',const Color(0xff333333)),
                            ],
                          ),*/
                              SizedBox(height: 15.h),
                              /* Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              InkWell(
                                  onTap: (){
                                //    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginWithOtp(),));
                                  },
                                  child: CustomeText(FontWeight.w600,14.sp,'Have you referral code?',Color(0xff333333))),
        
        
                            ],
                          ),*/
                              SizedBox(height: 5.h),
                              CustomButton('Sign Up', onpressed: () {
                                signupProvider.phoneNumber = _phoneController.text;
                                // signupProvider.settingModalBottomSheet(context);
                                _onPressSignUp(context);
                              }),
                              SizedBox(height: 2.h),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // CustomeText(FontWeight.w400, 12.sp, 'Remember your details!', const Color(0xff666666)),
                                  InkWell(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: CustomeText(FontWeight.w600, 16.sp, 'Go back to login', AppColor.redcolor)),
                                ],
                              ),
                              SizedBox(height: 50),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                // Positioned(
                //     top: 70.h,
                //     left: 120.w,
                //     child: Image.asset(
                //       'assets/Images/Pose10 1.png',
                //       scale: 4,
                //     )),
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
      }),
    );
  }
}
