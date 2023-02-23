import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:superlotto/Screens/Widgets/PaymentSuccessfulAlert.dart';
import 'dart:math' as math;

import 'package:superlotto/models/LotteryModel.dart';
import 'package:superlotto/models/OrderStatusModel.dart';
import 'package:superlotto/models/PaymentModel.dart';
import 'package:superlotto/models/TicketModel.dart';
import 'package:superlotto/models/WalletPointsModel.dart';
import 'package:superlotto/providers/onbordingProvider.dart';
import 'package:uuid/uuid.dart';
import '../Constant/ApiConstant.dart';
import '../Screens/Widgets/ticketInfoWidget.dart';
import '../helpers/apiManager.dart';
import '../helpers/helperFunctions.dart';

class LotteryProvider with ChangeNotifier {
  bool get isLoading => _isLoading;
  bool _isLoading = false;

  WalletPoints? _walletPoints;

  WalletPoints? get walletPoints => _walletPoints;

  set walletPoints(WalletPoints? value) {
    _walletPoints = value;
    notifyListeners();
  }


  // LottteryModel? lottteryModel;

  // Future<LottteryModel?> callGetlotteryAPI(
  //   BuildContext context,
  // ) async {
  //   try {
  //     isLoading = true;

  //     notifyListeners();
  //     String token = await HelperFunctions.getFromPreference("token");
  //     Map<String, dynamic> body = <String, dynamic>{};
  //     log(token);

  //     log(jsonEncode(body));

  //     Map<String, String> header = <String, String>{};
  //     header['Authorization'] = "Bearer $token";

  //     FocusScope.of(context).requestFocus(FocusNode());
  //     ApiManager networkCal = ApiManager(ApiConst.getLottery, body, false, header);
  //     String? status;
  //     Map<String, dynamic> response = await networkCal.callGetAPI(context);

  //     debugPrint("API call finished");
  //     status = response['message'];
  //     // isLoading = false;
  //     // notifyListeners();
  //     if (status != null && status == "success") {
  //       log(jsonEncode(response));
  //       lottteryModel = LottteryModel.fromMap(response);
  //       notifyListeners();

  //       String msg = response['message'];
  //       // HelperFunctions.showSnackBar(context: context, alert: msg);

  //       // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const PlayScreen()), (Route<dynamic> route) => false);
  //     } else {
  //       // Navigator.pop(context);
  //       HelperFunctions.showAlert(
  //         context: context,
  //         header: "Superlotto",
  //         widget: Text(response['message'].toString()),
  //         onDone: () {},
  //         onCancel: () {},
  //         btnDoneText: "Ok",
  //       );
  //     }
  //     return lottteryModel;
  //   } catch (e) {
  //     log(e.toString());
  //     HelperFunctions.showSnackBar(context: context, alert: e.toString());
  //     return lottteryModel;
  //   } finally {
  //     log("in finaaly");
  //     isLoading = false;
  //     notifyListeners();
  //   }
  // }

  late String lotteryId;
  // late String lotteryNumber;
  late List lotteryNumbers;

  Future<void> calldrawEntryAPI(
    BuildContext context,
  ) async {
    _isLoading = true;

    notifyListeners();
    HelperFunctions.getFromPreference("token").then((value) {
      Map<String, dynamic> body = <String, dynamic>{};

      body["lottery_id"] = lotteryId;
      body["number"] = lotteryNumbers;
      // body["number[1]"] = "${lotteryNumbers[1]}";
      // body["number[2]"] = "${lotteryNumbers[2]}";
      // body["number[3]"] = "${lotteryNumbers[3]}";
      // body["number[4]"] = "${lotteryNumbers[4]}";
      // body["number[5]"] = "${lotteryNumbers[5]}";
      // body["number[0]"] = lotteryNumbers[0];
      // body["number[1]"] = lotteryNumbers[1];
      // body["number[2]"] = lotteryNumbers[2];
      // body["number[3]"] = lotteryNumbers[3];
      // body["number[4]"] = lotteryNumbers[4];
      // body["number[5]"] = lotteryNumbers[5];
      // body["number"] = lotteryNumber;

      log(jsonEncode(body));

      Map<String, String> header = <String, String>{};
      log(value);
      header['Authorization'] = "Bearer $value";
      FocusScope.of(context).requestFocus(FocusNode());
      ApiManager networkCal = ApiManager(ApiConst.drawEntry, body, false, header);
      bool? status;
      networkCal.callPostAPI(context).then((response) {
        debugPrint("API call finished");
        status = response['success'];
        _isLoading = false;
        notifyListeners();
        if (status != null && status == true) {
          log(jsonEncode(response));

          String msg = response['message'];
          HelperFunctions.showAlert(
            context: context,
            header: "SuperBoul",
            widget: Text(response['message'].toString()),
            onDone: () {
              Navigator.pop(context, true);
            },
            onCancel: () {},
            btnDoneText: "Ok",
          );

          // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const PlayScreen()), (Route<dynamic> route) => false);
        } else {
          // Navigator.pop(context);
          HelperFunctions.showAlert(
            context: context,
            header: "SuperBoul",
            widget: Text(response['message'].toString()),
            onDone: () {},
            onCancel: () {},
            btnDoneText: "Ok",
          );
        }
      });
    });
  }


  Future<void> callSellerdrawEntryAPI(
      BuildContext context,
      Map<String,dynamic> body
      ) async {
    _isLoading = true;

    notifyListeners();
    HelperFunctions.getFromPreference("token").then((value) {


      print("seller play body: ${body}");

      Map<String, String> header = <String, String>{};
      log(value);
      header['Authorization'] = "Bearer $value";
      FocusScope.of(context).requestFocus(FocusNode());
      ApiManager networkCal = ApiManager(ApiConst.sellerPlayNumber, body, false, header);
      bool? status;
      networkCal.callPostAPI(context).then((response) {
        debugPrint("play API call finished");
        status = response['success'];
        _isLoading = false;
        notifyListeners();
        if (status != null && status == true) {
          log(jsonEncode(response));

          String msg = response['message'];
          HelperFunctions.showAlert(
            context: context,
            header: "SuperBoul",
            widget: Text(response['message'].toString()),
            onDone: () {
              Navigator.pop(context, true);
            },
            onCancel: () {},
            btnDoneText: "Ok",
          );

          // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const PlayScreen()), (Route<dynamic> route) => false);
        } else {
          // Navigator.pop(context);
          HelperFunctions.showAlert(
            context: context,
            header: "SuperBoul",
            widget: Text(response['message'].toString()),
            onDone: () {},
            onCancel: () {},
            btnDoneText: "Ok",
          );
        }
      });
    });
  }

  late String ticketName;
  callcreateTicketAPI(
    BuildContext context,
  ) async {
    _isLoading = true;
    var size = MediaQuery.of(context).size;
    notifyListeners();
    HelperFunctions.getFromPreference("token").then((value) {
      Map<String, dynamic> body = <String, dynamic>{};

      body["lottery_id"] = lotteryId;
      body["name"] = ticketName;

      log(jsonEncode(body));

      Map<String, String> header = <String, String>{};
      header['Authorization'] = "Bearer $value";
      FocusScope.of(context).requestFocus(FocusNode());
      ApiManager networkCal = ApiManager(ApiConst.addTicket, body, false, header);
      bool? status;
      networkCal.callPostAPI(context).then((response) {
        debugPrint("API call finished");
        status = response['success'];
        _isLoading = false;
        notifyListeners();
        if (status != null && status == true) {
          log(jsonEncode(response));

          String msg = response['message'];
          HelperFunctions.showSnackBar(context: context, alert: msg);

          // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const PlayScreen()), (Route<dynamic> route) => false);
        } else {
          // Navigator.pop(context);
          HelperFunctions.showAlert(
            isDissmissOnTapAround: false,
            context: context,
            header: "SuperBoul",
            widget:response['success']==false?
            Text(response['message'].toString()):
            Container(
              padding: EdgeInsets.all(15),
              margin: EdgeInsets.symmetric(vertical: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  // SizedBox(
                  //   height: size.height * 0.01,
                  // ),
                  // historyProvider.transactionHistory == null
                  //     ? Container()
                  //     : TicketInfoWidget(
                  //         title: "TRANSACTION HISTORY",
                  //         info: singleTransaction.transactionId,
                  //       ),
                  SizedBox(
                    height: size.height * 0.007,
                  ),
                  TicketInfoWidget(
                    title: "LOTTERY NAME",
                    info: response['data']['name'],
                  ),
                  // SizedBox(
                  //   height: size.height * 0.007,
                  // ),
                  // historyProvider.entriesModel == null
                  //     ? Container()
                  //     : TicketInfoWidget(
                  //         title: "TICKET NAME",
                  //         info: entry.ticketName,
                  //       ),
                  SizedBox(
                    height: size.height * 0.007,
                  ),
                  TicketInfoWidget(
                    title: "TICKET #",
                    info: response['data']['ticket_no'],
                  ),

                  SizedBox(
                    height: size.height * 0.007,
                  ),
                  TicketInfoWidget(
                    title: "ENTRY",
                    info: response['data']['entries'].toString(),
                  ),

                  SizedBox(
                    height: size.height * 0.007,
                  ),
                  TicketInfoWidget(
                    title: "REMAINING ENTRIES",
                    info: response['data']['remaining_entries'].toString(),
                  ),

                  SizedBox(
                    height: size.height * 0.007,
                  ),
                  TicketInfoWidget(
                    title: "AMOUNT",
                    info: response['data']['amount'].toString(),
                  ),
                  SizedBox(
                    height: size.height * 0.007,
                  ),
                  TicketInfoWidget(
                    title: "STATUS",
                    info: response['data']['status'].toString(),
                  ),
                ],
              ),
            ),
            onDone: () async {
              if(response['success']!=false) {
                _isLoading = true;

                notifyListeners();

                await Provider.of<OnboradingProvider>(context,listen: false).fetchUser(context);

                HelperFunctions.showSnackBar(
                    context: context, alert: "Ticket has been confirmed.");
                _isLoading = false;
                notifyListeners();
              }
            },
            onCancel: () {},
            btnDoneText: response['success']==false?"Okay":"Confirm",
          );
        }
      });
    });
  }

  // TicketModel? ticketModel;
  // Future<void> callGetTicketAPI(
  //   BuildContext context,
  // ) async {
  //   isLoading = true;
  //   notifyListeners();
  //   try {
  //     HelperFunctions.getFromPreference("token").then((value) {
  //       Map<String, dynamic> body = <String, dynamic>{};

  //       log(jsonEncode(body));

  //       Map<String, String> header = <String, String>{};
  //       header['Authorization'] = "Bearer $value";
  //       FocusScope.of(context).requestFocus(FocusNode());
  //       ApiManager networkCal = ApiManager(ApiConst.getTicket, body, false, header);
  //       String? status;
  //       networkCal.callGetAPI(context).then((response) {
  //         debugPrint("API call finished");
  //         status = response['message'];
  //         // isLoading = false;
  //         // notifyListeners();
  //         if (status != null && status == "success") {
  //           log(jsonEncode(response));
  //           ticketModel = TicketModel.fromMap(response);

  //           String msg = response['message'];
  //           // HelperFunctions.showSnackBar(context: context, alert: msg);

  //           // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const PlayScreen()), (Route<dynamic> route) => false);
  //         } else {
  //           // Navigator.pop(context);
  //           HelperFunctions.showAlert(
  //             context: context,
  //             header: "Superlotto",
  //             widget: Text(response['message'].toString()),
  //             onDone: () {},
  //             onCancel: () {},
  //             btnDoneText: "Ok",
  //           );
  //         }
  //       });
  //     });
  //   } catch (e) {
  //     HelperFunctions.showSnackBar(context: context, alert: "Something went wrong");
  //   } finally {
  //     isLoading = false;
  //     notifyListeners();
  //   }
  // }

  Future<void> callAddCreditAPI(BuildContext context, String creditAmount) async {
    _isLoading = true;

    notifyListeners();

    Map<String, dynamic> body = <String, dynamic>{};

    body["amount"] = creditAmount;
    body["status"] = "success";
    math.Random random = math.Random();

    body["transaction_id"] = random.nextInt(100);

    log(jsonEncode(body));

    Map<String, String> header = <String, String>{};
    header['Authorization'] = "Bearer ${await HelperFunctions.getFromPreference("token")}";
    FocusScope.of(context).requestFocus(FocusNode());
    ApiManager networkCal = ApiManager(ApiConst.addcredit, body, false, header);
    String? status;
    Map<String, dynamic> response = await networkCal.callPostAPI(context);
    debugPrint("API call finished");
    status = response['message'];
    _isLoading = false;
    notifyListeners();
    if (status != null && status == "success") {
      log(jsonEncode(response));

      String msg = response['message'];
      HelperFunctions.showSnackBar(context: context, alert: msg);

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
  }

  callCreatePaymentAPI(BuildContext context, String creditAmount) async {
    Map<String, dynamic> body = <String, dynamic>{};
    body["amount"] = creditAmount;
    String orderId = Uuid().v4();
    print("current order id: $orderId");
    body["order_id"] = orderId;

    await HelperFunctions.saveInPreference("order_id", orderId);

    Map<String, String> header = <String, String>{};

    header['Authorization'] = "Bearer ${await HelperFunctions.getFromPreference("token")}";
    FocusScope.of(context).requestFocus(FocusNode());
    ApiManager networkCal = ApiManager(ApiConst.createPayment, body, false, header);
    String? status;
    Map<String, dynamic> response = await networkCal.callPostPaymentAPI(context);
    debugPrint("API call finished");
    _isLoading = false;
    notifyListeners();
      print("payment api res: ${response}");
    PaymentModel? paymentModel;
    if(response["statusCode"]==200){
      paymentModel = PaymentModel.fromJson(jsonDecode(response["body"]));
    }
    return paymentModel;
    // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const PlayScreen()), (Route<dynamic> route) => false);
  }

  callCheckOrderStatusAPI(BuildContext context) async {
    Map<String, dynamic> body = <String, dynamic>{};

    String orderId = await HelperFunctions.getFromPreference("order_id");

    print("checking order: $orderId");
    body["order_id"] = orderId;

    Map<String, String> header = <String, String>{};

    header['Authorization'] = "Bearer ${await HelperFunctions.getFromPreference("token")}";
    FocusScope.of(context).requestFocus(FocusNode());
    ApiManager networkCal = ApiManager(ApiConst.checkPaymentOrderStatus, body, false, header);
    String? status;
    Map<String, dynamic> response = await networkCal.callPostPaymentAPI(context);
    _isLoading = false;
    notifyListeners();
    print("payment status api res: ${response}");
    OrderStatusModel? orderStatusModel;

    if(response["statusCode"]==200){
      orderStatusModel = OrderStatusModel.fromJson(jsonDecode(response["body"]));
    }
    return orderStatusModel;
    // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const PlayScreen()), (Route<dynamic> route) => false);
  }

   callGetWalletPointsAPI(
      BuildContext context,
  {bool? showAlert=true}
      ) async {
    _isLoading = true;
    notifyListeners();

    try {
      HelperFunctions.getFromPreference("token").then((value) {
        Map<String, dynamic> body = <String, dynamic>{};


        Map<String, String> header = <String, String>{};
        header['Authorization'] = "Bearer $value";
        FocusScope.of(context).requestFocus(FocusNode());
        ApiManager networkCal = ApiManager(ApiConst.getWalletPoints, body, false, header);
        int? status;
        networkCal.callGetAPIPayment(context).then((response) {
          debugPrint("API call finished");
          status = response['statusCode'];
          _isLoading = false;
          notifyListeners();
          WalletPoints? points;

          if (status == 200) {
            points = WalletPoints.fromJson(jsonDecode(response["body"]));
            if(showAlert!){
              showDialog(context: context, builder: (ctx)=>PaymentSuccessfulAlert(points: points!.walletPoints??""));
            }
            walletPoints = points;
            return points;
            // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const PlayScreen()), (Route<dynamic> route) => false);
          } else {
            // Navigator.pop(context);
            HelperFunctions.showAlert(
              context: context,
              header: "SuperBoul",
              widget: Text(response['message'].toString()),
              onDone: () {},
              onCancel: () {},
              btnDoneText: "Ok",
            );
          }
        });
      });
    } catch (e) {
      HelperFunctions.showSnackBar(context: context, alert: "Something went wrong");
    }
  }
}
