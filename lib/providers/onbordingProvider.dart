import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:superlotto/Constant/ApiConstant.dart';
import 'package:superlotto/Screens/HomeScreen.dart';
import 'package:superlotto/Screens/Widgets/CustomeWidgets.dart';
import 'package:superlotto/Screens/seller_screens/seller_dashboard.dart';
import 'package:superlotto/Screens/setPin.dart';
import 'package:http/http.dart' as http;
import 'package:superlotto/helpers/helperFunctions.dart';
import 'package:superlotto/models/AppUser.dart';

import '../helpers/apiManager.dart';

class OnboradingProvider with ChangeNotifier {
  bool get isLoading => _isLoading;
  bool _isLoading = false;
  late String phoneNumber;
  late String smsCode;
  Map<String, dynamic> map = {};
  Map<String, dynamic> signInMap = {};
  late AppUser appUser;
  AppUser? _user;


  AppUser? get user => _user;

  set user(AppUser? value) {
    _user = value;
    notifyListeners();
  }

  callSignUpAPI(BuildContext context) async {
    _isLoading = true;
    notifyListeners();
    Map<String, dynamic> body = <String, dynamic>{};
    body = map;

    log(jsonEncode(body));

    Map<String, String> header = <String, String>{};
    FocusScope.of(context).requestFocus(FocusNode());
    ApiManager networkCal = ApiManager(ApiConst.signup, body, false, header);

    networkCal.callPostAPI(context).then((response) {
      debugPrint("API call finished");
      bool status = response['success'];
      _isLoading = false;
      notifyListeners();
      if (status == true) {
        log(jsonEncode(response));
        settingModalBottomSheet(context);
      } else {
        if (status == false) {
          String msg = response['message'];
          HelperFunctions.showAlert(context: context, header: "Error", widget: Text(msg), btnDoneText: "ok", onDone: () {}, onCancel: () {});
        }
      }
    });
  }




  Future<AppUser?> fetchUser(BuildContext context) async {
    /*setState(() {
      isLoading = true;
    });*/
    Map<String, String> header = <String, String>{};

    String token = await HelperFunctions.getFromPreference("token");
    header['Authorization'] = "Bearer $token";

    final response = await http.get(Uri.parse(ApiConst.BASE_URL + ApiConst.getUser), headers: header);

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      log (response.body);

      user =  AppUser.fromMap(jsonDecode(response.body));
      notifyListeners();
      return user;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      HelperFunctions.showAlert(
        context: context,
        header: "SuperBoul",
        widget: Text("Error geting data"),
        onDone: () {},
        onCancel: () {},
        btnDoneText: "Ok",
      );
      throw Exception('Failed to load album');
    }
  }

  callVerifyPhoneAPI(BuildContext context) async {
    _isLoading = true;

    notifyListeners();
    Map<String, dynamic> body = <String, dynamic>{};

    body["phone"] = phoneNumber;
    body["code"] = smsCode;

    log(jsonEncode(body));

    Map<String, String> header = <String, String>{};
    FocusScope.of(context).requestFocus(FocusNode());
    ApiManager networkCal = ApiManager(ApiConst.verify_code, body, false, header);
    bool? status;
    networkCal.callPostAPI(context).then((response) {
      debugPrint("API call finished");
      status = response['success'];
      _isLoading = false;
      notifyListeners();
      if (status != null && status == true) {
        log(jsonEncode(response));
        appUser = AppUser.fromMap(response);

        HelperFunctions.saveInPreference("dbUserId", appUser.user!.id.toString());
        HelperFunctions.saveInPreference("token", appUser.accessToken.toString());
        HelperFunctions.saveInPreference("referral", appUser.user!.referral.toString());
        HelperFunctions.saveInPreference("fcm_token", appUser.accessToken.toString());
        HelperFunctions.saveInPreference("fname", appUser.user!.firstName.toString());
        HelperFunctions.saveInPreference("lname", appUser.user!.lastName.toString());
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => SetPin()));

        String msg = response['message'];
        // HelperFunctions.showSnackBar(context: context, alert: msg);

        // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const PlayScreen()), (Route<dynamic> route) => false);
      } else {
        // Navigator.pop(context);
        HelperFunctions.showAlert(
          context: context,
          header: "SuperBoul",
          widget: const Text("Invalid Otp"),
          onDone: () {},
          onCancel: () {},
          btnDoneText: "Ok",
        );
      }
    });
  }

  callsendOTPAPI(
    BuildContext context,
  ) async {
    _isLoading = true;

    notifyListeners();
    Map<String, dynamic> body = <String, dynamic>{};

    body["phone"] = phoneNumber;

    log(jsonEncode(body));

    Map<String, String> header = <String, String>{};
    FocusScope.of(context).requestFocus(FocusNode());
    ApiManager networkCal = ApiManager(ApiConst.sendOTP, body, false, header);
    bool? status;
    networkCal.callPostAPI(context).then((response) {
      debugPrint("API call finished");
      status = response['success'];
      _isLoading = false;
      notifyListeners();
      if (status != null && status == true) {
        log(jsonEncode(response));
        settingModalBottomSheet(context);

        String msg = response['message'];
        // HelperFunctions.showSnackBar(context: context, alert: msg);

        // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const PlayScreen()), (Route<dynamic> route) => false);
      } else {
        // Navigator.pop(context);
        HelperFunctions.showAlert(
          context: context,
          header: "SuperBoul",
          widget: Text(response["0"].toString()),
          onDone: () {},
          onCancel: () {},
          btnDoneText: "Ok",
        );
      }
    });
  }

  Map<String, dynamic> setPinMap = {};
  callSetPinAPI(BuildContext context) async {
    _isLoading = true;
    notifyListeners();
    HelperFunctions.getFromPreference("token").then((value) {
      Map<String, dynamic> body = <String, dynamic>{};

      body = setPinMap;

      log(jsonEncode(body));

      Map<String, String> header = <String, String>{};
      header['Authorization'] = "Bearer $value";
      log(value);
      FocusScope.of(context).requestFocus(FocusNode());
      ApiManager networkCal = ApiManager(ApiConst.set_pin, body, false, header);

      networkCal.callPostAPI(context).then((response) {
        debugPrint("API call finished");
        bool status = response['success'];
        _isLoading = false;
        notifyListeners();
        if (status == true) {
          log(jsonEncode(response));
          String msg = response['message'];
          HelperFunctions.showSnackBar(context: context, alert: msg);

          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (context) => HomeScreen(
                        token: value,
                      )),
              (Route<dynamic> route) => false);
        } else {
          if (status == false) {
            String msg = response['message'];
            HelperFunctions.showSnackBar(context: context, alert: msg);
          }
        }
      });
    });
  }

  callSignInAPI(BuildContext context) async {
    _isLoading = true;
    notifyListeners();
    Map<String, dynamic> body = <String, dynamic>{};

    body = signInMap;

    log(jsonEncode(body));

    Map<String, String> header = <String, String>{};
    FocusScope.of(context).requestFocus(FocusNode());
    ApiManager networkCal = ApiManager(ApiConst.login, body, false, header);

    networkCal.callPostAPI(context).then((response) {
      debugPrint("API call finished");
      bool status = response['success'];
      _isLoading = false;
      notifyListeners();
      if (status == true) {
        log(jsonEncode(response));
        AppUser loginedUser = AppUser.fromMap(response);
        HelperFunctions.saveInPreference("token", loginedUser.accessToken.toString()).then((value) {
          HelperFunctions.saveInPreference("dbUserId", loginedUser.user!.id.toString()).then((value) {
            HelperFunctions.saveInPreference("referral", loginedUser.user!.referral.toString());
            HelperFunctions.saveInPreference("fcm_token", loginedUser.accessToken.toString());
            HelperFunctions.saveInPreference("fname", loginedUser.user!.firstName.toString());
            HelperFunctions.saveInPreference("lname", loginedUser.user!.lastName.toString());
            HelperFunctions.saveInPreference("type", "user");

            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (context) => HomeScreen(
                          token: loginedUser.accessToken.toString(),
                        )),
                (Route<dynamic> route) => false);
          });
        });
      } else {
        if (status == false) {
          String msg = response['message'];
          HelperFunctions.showAlert(context: context, header: "Error", widget: Text(msg), btnDoneText: "ok", onDone: () {}, onCancel: () {});
        }
      }
    });
  }
  callSellerSignInAPI(BuildContext context) async {
    _isLoading = true;
    notifyListeners();
    Map<String, dynamic> body = <String, dynamic>{};
    body = signInMap;

    log(jsonEncode(body));

    Map<String, String> header = <String, String>{};
    FocusScope.of(context).requestFocus(FocusNode());
    ApiManager networkCal = ApiManager(ApiConst.login, body, false, header);

    networkCal.callPostAPI(context).then((response) {
      debugPrint("API call finished");
      bool status = response['success'];
      _isLoading = false;
      notifyListeners();
      if (status == true) {
        print("seller sign in res: ${jsonEncode(response)}");

        AppUser loginedUser = AppUser.fromMap(response);
        HelperFunctions.saveInPreference("token", loginedUser.accessToken.toString()).then((value) {
          HelperFunctions.saveInPreference("dbUserId", loginedUser.user!.id.toString()).then((value) {
            HelperFunctions.saveInPreference("referral", loginedUser.user!.referral.toString());
            HelperFunctions.saveInPreference("fcm_token", loginedUser.accessToken.toString());
            HelperFunctions.saveInPreference("fname", loginedUser.user!.firstName.toString());
            HelperFunctions.saveInPreference("lname", loginedUser.user!.lastName.toString());
            HelperFunctions.saveInPreference("type", "seller");

            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (context) => SellerDashboard(
                          token: loginedUser.accessToken.toString(),
                        )),
                (Route<dynamic> route) => false);
          });
        });
      } else {
        if (status == false) {
          String msg = response['message'];
          HelperFunctions.showAlert(context: context, header: "Error", widget: Text(msg), btnDoneText: "ok", onDone: () {}, onCancel: () {});
        }
      }
    });
  }

  final _optcontroller = OtpFieldController();

  void settingModalBottomSheet(context) {
    var size = MediaQuery.of(context).size;
    bool showVerifyButton = false;
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        // isDismissible: false,
        builder: (BuildContext bc) {
          return StatefulBuilder(builder: (BuildContext context, StateSetter setState /*You can rename this!*/) {
            return Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  Text(
                    "4 digt code is sent to\n $phoneNumber",
                    style: TextStyle(fontSize: size.width * 0.034),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  OTPTextField(
                    length: 4,
                    width: MediaQuery.of(context).size.width * 0.8,
                    fieldWidth: 50,
                    style: const TextStyle(
                      fontSize: 17,
                    ),
                    controller: _optcontroller,
                    textFieldAlignment: MainAxisAlignment.spaceBetween,
                    fieldStyle: FieldStyle.box,
                    otpFieldStyle: OtpFieldStyle(
                        borderColor: Colors.black,
                        disabledBorderColor: Colors.black,
                        enabledBorderColor: Colors.black,
                        focusBorderColor: Colors.black),
                    onCompleted: (pin) {
                      setState(() {
                        showVerifyButton = true;
                        smsCode = pin;
                      });
                      debugPrint("Completed:  $pin");
                    },
                    onChanged: (va) {},
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  showVerifyButton == true
                      ? CustomButton(
                          "Verify",
                          width: MediaQuery.of(context).size.width * 0.6,
                          onpressed: () {
                            callVerifyPhoneAPI(context);
                          },
                        )
                      : const SizedBox(),
                  const SizedBox(
                    height: 40,
                  ),
                ],
              ),
            );
          });
        });
  }
}
