import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:superlotto/Constant/Color.dart';
import 'package:superlotto/Screens/Widgets/customLoader.dart';
import 'package:superlotto/Screens/Widgets/ticketInfoWidget.dart';
import 'package:superlotto/models/TicketsListModel.dart';
import 'package:superlotto/models/ViewSellerTickets.dart';
import 'package:superlotto/providers/historyProvider.dart';
import 'package:superlotto/providers/sellerTicketsProvider.dart';
import 'package:superlotto/providers/winnerProvider.dart';


class SellerAllTickets extends StatefulWidget {
  SellerAllTickets({Key? key}) : super(key: key);

  @override
  State<SellerAllTickets> createState() => _SellerAllTicketsState();
}

class _SellerAllTicketsState extends State<SellerAllTickets> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<SellerTicketsProvider>(context, listen: false).callGetTicketsAPI(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Consumer<SellerTicketsProvider>(builder: (context, sellerTicketsProvider, child) {
      return CustomLoader(
          isLoading: sellerTicketsProvider.fetching,
          child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: AppColor.redcolor,
              title: Text(
                "All Tickets",
                style: TextStyle(color: Colors.white, fontSize: size.width * 0.037),
              ),
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.025, vertical: 10),
              child: ListView.builder(
                  itemCount: sellerTicketsProvider.viewSellerTickets == null || sellerTicketsProvider.viewSellerTickets!.data == null
                  || sellerTicketsProvider.viewSellerTickets!.data!.isEmpty
                      ? 0
                      : sellerTicketsProvider.viewSellerTickets!.data!.length,
                  itemBuilder: (context, index) {
                    Data entry = sellerTicketsProvider.viewSellerTickets!.data![index];
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
                          sellerTicketsProvider.viewSellerTickets == null
                              ? Container()
                              : TicketInfoWidget(
                            title: "LOTTERY NAME",
                            info: entry.lotteryName,
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
                           sellerTicketsProvider.viewSellerTickets == null
                              ? Container()
                              : TicketInfoWidget(
                            title: "User name",
                            info: entry.userName,
                            color: Colors.red,
                          ),
                          SizedBox(
                            height: size.height * 0.007,
                          ),
                           sellerTicketsProvider.viewSellerTickets == null
                              ? Container()
                              : TicketInfoWidget(
                            title: "User phone",
                            info: entry.userPhone,
                          ),
                          SizedBox(
                            height: size.height * 0.007,
                          ),
                           sellerTicketsProvider.viewSellerTickets == null
                              ? Container()
                              : TicketInfoWidget(
                            title: "Amount",
                            info:entry.amount,
                          ),

                          SizedBox(
                            height: size.height * 0.007,
                          ),
                          sellerTicketsProvider.viewSellerTickets == null
                              ? Container()
                              : TicketInfoWidget(
                            title: "Ticket Name",
                            info:entry.ticketName,
                          ),

                          SizedBox(
                            height: size.height * 0.007,
                          ),
                          sellerTicketsProvider.viewSellerTickets == null
                              ? Container()
                              : TicketInfoWidget(
                            title: "Ticket No.",
                            info:entry.ticketNo,
                          ),
                          // SizedBox(
                          //   height: size.height * 0.007,
                          // ),
                          //  sellerTicketsProvider.viewSellerTickets == null
                          //     ? Container()
                          //     : TicketInfoWidget(
                          //   title: "NUMBER",
                          //   info: entry.number.toString(),
                          // ),
                          // SizedBox(
                          //   height: size.height * 0.007,
                          // ),
                          //  sellerTicketsProvider.viewSellerTickets == null
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
