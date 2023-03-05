import 'package:flutter/widgets.dart';
import 'package:superlotto/Constant/ApiConstant.dart';
import 'package:superlotto/helpers/apiManager.dart';
import 'package:superlotto/helpers/helperFunctions.dart';
import 'package:superlotto/models/SellerPendingBalance.dart';
import 'package:superlotto/models/TicketDetailsModel.dart';
import 'package:superlotto/models/ViewSellerTickets.dart';

class SellerTicketsProvider with ChangeNotifier{

  bool _fetching = false;

  ViewSellerTickets? _viewSellerTickets;
  SellerPendingBalance? _sellerPendingBalance;
  TicketDetailsModel? _ticketDetailsModel;


  Future<void> callGetTicketsAPI(
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
        ApiManager networkCal = ApiManager(ApiConst.getSellerTickets, body, false, header);
        String? status;
        networkCal.callGetAPI(context).then((response) {
          debugPrint("API call finished");
          status = response['message'];
          fetching = false;
          notifyListeners();
          if (status != null && status == "success") {
            viewSellerTickets = ViewSellerTickets.fromJson(response);
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




  Future<void> callGetTicketDetailAPI(
      BuildContext context,
      int id
      ) async {
    fetching = true;
    notifyListeners();
    try {
      HelperFunctions.getFromPreference("token").then((value) {
        Map<String, dynamic> body = <String, dynamic>{};
        Map<String, String> header = <String, String>{};
        body["ticket_id"] = id;
        header['Authorization'] = "Bearer $value";
        FocusScope.of(context).requestFocus(FocusNode());
        ApiManager networkCal = ApiManager(ApiConst.getSellerEntries, body, true, header);
        networkCal.apiBody = body;
        String? status;
        networkCal.callPostAPI(context).then((response) {
          debugPrint("API call finished");
          status = response['message'];
          fetching = false;
          notifyListeners();
          if (status != null && status == "success") {
            ticketDetailsModel = TicketDetailsModel.fromJson(response);
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



  Future<void> callGetBalanceAPI(
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
        ApiManager networkCal = ApiManager(ApiConst.getSellerPendingBalance, body, false, header);
        String? status;
        networkCal.callGetAPI(context).then((response) {
          debugPrint("API call finished");
          status = response['message'];
          fetching = false;
          notifyListeners();
          if (status != null && status == "success") {
            sellerPendingBalance = SellerPendingBalance.fromJson(response);
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


  ViewSellerTickets? get viewSellerTickets => _viewSellerTickets;

  set viewSellerTickets(ViewSellerTickets? value) {
    _viewSellerTickets = value;
    notifyListeners();
  }


  SellerPendingBalance? get sellerPendingBalance => _sellerPendingBalance;

  set sellerPendingBalance(SellerPendingBalance? value) {
    _sellerPendingBalance = value;
    notifyListeners();
  }

  bool get fetching => _fetching;

  set fetching(bool value) {
    _fetching = value;
    notifyListeners();
  }

  TicketDetailsModel? get ticketDetailsModel => _ticketDetailsModel;

  set ticketDetailsModel(TicketDetailsModel? value) {
    _ticketDetailsModel = value;
    notifyListeners();
  }
}