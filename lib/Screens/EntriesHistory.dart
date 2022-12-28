import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:superlotto/models/TicketsListModel.dart';
import 'package:superlotto/providers/historyProvider.dart';
import '../Constant/Color.dart';
import '../models/EntriesModel.dart';
import 'Widgets/customLoader.dart';
import 'Widgets/ticketInfoWidget.dart';

class EntriesHistoryScreen extends StatefulWidget {
  EntriesHistoryScreen({Key? key}) : super(key: key);

  @override
  State<EntriesHistoryScreen> createState() => _EntriesHistoryScreenState();
}

class _EntriesHistoryScreenState extends State<EntriesHistoryScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<HistoryProvider>(context, listen: false).callGetEntriesAPI(context);
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
                "Entries History",
                style: TextStyle(color: Colors.white, fontSize: size.width * 0.037),
              ),
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.025, vertical: 10),
              child: ListView.builder(
                  itemCount: historyProvider.entriesModel == null || historyProvider.entriesModel!.entriesList!.isEmpty
                      ? 0
                      : historyProvider.entriesModel!.entriesList!.length,
                  itemBuilder: (context, index) {
                    Entry entry = historyProvider.entriesModel!.entriesList![index];
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
                          historyProvider.entriesModel == null
                              ? Container()
                              : TicketInfoWidget(
                                  title: "LOTTERY NAME",
                                  info: entry.lotteryName,
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
                          historyProvider.entriesModel == null
                              ? Container()
                              : TicketInfoWidget(
                                  title: "TICKET #",
                                  info: entry.ticketNo,
                                ),
                          SizedBox(
                            height: size.height * 0.007,
                          ),
                          historyProvider.entriesModel == null
                              ? Container()
                              : TicketInfoWidget(
                                  title: "ENTRY",
                                  info: entry.entry.toString(),
                                ),
                          SizedBox(
                            height: size.height * 0.007,
                          ),
                          historyProvider.entriesModel == null
                              ? Container()
                              : TicketInfoWidget(
                                  title: "NUMBER",
                                  info: entry.number.toString(),
                                ),
                          SizedBox(
                            height: size.height * 0.007,
                          ),
                          historyProvider.entriesModel == null
                              ? Container()
                              : TicketInfoWidget(
                                  title: "ENTRY AT",
                                  info: entry.entryAt.toString(),
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
