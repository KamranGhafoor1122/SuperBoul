

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:superlotto/Constant/Color.dart';
import 'package:superlotto/Screens/Widgets/CustomeWidgets.dart';
import 'package:superlotto/Screens/Widgets/customLoader.dart';
import 'package:superlotto/providers/sellerTicketsProvider.dart';


class ShowBalance extends StatefulWidget {
  const ShowBalance({Key? key}) : super(key: key);

  @override
  State<ShowBalance> createState() => _ShowBalanceState();
}

class _ShowBalanceState extends State<ShowBalance> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<SellerTicketsProvider>(context, listen: false).callGetBalanceAPI(context);
    });
  }


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Consumer<SellerTicketsProvider>(
      builder:(ctx,sellerTicketsProvider,child)=>
          CustomLoader(
            isLoading: sellerTicketsProvider.fetching,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: AppColor.redcolor,
            title: Text(
              "Total Balance",
              style: TextStyle(color: Colors.white, fontSize: size.width * 0.037),
            ),
          ),
          body: sellerTicketsProvider.fetching?Container():Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 Expanded(child: CustomeText(
                     FontWeight.w600, 16,
                     "Your pending balance is : ${sellerTicketsProvider.sellerPendingBalance?.pendingBalance}", Colors.black,
                 textAlign: TextAlign.center,
                 ))
              ],
            ),
          )
        ),
      ),
    );
  }
}
