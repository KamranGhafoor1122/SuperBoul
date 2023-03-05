import 'package:flutter/widgets.dart';
import 'package:superlotto/Constant/ApiConstant.dart';
import 'package:superlotto/helpers/apiManager.dart';
import 'package:superlotto/helpers/helperFunctions.dart';
import 'package:superlotto/models/SellerPendingBalance.dart';
import 'package:superlotto/models/TicketDetailsModel.dart';
import 'package:superlotto/models/TransactionsModel.dart';
import 'package:superlotto/models/ViewSellerTickets.dart';

class SellerTransactionsProvider with ChangeNotifier{

  bool _fetching = false;

  TransactionsModel? _transactionsModel;


  Future<void> callGetTransactionsAPI(
      BuildContext context,
      ) async {
    fetching = true;
    notifyListeners();
    try {
      HelperFunctions.getFromPreference("token").then((value) {
        Map<String, dynamic> body = <String, dynamic>{};
        Map<String, String> header = <String, String>{};
        header['Authorization'] = "Bearer $value";
        FocusScope.of(context).requestFocus(FocusNode());
        ApiManager networkCal = ApiManager(ApiConst.getSellerTransactions, body, false, header);
        String? status;
        networkCal.callGetAPI(context).then((response) {
          debugPrint("API call finished");
          status = response['message'];
          fetching = false;
          notifyListeners();
          if (status != null && status == "success") {
            transactionsModel = TransactionsModel.fromMap(response);
            String msg = response['message'];
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
    catch (e) {
      HelperFunctions.showSnackBar(context: context, alert: "Something went wrong");
    }
  }




  TransactionsModel? get transactionsModel => _transactionsModel;

  set transactionsModel(TransactionsModel? value) {
    _transactionsModel = value;
    notifyListeners();
  }

  bool get fetching => _fetching;

  set fetching(bool value) {
    _fetching = value;
    notifyListeners();
  }
}