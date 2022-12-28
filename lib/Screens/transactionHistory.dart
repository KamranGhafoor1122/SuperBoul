import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:superlotto/models/TransactionsModel.dart';
import 'package:superlotto/providers/historyProvider.dart';
import 'package:tap_to_expand/tap_to_expand.dart';

import '../Constant/Color.dart';
import 'Widgets/customLoader.dart';
import 'Widgets/ticketInfoWidget.dart';

class TransactionHistory extends StatefulWidget {
  TransactionHistory({Key? key}) : super(key: key);

  @override
  State<TransactionHistory> createState() => _TransactionHistoryState();
}

class _TransactionHistoryState extends State<TransactionHistory> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<HistoryProvider>(context, listen: false).callGetTransactionsAPI(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Consumer<HistoryProvider>(builder: (context, historyProvider, child) {
      return CustomLoader(
          isLoading: historyProvider.isLoading,
          child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: AppColor.redcolor,
              title: Text(
                "Transaction History",
                style: TextStyle(color: Colors.white, fontSize: size.width * 0.037),
              ),
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.025, vertical: 10),
              child: ListView.builder(
                  itemCount: historyProvider.transactionHistory == null || historyProvider.transactionHistory!.transactionsList!.isEmpty
                      ? 0
                      : historyProvider.transactionHistory!.transactionsList!.length,
                  itemBuilder: (context, index) {
                    SingleTransaction? singleTransaction = historyProvider.transactionHistory!.transactionsList![index];
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
                          // historyProvider.transactionHistory == null
                          //     ? Container()
                          //     : TicketInfoWidget(
                          //         title: "TRANSACTION HISTORY",
                          //         info: singleTransaction.transactionId,
                          //       ),
                          SizedBox(
                            height: size.height * 0.007,
                          ),
                          historyProvider.transactionHistory == null
                              ? Container()
                              : TicketInfoWidget(
                                  title: "AMOUNT",
                                  info: singleTransaction.amount.toString(),
                                ),
                          SizedBox(
                            height: size.height * 0.007,
                          ),
                          historyProvider.transactionHistory == null
                              ? Container()
                              : TicketInfoWidget(
                                  title: "STATUS",
                                  info: singleTransaction.status,
                                ),
                          SizedBox(
                            height: size.height * 0.007,
                          ),
                          historyProvider.transactionHistory == null
                              ? Container()
                              : TicketInfoWidget(
                                  title: "TYPE",
                                  info: singleTransaction.type,
                                ),
                          SizedBox(
                            height: size.height * 0.007,
                          ),
                          historyProvider.transactionHistory == null
                              ? Container()
                              : TicketInfoWidget(
                                  title: "DATE",
                                  info: singleTransaction.transactionAt.toString(),
                                ),
                          // TextButton(
                          //   style: TextButton.styleFrom(primary: Colors.grey, elevation: 2, backgroundColor: AppColor.redcolor),
                          //   child: Text(
                          //     "View More",
                          //     style: TextStyle(fontSize: 12, color: Colors.white),
                          //   ),
                          //   onPressed: () async {},
                          // )
                        ],
                      ),
                    );
                  }),
            ),
          ));
    });
  }
}
