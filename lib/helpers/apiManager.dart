import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:superlotto/Constant/ApiConstant.dart';

import 'package:path/path.dart';
import 'package:async/async.dart';
import 'package:connectivity/connectivity.dart';

import 'helperFunctions.dart';

// import 'HelperFunctions.dart';

class ApiManager {
  String baseurl = ApiConst.BASE_URL;
  String name = "";
  Map<String, dynamic> apiBody = Map<String, dynamic>();
  Map<String, String> apiHeader = Map<String, String>();

  ApiManager(String name, Map<String, dynamic> apiBody, bool addToken, Map<String, String> header1) {
    this.name = name;
    this.apiBody = apiBody;
    this.apiHeader = header1;

    this.apiHeader[HttpHeaders.contentTypeHeader] = "application/json";
  }

  ///Post
  ///
  Future<Map<String, dynamic>> callPostAPI(BuildContext context) async {
    log('In call of Post');
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
      // Internet is available
      String url123 = this.baseurl + this.name;
      log(url123);
      try {
        final responseOfAPI =
            await http.post(Uri.parse(url123), body: jsonEncode(apiBody), headers: apiHeader).timeout(const Duration(seconds: 15), onTimeout: () {
          // Time has run out, do what you wanted to do.
          return HelperFunctions.showAlert(
              context: context,
              header: "EDS",
              widget: Text("'The connection has timed out, Please try again!'"),
              onDone: () {
                Navigator.pop(context);
              },
              btnDoneText: "ok",
              onCancel: () {}); // Replace 500 with your http code.
        });
        log("here");
        print(responseOfAPI.statusCode);
        print(responseOfAPI.body);
        Map<String, dynamic> fResponse = json.decode(responseOfAPI.body);
        return fResponse;
      } on FormatException catch (error) {
        print("FormatException: " + error.message);
        throw error;
      } on ArgumentError catch (error) {
        print("ArgumentError: " + error.message);
        throw error;
      } catch (error) {
        print("Exception: " + error.toString());
        throw error;
      }
    } else {
      noInternet(context);
      Map<String, dynamic> fResponse = Map();
      return fResponse;
    }
  }


  Future<Map<String, dynamic>> callPostPaymentAPI(BuildContext context) async {
    log('In call of Post');
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
      // Internet is available
      String url123 = this.baseurl + this.name;
      log(url123);
      try {
        final responseOfAPI =
        await http.post(Uri.parse(url123), body: jsonEncode(apiBody), headers: apiHeader).timeout(const Duration(seconds: 15), onTimeout: () {
          // Time has run out, do what you wanted to do.
          return HelperFunctions.showAlert(
              context: context,
              header: "EDS",
              widget: Text("'The connection has timed out, Please try again!'"),
              onDone: () {
                Navigator.pop(context);
              },
              btnDoneText: "ok",
              onCancel: () {}); // Replace 500 with your http code.
        });
        log("here");
        print(responseOfAPI.statusCode);
        print(responseOfAPI.body);
        Map<String, dynamic> fResponse = {};
        fResponse["statusCode"]=responseOfAPI.statusCode;
        fResponse["body"]=responseOfAPI.body;
        return fResponse;
      } on FormatException catch (error) {
        print("FormatException: " + error.message);
        throw error;
      } on ArgumentError catch (error) {
        print("ArgumentError: " + error.message);
        throw error;
      } catch (error) {
        print("Exception: " + error.toString());
        throw error;
      }
    } else {
      noInternet(context);
      Map<String, dynamic> fResponse = Map();
      return fResponse;
    }
  }
  ///Get
  ///

  Future<Map<String, dynamic>> callGetAPI(BuildContext context) async {
    print('In call of Get');

    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
      String url123 = this.baseurl + this.name;
      log(url123);
      try {
        final responseOfAPI = await http.get(Uri.parse(url123), headers: apiHeader).timeout(
          const Duration(seconds: 15),
          onTimeout: () {
            // Time has run out, do what you wanted to do.
            return HelperFunctions.showAlert(
                context: context,
                header: "My study plans",
                widget: Text("'The connection has timed out, Please try again!'"),
                onDone: () {
                  Navigator.pop(context);
                },
                btnDoneText: "ok",
                onCancel: () {}); // Replace 500 with your http code.
          },
        );

        log(responseOfAPI.body);
        Map<String, dynamic> fResponse = json.decode(responseOfAPI.body);
        return fResponse;
        //this.delegate.apiCallback(fResponse);
      } on FormatException catch (error) {
        print("FormatException: " + error.message);
        throw error;
      } on ArgumentError catch (error) {
        print("ArgumentError: " + error.message);
        throw error;
      } catch (error) {
        print("Exception: " + error.toString());
        throw error;
      }
    } else {
      noInternet(context);
      Map<String, dynamic> fResponse = Map();
      return fResponse;
    }
  }
  Future<Map<String, dynamic>> callGetAPIPayment(BuildContext context) async {
    print('In call of Get');

    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
      String url123 = this.baseurl + this.name;
      log(url123);
      try {
        final responseOfAPI = await http.get(Uri.parse(url123), headers: apiHeader).timeout(
          const Duration(seconds: 15),
          onTimeout: () {
            // Time has run out, do what you wanted to do.
            return HelperFunctions.showAlert(
                context: context,
                header: "My study plans",
                widget: Text("'The connection has timed out, Please try again!'"),
                onDone: () {
                  Navigator.pop(context);
                },
                btnDoneText: "ok",
                onCancel: () {}); // Replace 500 with your http code.
          },
        );

        log(responseOfAPI.body);
        print("get api payment res; ${responseOfAPI.body}");
        Map<String, dynamic> fResponse = {};
        fResponse["statusCode"]=responseOfAPI.statusCode;
        fResponse["body"]=responseOfAPI.body;
        return fResponse;
        //this.delegate.apiCallback(fResponse);
      } on FormatException catch (error) {
        print("FormatException: " + error.message);
        throw error;
      } on ArgumentError catch (error) {
        print("ArgumentError: " + error.message);
        throw error;
      } catch (error) {
        print("Exception: " + error.toString());
        throw error;
      }
    } else {
      noInternet(context);
      Map<String, dynamic> fResponse = Map();
      return fResponse;
    }
  }

  ///delete
  ///
  Future<Map<String, dynamic>> callDeleteAPI(BuildContext context) async {
    log('In call of Delete');

    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
      String url123 = this.baseurl + this.name;

      try {
        final responseOfAPI = await http.delete(Uri.parse(url123), headers: apiHeader);
        log(responseOfAPI.body);
        Map<String, dynamic> fResponse = json.decode(responseOfAPI.body);

        return fResponse;
      } on FormatException catch (error) {
        print("FormatException: " + error.message);
        throw error;
      } on SocketException catch (error) {
        print("SocketException: " + error.message);
        throw error;
      } on ArgumentError catch (error) {
        print("ArgumentError: " + error.message);
        throw error;
      } catch (error) {
        print(error);
        throw error;
      }
    } else {
      noInternet(context);
      Map<String, dynamic> fResponse = Map();
      return fResponse;
    }
  }

  noInternet(BuildContext context) {
    HelperFunctions.showMessageWithImage(
        context, 'You are not connected to internet. Please check your internet connection and try again...', 'assets/images/no_internet.png');
  }
}

///multipart
///

class CustomMultipartObject {
  File? file;
  String param;

  CustomMultipartObject({required this.file, required this.param});
}

class ApiCallMultiPart {
  String baseurl = ApiConst.BASE_URL;
  String name = "";
  Map<String, String> apiBody = Map<String, String>();
  Map<String, String> apiHeader = Map<String, String>();

  ApiCallMultiPart(String name, Map<String, String> apiBody, Map<String, String> header1) {
    this.name = name;
    this.apiBody = apiBody;
    this.apiHeader = header1;

    this.apiHeader[HttpHeaders.contentTypeHeader] = "application/json";
  }

  Future<Map<String, dynamic>> callMultipartPostAPI(List<CustomMultipartObject> files, BuildContext context) async {
    log('In call of Multipart');
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
      String url123 = this.baseurl + this.name;
      Uri uri = Uri.parse(url123);
      log(url123);
      var request = http.MultipartRequest("POST", uri);
      request.headers.addAll(apiHeader);
      request.fields.addAll(apiBody);

      files.forEach((file) {
        var stream = new http.ByteStream(DelegatingStream(file.file!.openRead()));

        file.file!.length().then((length) {
          var multipartFile = new http.MultipartFile(file.param, stream, length, filename: basename(file.file!.path));
          request.files.add(multipartFile);
          print("Name: " + multipartFile.field);
          //print("Media: " + multipartFile.filename);
        });
      });

      print("No.Files: " + request.files.length.toString());

      try {
        var streamedResponse = await request.send();
        var response = await http.Response.fromStream(streamedResponse);
        print(streamedResponse);
        print("Code: " + response.statusCode.toString());
        print("Code: " + response.request.toString());

        final prefix = "ï»¿";
        var body = response.body;
        if (body.startsWith(prefix)) {
          body = body.substring(prefix.length);
        }

        log(body);
        Map<String, dynamic> fResponse = json.decode(body);

        return fResponse;
      } on FormatException catch (error) {
        print("FormatException: " + error.message);
        log(error.toString());
        throw error;
      } on ArgumentError catch (error) {
        print("ArgumentError: " + error.message);
        throw error;
      } catch (error) {
        print("Exception: " + error.toString());
        throw error;
      }
    } else {
      HelperFunctions.showMessageWithImage(
          context, 'You are not connected to internet. Please check your internet connection and try again...', 'resources/images/no_internet.png');
      Map<String, dynamic> fResponse = Map();
      return fResponse;
    }
  }
}
