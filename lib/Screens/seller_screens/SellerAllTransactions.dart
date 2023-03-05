import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:superlotto/Constant/Color.dart';
import 'package:superlotto/Screens/Widgets/customLoader.dart';
import 'package:superlotto/Screens/Widgets/ticketInfoWidget.dart';
import 'package:superlotto/Screens/seller_screens/ShowTicketDetails.dart';
import 'package:superlotto/models/TransactionsModel.dart';
import 'package:superlotto/models/ViewSellerTickets.dart';
import 'package:superlotto/providers/sellerTicketsProvider.dart';
import 'package:superlotto/providers/sellerTransationsProvider.dart';


class SellerAllTransactions extends StatefulWidget {
  bool? showDetails;
  SellerAllTransactions({Key? key,this.showDetails=false}) : super(key: key);

  @override
  State<SellerAllTransactions> createState() => _SellerAllTransactionsState();
}

class _SellerAllTransactionsState extends State<SellerAllTransactions> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<SellerTransactionsProvider>(context, listen: false).callGetTransactionsAPI(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Consumer<SellerTransactionsProvider>(builder: (context, sellerTransactionsProvider, child) {
      return CustomLoader(
          isLoading: sellerTransactionsProvider.fetching,
          child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: AppColor.redcolor,
              title: Text(
                "All Transactions",
                style: TextStyle(color: Colors.white, fontSize: size.width * 0.037),
              ),
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.025, vertical: 10),
              child: ListView.builder(
                  itemCount: sellerTransactionsProvider.transactionsModel == null || sellerTransactionsProvider.transactionsModel!.transactionsList == null
                      ? 0
                      : sellerTransactionsProvider.transactionsModel!.transactionsList!.length,
                  itemBuilder: (context, index) {
                    SingleTransaction entry = sellerTransactionsProvider.transactionsModel!.transactionsList![index];
                    return Container(
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
                        children: <Widget>[
                          // SizedBox(
                          //   height: size.height * 0.01,
                          // ),
                          // winnerProvider.transactionHistory == null
                          //     ? Container()
                          //     : TicketInfoWidget(
                          //         title: "TRANSACTION HISTORY",
                          //         info: singleTransaction.transactionId,
                          //       ),
                          SizedBox(
                            height: size.height * 0.007,
                          ),

                               TicketInfoWidget(
                            title: "Transaction Id",
                            info: entry.transactionId,
                          ),
                          // SizedBox(
                          //   height: size.height * 0.007,
                          // ),
                          //  sellerTicketsProvider.viewSellerTickets == null
                          //     ? Container()
                          //     : TicketInfoWidget(
                          //         title: "TICKET NAME",
                          //         info: entry.ticketName,
                          //       ),
                          SizedBox(
                            height: size.height * 0.007,
                          ),

                            TicketInfoWidget(
                            title: "Amount",
                            info: entry.amount?.toString()??"",
                            color: Colors.red,
                          ),
                          SizedBox(
                            height: size.height * 0.007,
                          ),

                            TicketInfoWidget(
                            title: "Type",
                            info: entry.type,
                          ),
                          SizedBox(
                            height: size.height * 0.007,
                          ),

                        ],
                      ),
                    );
                  }),
            ),
          ));
    });
  }
}
