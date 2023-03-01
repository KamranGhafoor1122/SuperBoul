

import 'package:flutter/widgets.dart';
import 'package:superlotto/Constant/ApiConstant.dart';
import 'package:superlotto/Screens/seller_screens/SellerAllTickets.dart';
import 'package:superlotto/helpers/apiManager.dart';
import 'package:superlotto/helpers/helperFunctions.dart';
import 'package:superlotto/models/ViewSellerTickets.dart';

class SellerTicketsProvider with ChangeNotifier{

  bool _fetching = false;

  ViewSellerTickets? _viewSellerTickets;


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


  ViewSellerTickets? get viewSellerTickets => _viewSellerTickets;

  set viewSellerTickets(ViewSellerTickets? value) {
    _viewSellerTickets = value;
    notifyListeners();
  }

  bool get fetching => _fetching;

  set fetching(bool value) {
    _fetching = value;
    notifyListeners();
  }
}