import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:superlotto/models/EntriesModel.dart';
import 'package:superlotto/models/TicketsListModel.dart';
import 'package:superlotto/models/TransactionsModel.dart';

import '../Constant/ApiConstant.dart';
import '../helpers/apiManager.dart';
import '../helpers/helperFunctions.dart';

class WinnerProvider with ChangeNotifier {
  bool get isLoading => _isLoading;
  bool _isLoading  = false;
  TransactionsModel? transactionHistory;
  TicketsListModel? ticketsListModel;

  EntriesModel? entriesModel;
  String? ticketId;
  Future<void> callGetEntriesAPI(
      BuildContext context,
      ) async {
    _isLoading = true;
    notifyListeners();
    if (entriesModel != null) {
      entriesModel!.entriesList!.clear();
    }

    try {
      HelperFunctions.getFromPreference("token").then((value) {
        Map<String, dynamic> body = <String, dynamic>{};

        log(value);

        Map<String, String> header = <String, String>{};
        header['Authorization'] = "Bearer $value";
        FocusScope.of(context).requestFocus(FocusNode());
        ApiManager networkCal = ApiManager(ApiConst.getWinnings, body, false, header);
        String? status;
        networkCal.callGetAPI(context).then((response) {
          debugPrint("API call finished");
          status = response['message'];
          _isLoading = false;
          notifyListeners();
          if (status != null && status == "success") {
            log(jsonEncode(response));
            entriesModel = EntriesModel.fromMap(response);

            String msg = response['message'];
            // HelperFunctions.showSnackBar(context: context, alert: msg);

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
