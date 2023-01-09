import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:slide_countdown/slide_countdown.dart';
import 'package:superlotto/Constant/ApiConstant.dart';
import 'package:superlotto/Screens/InviteScreen.dart';
import 'package:superlotto/Screens/LoginScreen.dart';
import 'package:superlotto/Screens/PaymentWebView.dart';
import 'package:superlotto/Screens/Widgets/ShowRulesAlert.dart';
import 'package:superlotto/Screens/Widgets/WithdrawCashAlert.dart';
import 'package:superlotto/Screens/Widgets/custom_gradient.dart';
import 'package:superlotto/Screens/Widgets/custom_toast.dart';
import 'package:superlotto/Screens/addTicketScreen.dart';
import 'package:superlotto/Screens/ticketsHistory.dart';
import 'package:superlotto/Screens/transactionHistory.dart';
import 'package:superlotto/Screens/wallet_screen.dart';
import 'package:superlotto/helpers/helperFunctions.dart';
import 'package:superlotto/models/AppUser.dart';
import 'package:superlotto/models/PaymentModel.dart';
import 'package:superlotto/providers/lottteryProvider.dart';
import 'package:superlotto/providers/onbordingProvider.dart';
import 'package:tap_to_expand/tap_to_expand.dart';
import '../Constant/Color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:superlotto/Constant/Color.dart';
import 'package:superlotto/Screens/Widgets/CustomeWidgets.dart';

import '../helpers/apiManager.dart';
import '../models/LotteryModel.dart';
import '../models/TicketModel.dart';
import '../providers/historyProvider.dart';
import 'Entries.dart';
import 'EntriesHistory.dart';
import 'Widgets/customLoader.dart';
import 'Widgets/ticketInfoWidget.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  String token;
  HomeScreen({Key? key, required this.token}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? fname;
  String? lname;
  bool isLoading = false;
  LottteryModel? lottteryModel;
  TicketModel? ticketModel;
  final winningNumAmt = 7;
  final winningNumLimit = 69;
  var winningNumList = List.generate(69, (i) => i + 1);// generateWinningNumList();
  // HomeController controller = Get.put(HomeController());
  List generateWinningNumList () {
    var winningList = List.generate(winningNumLimit, (i) => i + 1);
    winningList.shuffle();
    print(winningList.sublist(0, winningNumAmt));
    return winningList.sublist(0, winningNumAmt);
  }
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async{
       String read = await HelperFunctions.getFromPreference("about_the_app_read");
       if(read != "yes"){
         showDialog(context: context,
             barrierDismissible: false
             ,builder: (ctx)=>ShowRulesAlert());
       }
    });
    getAlbum();
    HelperFunctions.getFromPreference("fname").then((value) {
      fname = value;
    });
    HelperFunctions.getFromPreference("lname").then((value) {
      lname = value;
    });
  }

  getAlbum() async {
    fetchLottery().then((value) {
      setState(() {
        lottteryModel = value;
        isLoading = false;
      });
    });
    fetchTicket().then((value) {
      setState(() {
        ticketModel = value;
        isLoading = false;
      });
    });
    Provider.of<OnboradingProvider>(context,listen: false).fetchUser(context).then((value) {
      setState(() {
        isLoading = false;
      });
      /*setState(() {
        appUser = value;
        isLoading = false;
      });*/
    });
  }

  Future<LottteryModel?> fetchLottery() async {
    setState(() {
      isLoading = true;
    });
    Map<String, String> header = <String, String>{};

    header['Authorization'] = "Bearer ${widget.token}";

    final response = await http.get(Uri.parse(ApiConst.BASE_URL + ApiConst.getLottery), headers: header);
    print("getLottery");

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      // setState(() {
      //   isLoading = false;
      // });
      print("lottery resp: ${response.body}");
      return LottteryModel.fromMap(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
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

  Future<TicketModel?> fetchTicket() async {
    setState(() {
      isLoading = true;
    });
    Map<String, String> header = <String, String>{};

    header['Authorization'] = "Bearer ${widget.token}";

    final response = await http.get(Uri.parse(ApiConst.BASE_URL + ApiConst.getTicket), headers: header);

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      print("ticket res: ${response.body}");

      return TicketModel.fromMap(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.

      print("ticket res: ${response.body}");
      HelperFunctions.showAlert(
        context: context,
        header: "SuperBoul",
        widget: Text("Error geting data"),
        onDone: () {},
        onCancel: () {},
        btnDoneText: "Ok",
      );
      //throw Exception('Failed to load album');
    }
  }



  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _creditamountController = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final ourFormat = new DateFormat('yyyy-MM-dd hh:mm');
  // final Set<int> _chosenNumbers = Set<int>();
  RxList numbers = [].obs;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    // print(DateTime.parse(lottteryModel!.data!.liveOn.toString()).difference(DateTime.now()).inDays);
    // print(lottteryModel!.data!.liveOn.toString());
    return CustomLoader(
        isLoading: isLoading,
        child: Consumer<OnboradingProvider>(
          builder:(ctx,onboardingProvider,child)=> Scaffold(
            key: _scaffoldKey,
            drawer: Drawer(
              child: SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        color: AppColor.redcolor,
                        width: double.infinity,
                        child: Column(
                          children: [
                            SizedBox(
                              height: size.height * 0.05,
                            ),
                            Container(
                                decoration:
                                    BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(50.0)), border: Border.all(color: Colors.white)),
                                child: const CircleAvatar(
                                  backgroundImage: NetworkImage('https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg'),
                                  radius: 40,
                                )),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: size.height * 0.02),
                              child: Text(
                                fname == null ? "John  Doe" : "$fname $lname",
                                style: TextStyle(color: Colors.white, fontSize: size.height * 0.03, fontFamily: 'Graphik'),
                              ),
                            )
                          ],
                        ),
                      ),
                      ListTile(
                        horizontalTitleGap: 0,
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => TransactionHistory()));
                        },
                        leading: const Icon(
                          Icons.money,
                          color: Color(0xffEC2547),
                        ),
                        title: const Text(
                          'Transaction Histtory',
                          style: TextStyle(color: Color(0xffEC2547), fontWeight: FontWeight.bold),
                        ),
                      ),
                      ListTile(
                        horizontalTitleGap: 0,
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => WalletScreen()));
                        },
                        leading: const Icon(
                          Icons.account_balance,
                          color: Color(0xffEC2547),
                        ),
                        title: const Text(
                          'My Wallet',
                          style: TextStyle(color: Color(0xffEC2547), fontWeight: FontWeight.bold),
                        ),
                      ),


                     /* ListTile(
                        horizontalTitleGap: 0,
                        onTap: () {
                          Navigator.pop(context);

                         showDialog(context: context, builder: (ctx)=>WithdrawCashAlert());
                        },
                        leading: const Icon(
                          Icons.account_balance_wallet,
                          color: Color(0xffEC2547),
                        ),
                        title: const Text(
                          'Withdraw',
                          style: TextStyle(color: Color(0xffEC2547), fontWeight: FontWeight.bold),
                        ),
                      ),*/
                      ListTile(
                        horizontalTitleGap: 0,
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => TicketsHistoryScreen()));
                        },
                        leading: const Icon(
                          Icons.airplane_ticket,
                          color: Color(0xffEC2547),
                        ),
                        title: const Text(
                          'Tickets History',
                          style: TextStyle(color: Color(0xffEC2547), fontWeight: FontWeight.bold),
                        ),
                      ),
                      ListTile(
                        horizontalTitleGap: 0,
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => PastEntries()));
                        },
                        leading: const Icon(
                          Icons.confirmation_number_outlined,
                          color: Color(0xffEC2547),
                        ),
                        title: const Text(
                          'Winners',
                          style: TextStyle(color: Color(0xffEC2547), fontWeight: FontWeight.bold),
                        ),
                      ),
                      ListTile(
                        horizontalTitleGap: 0,
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => const InviteScreen()));
                        },
                        leading: const Icon(
                          Icons.share,
                          color: Color(0xffEC2547),
                        ),
                        title: const Text(
                          'Invite',
                          style: TextStyle(color: Color(0xffEC2547), fontWeight: FontWeight.bold),
                        ),
                      ),
                      ListTile(
                        horizontalTitleGap: 0,
                        onTap: () async{
                           await HelperFunctions.clearPreference();
                          Navigator.of(context)
                              .pushAndRemoveUntil(MaterialPageRoute(builder: (context) => LoginScreen()), (Route<dynamic> route) => false);
                        },
                        leading: const Icon(
                          Icons.logout,
                          color: Color(0xffEC2547),
                        ),
                        title: const Text(
                          'Logout',
                          style: TextStyle(color: Color(0xffEC2547), fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: AppColor.backgroundcolor,
              elevation: 0,
              actions: [
                IconButton(
                    onPressed: () {
                      _scaffoldKey.currentState!.openDrawer();
                    },
                    icon: Icon(Icons.menu))
              ],
              // title: Text(
              //   "Home",
              //   style: TextStyle(color: Colors.white, fontSize: size.width * 0.037),
              // ),
              title: Container(
                width: size.width * 0.3,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Color(0xffFD8F08),
                ),
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.017, vertical: size.height * 0.002),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      // color: Colors.red,
                      width: size.width * 0.15,
                      alignment: Alignment.center,
                      child:onboardingProvider.user == null
                          ? Text(
                        "Home",
                        style: TextStyle(color: Colors.white, fontSize: size.height * 0.015, fontWeight: FontWeight.bold),
                      )
                          : Text(
                        "\G " + onboardingProvider.user!.user!.credit.toString(),
                        style: TextStyle(color: Colors.white, fontSize: size.height * 0.015, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Container(
                      height: 30.0,
                      width: 1.0,
                      // color: Colors.black12,
                      margin: const EdgeInsets.only(left: 12.0),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    GestureDetector(
                      onTap: () {
                        HelperFunctions.showAlert(
                            context: context,
                            header: "Add Credit",
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
                                isLoading = true;
                                  log("then called");

                                    PaymentModel? payment= await Provider.of<LotteryProvider>(context, listen: false).callCreatePaymentAPI(context, _creditamountController.text);

                                    String amount = _creditamountController.text;
                                    setState(()  {
                                     // onboardingProvider.user!.user!.credit = value!.user!.credit;
                                      isLoading = false;
                                      _creditamountController.text = "";
                                    });

                                    if(payment != null){
                                      print("Payment res: ${payment.toJson()}");
                                      Navigator.push(context, MaterialPageRoute(builder: (ctx)=>PaymentWebView(url: payment.paymentUrl??"",amount: amount, )));
                                    }

                              }
                            },
                            onCancel: () {},
                            btnDoneText: "Add",
                            btnCancelText: "Cancel");
                      },
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                        size: size.height * 0.02,
                      ),
                    )
                  ],
                ),
              ),
              leading: Padding(
                padding: EdgeInsets.only(left: size.width * 0.03),
                child: Image.asset("assets/Images/splashlogo.png"),
              ),
              iconTheme: IconThemeData(color: Colors.black),
            ),

            body: lottteryModel == null || lottteryModel!.data == null
                ? Center(
                    child: Text("No lottery found..."),
                  )
                : RefreshIndicator(
              color: AppColor.redcolor,
              onRefresh: () async{


                setState(() {
                  lottteryModel = null;
                  ticketModel = null;
                });
                getAlbum();
                HelperFunctions.getFromPreference("fname").then((value) {
                  fname = value;
                });
                HelperFunctions.getFromPreference("lname").then((value) {
                  lname = value;
                });
                setState(() {
                });

                },
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            Row(
                              children: [
                                Text(
                                  "Welcome back ",
                                  style: TextStyle(color: Colors.black, fontSize: size.height * 0.03, fontFamily: 'Graphik'),
                                ),
                                MyCustomGradient(
                                  child: Text(
                                    fname == null ? "John  Doe" : "$fname $lname",
                                    style: TextStyle(color: Colors.white, fontSize: size.height * 0.03, fontFamily: 'Graphik'),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            Center(
                              child: Text(
                                DateFormat('dd-MM-yyyy').format(DateTime.parse(lottteryModel!.data!.expireOn.toString())),
                                style: TextStyle(color: Colors.black, fontSize: size.height * 0.02, fontFamily: 'Graphik'),
                              ),
                            ),

                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            if(DateTime.parse(lottteryModel!.data!.liveOn.toString()).difference(DateTime.now()).inSeconds>1)...[
                              Center(
                                child: SlideCountdownSeparated(
                                  // separatorType: SeparatorType.title,
                                  // durationTitle: DurationTitle.id(),

                                  duration: Duration(seconds: DateTime.parse(lottteryModel!.data!.liveOn.toString()).difference(DateTime.now()).inSeconds),
                                  // duration: const Duration(days: 2),
                                ),
                              ),
                            ]
                            else...[
                                Center(
                                  child: SlideCountdownSeparated(
                                    duration: Duration(seconds: DateTime.parse(lottteryModel!.data!.expireOn.toString()).difference(DateTime.now()).inSeconds),
                                    // duration: const Duration(days: 2),
                                  ),
                                ),
                            ],


                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            Center(
                              child: TapToExpand(
                                color: Colors.white60,
                                content: ticketModel == null
                                    ? Center(
                                        child: Text("No ticket  details found"),
                                      )
                                    : Column(
                                        children: <Widget>[
                                          SizedBox(
                                            height: size.height * 0.01,
                                          ),
                                          ticketModel == null
                                              ? Container()
                                              : TicketInfoWidget(
                                                  title: "TICKET NAME",
                                                  info: ticketModel!.data!.name,
                                                ),
                                          SizedBox(
                                            height: size.height * 0.007,
                                          ),
                                          ticketModel == null
                                              ? Container()
                                              : TicketInfoWidget(
                                                  title: "TICKET NO",
                                                  info: ticketModel!.data!.ticketNo,
                                                ),
                                          SizedBox(
                                            height: size.height * 0.007,
                                          ),
                                          ticketModel == null
                                              ? Container()
                                              : TicketInfoWidget(
                                                  title: "TOTAL ENTRIES",
                                                  info: ticketModel!.data!.entries,
                                                ),
                                          SizedBox(
                                            height: size.height * 0.007,
                                          ),
                                          ticketModel == null
                                              ? Container()
                                              : TicketInfoWidget(
                                                  title: "REMAINING ENTRIES",
                                                  info: ticketModel!.data!.remainingEntries,
                                                ),
                                          SizedBox(
                                            height: size.height * 0.007,
                                          ),
                                          ticketModel == null
                                              ? Container()
                                              : TicketInfoWidget(
                                                  title: "AMOUNT",
                                                  info: ticketModel!.data!.amount,
                                                ),
                                          TextButton(
                                            style: TextButton.styleFrom(primary: Colors.grey, elevation: 2, backgroundColor: AppColor.redcolor),
                                            child: Text(
                                              "View Entries",
                                              style: TextStyle(fontSize: 12, color: Colors.white),
                                            ),
                                            onPressed: () {
                                              Provider.of<HistoryProvider>(context, listen: false).ticketId = ticketModel!.data!.id.toString();
                                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => EntriesHistoryScreen()));
                                            },
                                          )
                                        ],
                                      ),
                                title: Text(
                                  'TICKET DETAILS',
                                  style: TextStyle(color: Colors.black, fontSize: size.height * 0.018, fontWeight: FontWeight.bold),
                                ),
                                onTapPadding: 0,
                                closedHeight: 70,
                                scrollable: true,
                                borderRadius: 10,
                                openedHeight: ticketModel == null ? 120 : 240,
                              ),
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

                            // const SizedBox(height: 20.0),

                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.center,
                            //   children: [
                            //     RowWidget(
                            //       msg: "STR",
                            //       clr: Color(0xffFD8F08),
                            //     ),
                            //     RowWidget(msg: "PALE", clr: Color(0xffFD8F08)),
                            //     RowWidget(
                            //       msg: "TRIPLE",
                            //       clr: AppColor.redcolor,
                            //     ),
                            //     RowWidget(
                            //       msg: "CASH3",
                            //       clr: Color(0xffFD8F08),
                            //     ),
                            //     RowWidget(
                            //       msg: "PLAY4",
                            //       clr: Color(0xffFD8F08),
                            //     ),
                            //     RowWidget(
                            //       msg: "PICKS",
                            //       clr: Color(0xffFD8F08),
                            //     ),
                            //   ],
                            // ),
                            // SizedBox(
                            //   height: size.height * 0.02,
                            // ),
                            // Center(
                            //   child: Text(
                            //     "TAP TO SELECT",
                            //     textAlign: TextAlign.start,
                            //     style: TextStyle(color: Colors.black, fontSize: size.height * 0.018, fontWeight: FontWeight.bold),
                            //   ),
                            // ),
                            SizedBox(
                              height: size.height * 0.04,
                            ),
                            // SizedBox(
                            //   height: size.height * 0.1,
                            //   child: Row(
                            //     mainAxisAlignment: MainAxisAlignment.center,
                            //     children: [
                            //       Expanded(
                            //         child: ListView.builder(
                            //           shrinkWrap: true,
                            //           padding: EdgeInsets.only(left: 50),
                            //           scrollDirection: Axis.horizontal,
                            //           itemCount: lottteryModel != null || lottteryModel!.data != null ? lottteryModel!.data!.numbers!.length : 0,
                            //           itemBuilder: (context, index) => GestureDetector(
                            //               onTap: () {
                            //                 _amountController.clear();
                            //                 _amountController.text = lottteryModel!.data!.numbers![index].toString();
                            //               },
                            //               child: Padding(
                            //                 padding: const EdgeInsets.all(8.0),
                            //                 child: CircleAvatar(
                            //                   backgroundColor: AppColor.redcolor,
                            //                   radius: size.width * 0.1,
                            //                   child: Text(
                            //                     lottteryModel!.data!.numbers![index].toString(),
                            //                     style: TextStyle(color: Colors.white, fontSize: size.height * 0.03),
                            //                   ),
                            //                 ),
                            //               )
                            //
                            //               //  Container(
                            //               //     margin: EdgeInsets.all(size.width * .02),
                            //               //     decoration: BoxDecoration(
                            //               //       borderRadius: BorderRadius.circular(35),
                            //               //       color: AppColor.redcolor,
                            //               //     ),
                            //               //     padding: EdgeInsets.all(20),
                            //               //     child: Text(
                            //               //        lottteryModel!.data!.numbers![index].toString(),
                            //               //       style: TextStyle(color: Colors.white, fontSize: size.height * 0.03),
                            //               //     )),
                            //               ),
                            //         ),
                            //       )
                            //     ],
                            //   ),
                            // ),
                            Container(
                              height: size.height * 0.05,
                              width: size.width * 0.9,
                              alignment: Alignment.center,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount:numbers.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return Card(
                                      elevation: 1,
                                      color:  Colors.orangeAccent,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8)
                                      ),
                                      child: InkWell(
                                        onTap: () => removeNum(numbers[index], context),
                                        child: Container(
                                          width:  size.height * 0.05,
                                          // height: 20,
                                          child: Center(
                                            child:Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text(
                                                '${numbers[index]}',
                                                style: GoogleFonts.poppins(color: Colors.white,fontWeight: FontWeight.w600,),
                                              )
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  })
                            ),
                            SizedBox(
                              height: size.height * 0.04,
                            ),

                            if(DateTime.parse(lottteryModel!.data!.liveOn.toString()).difference(DateTime.now()).inSeconds>1)...[
                              Container(),
                            ]
                            else...[
                              SizedBox(
                                  height: size.height * 0.6,
                                  child: _numberChoices(winningNumLimit,context)),
                              SizedBox(
                                height: size.height * 0.02,
                              ),
                              // GestureDetector(onTap: () {}, child: AbsorbPointer(child: CustomTextfeild(15, _amountController, 'Number', ''))),
                              SizedBox(
                                height: size.height * 0.02,
                              ),
                              Provider.of<LotteryProvider>(context).isLoading
                                  ? Center(
                                child: CircularProgressIndicator(
                                  color: AppColor.redcolor,
                                ),
                              )
                                  : CustomButton('Confirm', onpressed: () {
                                if (numbers.length<6) {
                                  HelperFunctions.showSnackBar(context: context, alert: "Please select six numbers");
                                } else {


                                  if(DateTime.parse(lottteryModel!.data!.expireOn.toString()).difference(DateTime.now()).inSeconds>0){
                                    Provider.of<LotteryProvider>(context, listen: false).lotteryId = lottteryModel!.data!.id.toString();
                                    Provider.of<LotteryProvider>(context, listen: false).lotteryNumbers = numbers.value;
                                    Provider.of<LotteryProvider>(context, listen: false).calldrawEntryAPI(context).then((value) {
                                      // _amountController.clear();
                                      numbers.value=[];
                                      getAlbum();
                                    });
                                  }
                                  else{
                                    HelperFunctions.showSnackBar(context: context, alert: "This lottery has been expired");
                                  }

                                }
                              }),
                              SizedBox(
                                height: size.height * 0.03,
                              ),
                            ],


                          ],
                        ),
                      ),
                    ),
                ),

            floatingActionButton: FloatingActionButton(
              onPressed: () {
                lottteryModel!.data!.canCreateTicket.toString();
                // if (lottteryModel!.data!.canCreateTicket as bool) {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => AddTicketScreen(
                          ticketId: lottteryModel!.data!.id.toString(),
                        )));
                // } else {
                //   HelperFunctions.showSnackBar(context: context, alert: "You don't have permission to create a ticket.Please contact support");
                // }
              },
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
              // ...FloatingActionButton properties...
            ),

            // Here's the new attribute:

            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          ),
        ));
  }

  void pickedNum(int pickedNumber, BuildContext context) {
    final bool chosen = numbers.contains(pickedNumber);
    // final scaffold = Scaffold.of(context);
    print("*****skkkkk");

    setState(() {
      if (chosen) {
        print("*****0");
        numbers.remove(pickedNumber);
      } else {
        if (numbers.length < 5) {
          print("*****1");
          numbers.add(pickedNumber);
        } else {
          print("*****2");
          if (numbers.length == 5) {
            if(pickedNumber<27) {
              numbers.add(pickedNumber);
            }
            else{
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Last number should be between 1 - 26"),
                duration: Duration(seconds: 1),
              ));
              // CustomToast().showToast("Error", "Number should be between 1 - 29", true);
            }
          }
          // if (_chosenNumbers.containsAll(winningNumList)) {
          //   print("*****4");
          //   // scaffold.showSnackBar(
          //   //   SnackBar(
          //   //     content: const Text(
          //   //         'Congratulations! You have won the lottery jackpot'),
          //   //     action: SnackBarAction(
          //   //         label: 'RESET', onPressed: () => _reset(scaffold)),
          //   //   ),
          //   // );
          //   Fluttertoast.showToast(
          //     msg: "Congratulations! You have won the lottery jackpot",
          //     toastLength: Toast.LENGTH_SHORT,
          //     webBgColor: "#e74c3c",
          //     textColor: Colors.deepOrange,
          //     timeInSecForIosWeb: 5,
          //   );
          // } else {
          //   // scaffold.showSnackBar(
          //   //   SnackBar(
          //   //     content: const Text(
          //   //         'Aw no jackpot win this time! Better luck next time!'),
          //   //     action: SnackBarAction(
          //   //         label: 'RESET', onPressed: () => _reset(scaffold)),
          //   //   ),
          //   // );
          //   Fluttertoast.showToast(
          //     msg: "Aw no jackpot win this time! Better luck next time!",
          //     toastLength: Toast.LENGTH_SHORT,
          //     webBgColor: "#e74c3c",
          //     textColor: Colors.red,
          //     timeInSecForIosWeb: 5,
          //   );
          // }
        }
      }
      print(numbers);
    });
  }
  void removeNum(int pickedNumber, BuildContext context) {
    final bool chosen = numbers.contains(pickedNumber);
    // final scaffold = Scaffold.of(context);
    print("*****skkkkk");

    setState(() {
      if (chosen) {
        print("*****0");
        numbers.remove(pickedNumber);
      }
      print(numbers);
    });
  }

  void _reset(var scaffold) {
    scaffold.showSnackBar(
      SnackBar(
        content: const Text('Press Refresh button for new winning numbers'),
        action: SnackBarAction(
            label: 'HIDE', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
    scaffold.showSnackBar(
      SnackBar(
        content: Text('Jackpot #s: $winningNumList'),
        action: SnackBarAction(
            label: 'HIDE', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
    setState(() {
      numbers.clear();
    });
  }

  Widget _numberChoices(int winningNumLimit,context) {
    return GridView.count(
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 8,
      children: List.generate(winningNumLimit, (index) {
        ++index;
        return displayNumber(index,context);
      }),
    );
  }

  Widget displayNumber(int index,context) {
    return Card(
      elevation: 1,
      color: numbers.contains(index) ? Colors.orangeAccent : Color(0XFFEAEBF4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18)
      ),
      child: InkWell(
        onTap: () => pickedNum(index, context),
        child: Container(
          child: Center(
            child:numbers.contains(index) ?Text(
              '$index',
              style: GoogleFonts.poppins(color:numbers.contains(index) ? Colors.white : Colors.black,fontWeight: FontWeight.w600,),
            ): MyCustomGradient(
              child: Text(
                '$index',
                style: GoogleFonts.poppins(color:numbers.contains(index) ? Colors.white : Colors.black,fontWeight: FontWeight.w600,),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // void _winningSection() {
  //   winningNumList = List.generate(50, (i) => i + 1);
  //   setState(() {
  //     appBarTitleText = Card(
  //       color: Colors.lightBlueAccent,
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //         children: winningNumList
  //             .map(
  //               (winningNum) => Text(
  //             "#",
  //             style: TextStyle(
  //                 color: Colors.white,
  //                 fontSize: 30,
  //                 fontWeight: FontWeight.bold),
  //           ),
  //         )
  //             .toList(),
  //       ),
  //     );
  //   });
  // }
}
