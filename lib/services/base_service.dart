// import 'dart:convert';
// import 'dart:developer';
// import 'package:afla/Utils/myapp.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
// import '../Component/custom_toast.dart';
// import '../Component/custom_text.dart';
// import '../Utils/local_db_keys.dart';
// import 'api_endpoints.dart';
//
//
// class BaseService {
//   late String baseURL = APIEndpoints.baseURL;
//   // late String baseURL = "https://22f5-2400-adc1-125-f500-9407-8bcc-4c70-2154.ngrok.io/api";
//   String? token;
//
//   Future baseGetAPI(url,
//       {successMsg, loading, status,utfDecoded,bool return404=false,bool errorToast=true,bool direct=false,hasToken=true}) async {
//
//     if (loading == true && loading != null) {
//       EasyLoading.show(status: 'Please wait...');
//     }
//
//     SharedPreferences storage = await SharedPreferences.getInstance();
//     token=storage.getString(LocalDBKeys.TOKEN);
//     print("url");
//     print(url);
//     print(token.toString());
//     String bearerAuth = 'Bearer ' + "$token";
//     // String bearerAuth = 'Bearer ' + "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6ImFjYWY3NjBlNmJhNTU3Mjc5YWI4YTBkZDE2ODkyN2NmYTAwYjY4OWNiMjYwOGI3Y2IxNjYyNGE1YjI3NzI5N2NiM2I0MWI5NTliZDE4OTIwIn0.eyJhdWQiOiIxIiwianRpIjoiYWNhZjc2MGU2YmE1NTcyNzlhYjhhMGRkMTY4OTI3Y2ZhMDBiNjg5Y2IyNjA4YjdjYjE2NjI0YTViMjc3Mjk3Y2IzYjQxYjk1OWJkMTg5MjAiLCJpYXQiOjE2NjEyMjE1ODksIm5iZiI6MTY2MTIyMTU4OSwiZXhwIjoxNjkyNzU3NTg5LCJzdWIiOiIyIiwic2NvcGVzIjpbXX0.kyHvYUjN17vY84e4avf_CD9BMNsFzrviYJN2sVSX-MHU_x6rk07iWtS89DboNVjhx08cGPGEGnRi-Hh1Z4Qtd4Fspoqupf0oagzc00Twhx3JFbtd5HQcAV6rAC3jGHbdTCxcKHxf7uQrJgYZbzP9ZbzWIq3GOSfN3SAX7JOcAPPh8HPALMj3XCa6EOYKqnEMgl6qeHunZEbeg4ul1u_jbkhCR8sHraBDrEQwdqbEGVpqK_xRcu8UZVVIUqcRdAHbTRVu9LoePrA9AjDfNg8wsCcXdEVil8c3O1LVPXR-85jVkYp3Ubi3J17UKtpljsfpRXN6ooG7YfwzcqS486F0to1aKs33UM-nvuN4MTXPYCm0lhxMrJfEb9I-GyRmhrjSzNlR_CVLI5gsByCI7aTm0_OlDvSTRiRbrEHixxCdhbtJP_X6zd6vsCFVY012Lt7a8e_cAtvJ8wTT16iH6nNK_oSVFzHipxScU5NLstVmiO23pM5SnGyJUTCjmdUm1_wc8bjZkGzh6lbSz8kvUPS-GjRxPp-9l_WzR2yjBOwClyWWt2yQW2H-cxNg46_UhmcB99nZyQKoCt379x0Ar4H1blJ95NM2cffnKtcohNQpk86bjEU9caF-XM9TU1E5sfW9ofJIjST1tmRONzPNnzyPY1laOzwS6Ec7XrPu3h6NYus";
//
//
//     http.Response response;
//     try {
//       response = await http.get(
//         Uri.parse(url),
//         headers: hasToken==true ?<String, String>{
//           'Content-Type': 'application/json; charset=UTF-8',
//           'Authorization': bearerAuth,
//           'Accept':'application/json'
//         }:null,
//       );
//       _logRequestOnAlice(response);
//       log(response.body);
//       log("Status code");
//       log(response.statusCode.toString());
//       EasyLoading.dismiss();
//       if(direct==true){
//         return response.body;
//       }
//
//       if (status != null) {
//         return response.statusCode;
//       }
//
//       var jsonData;
//       if (response.statusCode == 200) {
//         if(utfDecoded==true)
//         {
//           jsonData = json.decode(utf8.decode(response.bodyBytes));
//
//           return jsonData;
//         }
//         jsonData = json.decode(response.body);
//         if (successMsg != null) {
//           CustomToast().showToast("",successMsg, false);
//         }
//         return jsonData;
//       }
//       else if (response.statusCode == 401) {
//         jsonData = json.decode(response.body);
//         return jsonData;
//
//
//       }
//       else {
//
//         jsonData = json.decode(response.body);
//         return jsonData;
//       }
//     } catch (SocketException) {
//       EasyLoading.dismiss();
//       AlertDialog(
//         content: SingleChildScrollView(
//             physics: BouncingScrollPhysics(),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 Icon(
//                   Icons.error,
//                   color: Colors.red,
//                   size: 20,
//                 ),
//                 SizedBox(height: 10),
//                 MyText(
//                   title:
//                   "There seems to be your network problem or a server side issue. Please try again or report the bug to the manager.",
//                   clr: Colors.white,
//                   size: 13,
//                 ),
//                 SizedBox(height: 20),
//               ],
//             )),
//         actions: <Widget>[
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               MaterialButton(
//                 // color: terColor,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(20.0),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 4.0),
//                   child: new MyText(
//                     title: "Okay",
//                     size: 13,
//                     clr: Colors.red,
//                   ),
//                 ),
//                 // color: secondaryColor,
//                 onPressed: () {
//                   Get.back();
//                 },
//               ),
//             ],
//           ),
//         ],
//       );
//       return null;
//     }
//   }
//
//   Future basePostAPI(url, body,
//       {successMsg, loading,loadingOff}) async {
//
//     if (loading == true && loading != null) {
//       EasyLoading.show(status: 'Please wait...');
//     }
//
//     SharedPreferences storage = await SharedPreferences.getInstance();
//     token=storage.getString(LocalDBKeys.TOKEN);
//     print("url here ");
//     print(url);
//     print(body);
//     print(token.toString());
//     String bearerAuth = 'Bearer ' + "$token";
//
//     http.Response response;
//
//     try {
//       response = await http.post(Uri.parse(baseURL + url),
//           headers: <String, String>{
//             'Accept': 'application/json',
//             'Content-Type': 'application/json; charset=UTF-8',
//             'Authorization': bearerAuth
//           },
//           body: jsonEncode(body));
//       print("Response here");
//       print(baseURL + url);
//       print(response.body);
//       _logRequestOnAlice(response);
//       if(loadingOff==null)
//         EasyLoading.dismiss();
//
//       var jsonData;
//       jsonData = json.decode(response.body);
//       return jsonData;
//       if (response.statusCode == 200) {
//         jsonData = json.decode(response.body);
//         if (successMsg != null) {
//           CustomToast().showToast("Message",successMsg, false);
//         }
//         return jsonData;
//       } else if (response.statusCode == 400) {
//         jsonData = json.decode(response.body);
//         // CustomToast().showToast("Error",jsonData["message"], true);
//         // return {};
//         return jsonData;
//       } else if (response.statusCode == 401) {
//         jsonData = json.decode(response.body);
//
//         return {};
//       } else {
//         jsonData = json.decode(response.body);
//         throw Exception('Failed');
//       }
//     } catch (SocketException) {
//       print("Catch ma");
//       print(SocketException);
//       EasyLoading.dismiss();
//       return null;
//     }
//   }
//
//
//   Future baseFormPostAPI(url, Map<String, String> body, files, keys, context,
//       {successMsg, loading, pop = true}) async {
//     EasyLoading.instance.userInteractions=false;
//     if (loading == true && loading != null) {
//       EasyLoading.show(status: 'Please wait...',dismissOnTap: false);
//     }
//     SharedPreferences storage = await SharedPreferences.getInstance();
//     token=storage.getString(LocalDBKeys.TOKEN);
//     print(url);
//     print(token.toString());
//     String bearerAuth = 'Bearer ' + "$token";
//     try {
//       var request = http.MultipartRequest('POST', Uri.parse(baseURL + url));
//
//       request.headers.addAll({ 'Accept': 'application/json',
//         'Content-Type': 'application/json; charset=UTF-8',"Authorization": "${bearerAuth}"});
//       // headers: <String, String>{
//       //   'Accept': 'application/json',
//       //   'Content-Type': 'application/json; charset=UTF-8',
//       //   'Authorization': bearerAuth
//       // },
//
//       for (int i = 0; i < files.length && files != null; i++) {
//         request.files
//             .add(await http.MultipartFile.fromPath(keys[i], files[i].path));
//       }
//       request.fields.addAll(body);
//
//       var response = await request.send();
//       if(loading==true){
//         EasyLoading.dismiss();
//       }
//
//       print(response.statusCode.toString() +"check status");
//
//
//       if (response.statusCode == 200) {
//         if (successMsg != null) {
//           CustomToast().showToast("Message", successMsg, false);
//         }
//         if (pop == true) {
//           // Modular.to.pop();
//         }
//
//         var temp = await response.stream.bytesToString();
//         print(temp);
//
//         return json.decode((temp));
//       }
//       else if (response.statusCode == 400) {
//         var temp = await response.stream.bytesToString();
//         return json.decode(temp);
//       } else if (response.statusCode == 401) {
//         var temp = await response.stream.bytesToString();
//         return json.decode(temp);
//       } else if (response.statusCode == 500) {
//         var temp = await response.stream.bytesToString();
//         CustomToast().showToast('Error', 'Something went wrong.', true);
//         return json.decode(temp);
//       }
//       else {
//         throw Exception('Failed');
//       }
//     } catch (SocketException) {
//       log(SocketException.toString());
//       CustomToast().showToast('Error', 'Something went wrong.', true);
//       EasyLoading.dismiss();
//       return null;
//     }
//   }
//
//   static void _logRequestOnAlice(http.Response response) {
//     if (isDevelopmentMode==true) {
//       // alice.onHttpResponse(response);
//     }
//   }
// }