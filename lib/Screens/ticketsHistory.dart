import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:superlotto/Screens/EntriesHistory.dart';
import 'package:superlotto/models/TicketsListModel.dart';
import 'package:superlotto/models/TransactionsModel.dart';
import 'package:superlotto/providers/historyProvider.dart';
import 'package:tap_to_expand/tap_to_expand.dart';

import '../Constant/Color.dart';
import '../helpers/helperFunctions.dart';
import 'Widgets/customLoader.dart';
import 'Widgets/ticketInfoWidget.dart';

class TicketsHistoryScreen extends StatefulWidget {
  TicketsHistoryScreen({Key? key}) : super(key: key);

  @override
  State<TicketsHistoryScreen> createState() => _TicketsHistoryScreenState();
}

class _TicketsHistoryScreenState extends State<TicketsHistoryScreen> {
  RxString start = "To".obs;
  RxString end = "From".obs;
  RxString endDate ="".obs;
  RxString startDate ="".obs;
  DateTime _chosenDateTime = DateTime.now();


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<HistoryProvider>(context, listen: false).callGetTicketsListAPI(context);
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
                "Tickets History",
                style: TextStyle(color: Colors.white, fontSize: size.width * 0.037),
              ),
              actions: [
                GestureDetector(
                    onTap: (){
                      HelperFunctions.showAlert(
                        context: context,
                        header: "SuperBoul",
                        widget: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(height: 15),
                            Text("Time Period"),
                            SizedBox(height: 15),
                            Obx(()=> Row(
                                children: [
                                  Flexible(
                                    child: GestureDetector(
                                      onTap: () async {
                                        var date =  await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(1950),
                                          //DateTime.now() - not to allow to choose before today.
                                          lastDate: DateTime(2100),
                                          builder: (context, child) {
                                            return Theme(
                                              data: Theme.of(context).copyWith(
                                                colorScheme: const ColorScheme.light(
                                                  primary: Colors.redAccent, // header background color
                                                  onPrimary: Colors.black, // header text color
                                                  // onSurface: Colors.green, // body text color
                                                ),
                                                textButtonTheme: TextButtonThemeData(
                                                  style: TextButton.styleFrom(
                                                    primary: Colors.red, // button text color
                                                  ),
                                                ),
                                              ),
                                              child: child!,
                                            );
                                          },
                                        );
                                        print(date);
                                        if (date == null) return;
                                        setState(() {
                                          end.value = date.day.toString() +
                                              "/" +
                                              date.month.toString() +
                                              "/" +
                                              date.year.toString();
                                          // endDate.value=date.toString();
                                          endDate.value=date.year.toString() +
                                              "-" +
                                              date.month.toString() +
                                              "-" +
                                              date.day.toString();
                                        });
                                      },
                                      child: Container(
                                        width: double.infinity,
                                        child: Padding(
                                          padding:
                                          const EdgeInsets.symmetric(horizontal: 20),
                                          child: Row(
                                            children: [
                                              Text( end.value,),
                                              Spacer(),
                                              Icon(Icons.calendar_month)
                                              // SvgPicture.asset("assets/svg/calender.svg")
                                            ],
                                          ),
                                        ),
                                        height: 70,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(20),
                                          border: Border.all(color: Colors.grey, width: 2),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withOpacity(0.01),
                                              spreadRadius: 3,
                                              blurRadius: 3,
                                              offset: Offset(
                                                  0, 0), // changes position of shadow
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Flexible(
                                    child: GestureDetector(
                                      onTap: () async {

                                        var date =  await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(1950),
                                          //DateTime.now() - not to allow to choose before today.
                                          lastDate: DateTime(2100),
                                          builder: (context, child) {
                                            return Theme(
                                              data: Theme.of(context).copyWith(
                                                colorScheme: const ColorScheme.light(
                                                  primary: Colors.redAccent, // header background color
                                                  onPrimary: Colors.black, // header text color
                                                  // onSurface: Colors.green, // body text color
                                                ),
                                                textButtonTheme: TextButtonThemeData(
                                                  style: TextButton.styleFrom(
                                                    primary: Colors.red, // button text color
                                                  ),
                                                ),
                                              ),
                                              child: child!,
                                            );
                                          },
                                        );
                                        print("Dddd");
                                        print(date);
                                        if (date == null) return;
                                         start.value = date.day.toString() +
                                            "/" +
                                            date.month.toString() +
                                            "/" +
                                            date.year.toString();
                                        // startDate.value=date.toString();
                                        startDate.value=date.year.toString() +
                                            "-" +
                                            date.month.toString() +
                                            "-" +
                                            date.day.toString();
                                        setState(() {
                                        });
                                        start.refresh();
                                      },
                                      child: Container(
                                        width: double.infinity,
                                        child: Padding(
                                          padding:
                                          const EdgeInsets.symmetric(horizontal: 20),
                                          child: Row(
                                            children: [
                                               Text(start.value),
                                              Spacer(),
                                              Icon(Icons.calendar_month)
                                              // SvgPicture.asset("assets/svg/calender.svg")
                                            ],
                                          ),
                                        ),
                                        height: 70,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(20),
                                          border: Border.all(color: Colors.grey, width: 2),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withOpacity(0.01),
                                              spreadRadius: 3,
                                              blurRadius: 3,
                                              offset: Offset(
                                                  0, 0), // changes position of shadow
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          ],
                        ),
                        onDone: () {
                          Provider.of<HistoryProvider>(context, listen: false).start = startDate.value;
                          Provider.of<HistoryProvider>(context, listen: false).end = endDate.value;
                          Provider.of<HistoryProvider>(context, listen: false).callGetTicketsListAPI(context);
                        },
                        onCancel: () {},
                        btnDoneText: "Ok",
                      );
                    },
                    child: Padding(
                      padding:  EdgeInsets.only(right: 10.0),
                      child: Icon(Icons.filter_list_rounded),
                    ))
              ],
            ),
            body:

            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.025, vertical: 10),
              child: ListView.builder(
                  itemCount: historyProvider.ticketsListModel == null || historyProvider.ticketsListModel!.data!.isEmpty
                      ? 0
                      : historyProvider.ticketsListModel!.data!.length,
                  itemBuilder: (context, index) {
                    SingleTicketModel singleTicketModel = historyProvider.ticketsListModel!.data![index];
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
                          historyProvider.ticketsListModel == null
                              ? Container()
                              : TicketInfoWidget(
                                  title: "LOTTERY NAME",
                                  info: singleTicketModel.lotteryName,
                                ),
                          // SizedBox(
                          //   height: size.height * 0.007,
                          // ),
                          // historyProvider.ticketsListModel == null
                          //     ? Container()
                          //     : TicketInfoWidget(
                          //         title: "TICKET NAME",
                          //         info: singleTicketModel.ticketName,
                          //       ),
                          SizedBox(
                            height: size.height * 0.007,
                          ),
                          historyProvider.ticketsListModel == null
                              ? Container()
                              : TicketInfoWidget(
                                  title: "TICKET #",
                                  info: singleTicketModel.ticketNo,
                                ),
                          SizedBox(
                            height: size.height * 0.007,
                          ),
                          historyProvider.ticketsListModel == null
                              ? Container()
                              : TicketInfoWidget(
                                  title: "ENTTRIES",
                                  info: singleTicketModel.entries,
                                ),
                          SizedBox(
                            height: size.height * 0.007,
                          ),
                          historyProvider.ticketsListModel == null
                              ? Container()
                              : TicketInfoWidget(
                                  title: "REMANING ENTTRIES",
                                  info: singleTicketModel.remainingEntries,
                                ),
                          SizedBox(
                            height: size.height * 0.007,
                          ),
                          historyProvider.ticketsListModel == null
                              ? Container()
                              : TicketInfoWidget(
                                  title: "AMOUNT",
                                  info: singleTicketModel.amount,
                                ),
                          SizedBox(
                            height: size.height * 0.007,
                          ),
                          historyProvider.ticketsListModel == null
                              ? Container()
                              : TicketInfoWidget(
                                  title: "STATUS",
                                  info: singleTicketModel.status,
                                ),
                          SizedBox(
                            height: size.height * 0.007,
                          ),
                          TextButton(
                            style: TextButton.styleFrom(primary: Colors.grey, elevation: 2, backgroundColor: AppColor.redcolor),
                            child: Text(
                              "View Entries",
                              style: TextStyle(fontSize: 12, color: Colors.white),
                            ),
                            onPressed: () {
                              Provider.of<HistoryProvider>(context, listen: false).ticketId = singleTicketModel.id.toString();
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => EntriesHistoryScreen()));
                            },
                          )
                        ],
                      ),
                    );
                  }),
            ),
          ));
    });
  }
  Future<dynamic> _showDatePicker(ctx) {
    return showCupertinoModalPopup(
        context: ctx,
        builder: (_) => Container(
          height: 350,
          color: Color.fromARGB(255, 255, 255, 255),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: CupertinoButton(
                      child: Container(
                          width: double.infinity,
                          child: Center(
                            child:  Text("Cancel",),
                          )),
                      onPressed: () {
                        Navigator.of(ctx).pop();
                      },
                    ),
                  ),
                  Spacer(),
                  Expanded(
                    child: CupertinoButton(
                      child: Container(
                          width: double.infinity,
                          child: Center(
                            child:  Text(
                                 "OK"),
                          )),
                      onPressed: () {
                        Navigator.of(ctx).pop();
                        Get.back(
                            result: _chosenDateTime);

                      },
                    ),
                  )
                ],
              ),
              Container(
                height: 250,
                child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.date,
                    initialDateTime: _chosenDateTime,
                    onDateTimeChanged: (val) {
                      setState(() {
                        _chosenDateTime = val;
                      });
                    }),
              ),
              SizedBox(height: 30)
              // Close the modal
            ],
          ),
        ));
  }

}
