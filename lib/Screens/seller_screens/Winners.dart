import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:superlotto/Constant/Color.dart';
import 'package:superlotto/Screens/Widgets/customLoader.dart';
import 'package:superlotto/Screens/Widgets/ticketInfoWidget.dart';
import 'package:superlotto/models/SellerWinnersModel.dart';
import 'package:superlotto/models/TicketsListModel.dart';
import 'package:superlotto/providers/historyProvider.dart';
import 'package:superlotto/providers/winnerProvider.dart';

class WinnersPage extends StatefulWidget {
  WinnersPage({Key? key}) : super(key: key);

  @override
  State<WinnersPage> createState() => _WinnersPageState();
}

class _WinnersPageState extends State<WinnersPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<WinnerProvider>(context, listen: false).callSellerGetEntriesAPI(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Consumer<WinnerProvider>(builder: (context, winnerProvider, child) {
      return CustomLoader(
          isLoading: winnerProvider.fetchingSellerWinners,
          child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: AppColor.redcolor,
              title: Text(
                "Winners",
                style: TextStyle(color: Colors.white, fontSize: size.width * 0.037),
              ),
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.025, vertical: 10),
              child: ListView.builder(
                  itemCount: winnerProvider.sellerWinnersModel == null || winnerProvider.sellerWinnersModel!.data!.isEmpty
                      ? 0
                      : winnerProvider.sellerWinnersModel!.data!.length,
                  itemBuilder: (context, index) {
                    Data entry = winnerProvider.sellerWinnersModel!.data![index];
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
                          winnerProvider.sellerWinnersModel == null
                              ? Container()
                              : TicketInfoWidget(
                            title: "USER NAME",
                            info: entry.userName??"None",
                          ),
                          // SizedBox(
                          //   height: size.height * 0.007,
                          // ),
                          // winnerProvider.entriesModel == null
                          //     ? Container()
                          //     : TicketInfoWidget(
                          //         title: "TICKET NAME",
                          //         info: entry.ticketName,
                          //       ),
                          SizedBox(
                            height: size.height * 0.007,
                          ),

                          winnerProvider.sellerWinnersModel == null
                              ? Container()
                              : TicketInfoWidget(
                            title: "PRIZE NUMBERS",
                            info: entry.prizeNumber.toString(),
                          ),
                          SizedBox(
                            height: size.height * 0.007,
                          ),
                          winnerProvider.sellerWinnersModel == null
                              ? Container()
                              : TicketInfoWidget(
                            title: "PRIZE",
                            info:
                            entry.prize!.contains("first")?
                                "1st prize":
                            entry.prize!.contains("second")?
                                "2nd prize":
                            entry.prize!.contains("third")?
                                "3rd prize":
                            entry.prize.toString(),
                            color: Colors.red,
                          ),
                          SizedBox(
                            height: size.height * 0.007,
                          ),
                          winnerProvider.sellerWinnersModel == null
                              ? Container()
                              : TicketInfoWidget(
                            title: "AMOUNT #",
                            info: entry.amount,
                          ),
                          SizedBox(
                            height: size.height * 0.007,
                          ),

                          // SizedBox(
                          //   height: size.height * 0.007,
                          // ),
                          // winnerProvider.entriesModel == null
                          //     ? Container()
                          //     : TicketInfoWidget(
                          //   title: "NUMBER",
                          //   info: entry.number.toString(),
                          // ),
                          // SizedBox(
                          //   height: size.height * 0.007,
                          // ),
                          // winnerProvider.entriesModel == null
                          //     ? Container()
                          //     : TicketInfoWidget(
                          //   title: "ENTRY AT",
                          //   info: entry.entryAt.toString(),
                          // ),
                        ],
                      ),
                    );
                  }),
            ),
          ));
    });
  }
}
