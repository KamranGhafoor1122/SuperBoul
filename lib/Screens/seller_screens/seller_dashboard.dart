import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:slide_countdown/slide_countdown.dart';
import 'package:superlotto/Constant/ApiConstant.dart';
import 'package:superlotto/Constant/Color.dart';
import 'package:superlotto/Screens/LoginScreen.dart';
import 'package:superlotto/Screens/PaymentWebView.dart';
import 'package:superlotto/Screens/Widgets/CustomeWidgets.dart';
import 'package:superlotto/Screens/Widgets/customLoader.dart';
import 'package:superlotto/Screens/Widgets/ticketInfoWidget.dart';
import 'package:superlotto/Screens/seller_screens/SellerAllTickets.dart';
import 'package:superlotto/Screens/seller_screens/SellerAllTransactions.dart';
import 'package:superlotto/Screens/seller_screens/SellerPaymentWebView.dart';
import 'package:superlotto/Screens/seller_screens/Winners.dart';
import 'package:superlotto/Screens/seller_screens/play_lottery.dart';
import 'package:superlotto/Screens/seller_screens/show_balance.dart';
import 'package:superlotto/helpers/helperFunctions.dart';
import 'package:superlotto/models/CreateSellerTicker.dart';
import 'package:superlotto/models/LotteryModel.dart';
import 'package:http/http.dart' as http;
import 'package:superlotto/models/PaymentModel.dart';
import 'package:superlotto/providers/lottteryProvider.dart';
import 'package:tap_to_expand/tap_to_expand.dart';


class SellerDashboard extends StatefulWidget {
  String token;

  SellerDashboard({Key? key, required this.token}) : super(key: key);

  @override
  State<SellerDashboard> createState() => _SellerDashboardState();
}

class _SellerDashboardState extends State<SellerDashboard> {
  String? userName;
  bool isLoading = false;
  final ourFormat = new DateFormat('yyyy-MM-dd hh:mm');
  LottteryModel? lottteryModel;
  final TextEditingController _creditamountController = TextEditingController();
  final TextEditingController _numberOfTickets = TextEditingController();
  CreateSellerTicket? createSellerTicket;


  @override
  void initState() {
    // TODO: implement initState
    init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            lottteryModel = await fetchLottery();
            setState(() {
              isLoading = false;
            });
          },
          child: Stack(
            children: [
              ListView(),
              CustomLoader(
                isLoading: isLoading,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomeText(FontWeight.w400, 14, "${userName}",
                                Colors.black),
                            TextButton(
                                onPressed: () async {
                                  await HelperFunctions.clearPreference();
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                          builder: (context) => LoginScreen()),
                                      (Route<dynamic> route) => false);
                                },
                                child: CustomeText(FontWeight.w600, 16,
                                    "Logout", Colors.black)),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        lottteryModel == null || lottteryModel!.data == null
                            ? Center(
                                child: Text("No lottery found..."),
                              )
                            : Column(
                                children: [
                                  SizedBox(
                                    height: size.height * 0.02,
                                  ),
                                  Center(
                                    child: Text(
                                      DateFormat('dd-MM-yyyy').format(
                                          DateTime.parse(lottteryModel!
                                              .data!.expireOn
                                              .toString())),
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: size.height * 0.02,
                                          fontFamily: 'Graphik'),
                                    ),
                                  ),
                                  SizedBox(
                                    height: size.height * 0.02,
                                  ),
                                  if (DateTime.parse(lottteryModel!.data!.liveOn
                                              .toString())
                                          .difference(DateTime.now())
                                          .inSeconds >
                                      1) ...[
                                    Center(
                                      child: SlideCountdownSeparated(
                                        // separatorType: SeparatorType.title,
                                        // durationTitle: DurationTitle.id(),

                                        duration: Duration(
                                            seconds: DateTime.parse(
                                                    lottteryModel!.data!.liveOn
                                                        .toString())
                                                .difference(DateTime.now())
                                                .inSeconds),
                                        // duration: const Duration(days: 2),
                                      ),
                                    ),
                                  ] else ...[
                                    Center(
                                      child: SlideCountdownSeparated(
                                        duration: Duration(
                                            seconds: DateTime.parse(
                                                    lottteryModel!
                                                        .data!.expireOn
                                                        .toString())
                                                .difference(DateTime.now())
                                                .inSeconds),
                                        // duration: const Duration(days: 2),
                                      ),
                                    ),
                                  ],
                                  SizedBox(
                                    height: size.height * 0.1,
                                  ),


                                  Center(
                                    child: TapToExpand(
                                      content: Column(
                                        children: <Widget>[
                                          Container(
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                                border: Border.all(color: Colors.grey), color: Colors.grey, borderRadius: BorderRadius.circular(5)),
                                            padding: EdgeInsets.symmetric(vertical: size.height * 0.01),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                const Icon(
                                                  Icons.star,
                                                  color: AppColor.redcolor,
                                                ),
                                                Text(
                                                  lottteryModel!.data!.name ?? "Lottery name",
                                                  style: TextStyle(color: Colors.black, fontSize: size.height * 0.015),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: size.height * 0.007,
                                          ),
                                          lottteryModel == null
                                              ? Container()
                                              : TicketInfoWidget(
                                            title: "LIVE ON",
                                            info: ourFormat.format(lottteryModel!.data!.liveOn as DateTime),
                                          ),
                                          SizedBox(
                                            height: size.height * 0.007,
                                          ),
                                          lottteryModel == null
                                              ? Container()
                                              : TicketInfoWidget(
                                            title: "EXPIRES ON",
                                            info: ourFormat.format(lottteryModel!.data!.expireOn as DateTime),
                                          ),
                                          // SizedBox(
                                          //   height: size.height * 0.007,
                                          // ),
                                          // lottteryModel == null
                                          //     ? Container()
                                          //     : TicketInfoWidget(
                                          //   title: "1st Prize",
                                          //   info: lottteryModel!.data!.first_prize.toString(),
                                          // ),
                                          SizedBox(
                                            height: size.height * 0.007,
                                          ),
                                          lottteryModel == null
                                              ? Container()
                                              : TicketInfoWidget(
                                            title: "1st Prize",
                                            info: lottteryModel!.data!.first_prize.toString(),
                                          ),

                                          // SizedBox(
                                          //   height: size.height * 0.007,
                                          // ),
                                          // lottteryModel == null
                                          //     ? Container()
                                          //     : TicketInfoWidget(
                                          //   title: "2nd Prize",
                                          //   info: lottteryModel!.data!.second_prize.toString(),
                                          // ),
                                          SizedBox(
                                            height:  size.height * 0.007,
                                          ),
                                          lottteryModel == null
                                              ? Container()
                                              : TicketInfoWidget(
                                            title:  "2nd Prize",
                                            info: lottteryModel!.data!.second_prize.toString(),
                                          ),
                                          SizedBox(
                                            height:  size.height * 0.007,
                                          ),
                                          lottteryModel == null
                                              ? Container()
                                              : TicketInfoWidget(
                                            title:  "3rd Prize",
                                            info: lottteryModel!.data!.third_prize.toString(),
                                          ),
                                          // SizedBox(
                                          //   height: size.height * 0.007,
                                          // ),
                                          // lottteryModel == null
                                          //     ? Container()
                                          //     : TicketInfoWidget(
                                          //   title:  "3rd Prize",
                                          //   info: lottteryModel!.data!.third_prize.toString(),
                                          // ),
                                          // SizedBox(
                                          //   height: size.height * 0.007,
                                          // ),
                                          // lottteryModel == null
                                          //     ? Container()
                                          //     : TicketInfoWidget(
                                          //   title: "WINNING AMOUNT",
                                          //   info: lottteryModel!.data!.winning_amount.toString(),
                                          // ),
                                          SizedBox(
                                            height: size.height * 0.01,
                                          ),
                                          SizedBox(
                                            height: size.height * 0.01,
                                          ),
                                          Padding(
                                              padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 8.0),
                                              child: Text(
                                                lottteryModel!.data!.description ?? "No description",
                                                textAlign: TextAlign.center,
                                              )),
                                        ],
                                      ),
                                      title: Text(
                                        'LOTTERY DETAILS',
                                        style: TextStyle(color: Colors.white, fontSize: size.height * 0.018, fontWeight: FontWeight.bold),
                                      ),
                                      onTapPadding: 0,
                                      closedHeight: 70,
                                      scrollable: true,
                                      borderRadius: 10,
                                      openedHeight: 250,
                                    ),
                                  ),

                                  SizedBox(
                                    height: size.height * 0.04,
                                  ),


                                  CustomButton("Create Ticket And Play",
                                      fontSize: 16.sp, onpressed: () async {


                                        /*HelperFunctions.showAlert(
                                            context: context,
                                            header: "Add Amount",
                                            widget: Container(
                                              height: size.height * 0.1,
                                              child: Column(
                                                children: [
                                                  CustomTextfeild(15, _creditamountController, 'Amount', ''),
                                                ],
                                              ),
                                            ),
                                            onDone: () async {
                                              if (_creditamountController.text.trim().isEmpty) {
                                                // Navigator.pop(context);
                                                HelperFunctions.showSnackBar(context: context, alert: "Please enter amount");
                                              } else {
                                                setState((){
                                                  isLoading = true;
                                                });

                                                PaymentModel? payment= await Provider.of<LotteryProvider>(context, listen: false).callCreatePaymentAPI(context, _creditamountController.text);

                                                String amount = _creditamountController.text;
                                                setState(()  {
                                                  // onboardingProvider.user!.user!.credit = value!.user!.credit;
                                                  isLoading = false;
                                                  _creditamountController.text = "";
                                                });

                                                if(payment != null && lottteryModel != null){
                                                  Navigator.push(context, MaterialPageRoute(builder: (ctx)=>SellerPaymentWebView(url: payment.paymentUrl??"",amount: amount,
                                                  token: widget.token,
                                                    lotteryModel: lottteryModel!,
                                                  )));
                                                }

                                              }
                                            },
                                            onCancel: () {},
                                            btnDoneText: "Add",
                                            btnCancelText: "Cancel");*/




                                        HelperFunctions.showAlert(
                                            context: context,
                                            header: "Create Tickets",
                                            widget: Container(
                                              height: size.height * 0.1,
                                              child: Column(
                                                children: [
                                                  CustomTextfeild(15, _numberOfTickets, 'Number of tickets', ''),
                                                ],
                                              ),
                                            ),
                                            onDone: () async {
                                              if (_numberOfTickets.text.trim().isEmpty) {
                                                // Navigator.pop(context);
                                                HelperFunctions.showSnackBar(context: context, alert: "Please enter number of tickets");
                                              } else {
                                                setState((){
                                                  isLoading = true;
                                                });

                                                await createTicket(_numberOfTickets.text);

                                                setState(() {
                                                  isLoading = false;
                                                });

                                                if (createSellerTicket != null) {
                                                  Navigator.push(context,
                                                      MaterialPageRoute(builder: (ctx) {
                                                        return PlayLottery(
                                                          createSellerTicket:
                                                          createSellerTicket!,
                                                          lottteryModel: lottteryModel!,
                                                        );
                                                      }));
                                                }

                                              }
                                            },
                                            onCancel: () {},
                                            btnDoneText: "Add",
                                            btnCancelText: "Cancel");


                                  }),


                                  SizedBox(
                                    height: 30,
                                  ),

                                  CustomButton("Show Winners", onpressed: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (ctx)=>WinnersPage()));
                                  },fontSize: 20,),


                                  SizedBox(
                                    height: 30,
                                  ),

                                  CustomButton("Show All Tickets", onpressed: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (ctx)=>SellerAllTickets()));
                                  },fontSize: 20,),


                                  SizedBox(
                                    height: 30,
                                  ),

                                  CustomButton("Show All Transactions", onpressed: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (ctx)=>SellerAllTransactions()));
                                  },),

                                  SizedBox(
                                    height: 30,
                                  ),

                                  CustomButton("Show Pending Balance", onpressed: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (ctx)=>ShowBalance()));
                                  },fontSize: 20,),


                                  SizedBox(
                                    height: 30,
                                  ),


                                  CustomButton("Print Tickets", onpressed: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (ctx)=>SellerAllTickets(
                                      showDetails: true,
                                    )));
                                  },fontSize: 20,),


                                ],
                              )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void init() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      String? fname = await HelperFunctions.getFromPreference("fname");
      String? lname = await HelperFunctions.getFromPreference("lname");
      userName = "${fname} ${lname}";
      lottteryModel = await fetchLottery();
      setState(() {
        isLoading = false;
      });
    });
  }

  Future<LottteryModel?> fetchLottery() async {
    setState(() {
      isLoading = true;
    });
    Map<String, String> header = <String, String>{};

    header['Authorization'] = "Bearer ${widget.token}";

    print("seller token: ${widget.token}");


    final response = await http.get(
        Uri.parse(ApiConst.BASE_URL + ApiConst.getLottery),
        headers: header);

    if (response.statusCode == 200) {
      print("lottery resp: ${response.body}");
      return LottteryModel.fromMap(jsonDecode(response.body));
    } else {
      HelperFunctions.showAlert(
        context: context,
        header: "SuperBoul",
        widget: Text(response.body.toString()),
        onDone: () {},
        onCancel: () {},
        btnDoneText: "Ok",
      );
      throw Exception('Failed to load album');
    }
  }



  Future<void> createTicket(String numberOfTickets) async {
    setState(() {
      isLoading = true;
    });
    Map<String, String> header = <String, String>{};

    header['Authorization'] = "Bearer ${widget.token}";

    Map<String,dynamic> body = {
      "number_of_tickets": numberOfTickets,
    };

    final response = await http.post(
        Uri.parse(ApiConst.BASE_URL + ApiConst.addSellerTicket),
        body: body,
        headers: header);

    if (response.statusCode == 200) {
      print("crate ticket resp: ${response.body}");
      createSellerTicket =
          CreateSellerTicket.fromJson(jsonDecode(response.body));
    } else {
      setState(() {
        isLoading = false;
      });

      HelperFunctions.showAlert(
        context: context,
        header: "SuperBoul",
        widget: Text(response.body.toString()),
        onDone: () {},
        onCancel: () {},
        btnDoneText: "Ok",
      );
      //throw Exception('Failed to load album');
    }
  }

}
