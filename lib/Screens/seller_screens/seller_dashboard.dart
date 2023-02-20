import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:slide_countdown/slide_countdown.dart';
import 'package:superlotto/Constant/ApiConstant.dart';
import 'package:superlotto/Screens/LoginScreen.dart';
import 'package:superlotto/Screens/Widgets/CustomeWidgets.dart';
import 'package:superlotto/Screens/Widgets/customLoader.dart';
import 'package:superlotto/helpers/helperFunctions.dart';
import 'package:superlotto/models/LotteryModel.dart';
import 'package:http/http.dart' as http;
class SellerDashboard extends StatefulWidget {
  String token;
  SellerDashboard({Key? key,required this.token}) : super(key: key);

  @override
  State<SellerDashboard> createState() => _SellerDashboardState();
}

class _SellerDashboardState extends State<SellerDashboard> {
  String? userName;
  bool isLoading = false;
  LottteryModel? lottteryModel;



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
             onRefresh: () async{
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
                                CustomeText(FontWeight.w400, 14, "${userName}", Colors.black),
                                TextButton(onPressed: () async{
                                  await HelperFunctions.clearPreference();
                                  Navigator.of(context)
                                      .pushAndRemoveUntil(MaterialPageRoute(builder: (context) => LoginScreen()), (Route<dynamic> route) => false);

                                }, child: CustomeText(FontWeight.w600,16,"Logout",Colors.black)),
                              ],
                            ),

                            SizedBox(
                             height: 20,
                           ),


                           lottteryModel == null || lottteryModel!.data == null
                               ? Center(
                             child: Text("No lottery found..."),
                           ):Column(
                             children: [
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
                                 height: size.height * 0.1,
                               ),


                               CustomButton("Create Ticket", onpressed: (){
                                    createTicket();
                               }),



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
     WidgetsBinding.instance.addPostFrameCallback((timeStamp) async{
      String? fname =await HelperFunctions.getFromPreference("fname");
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

    final response = await http.get(Uri.parse(ApiConst.BASE_URL + ApiConst.getLottery), headers: header);

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

  Future<void> createTicket() async {
    setState(() {
      isLoading = true;
    });
    Map<String, String> header = <String, String>{};

    header['Authorization'] = "Bearer ${widget.token}";

    final response = await http.get(Uri.parse(ApiConst.BASE_URL + ApiConst.addSellerTicket), headers: header);

    if (response.statusCode == 200) {
      print("lottery resp: ${response.body}");

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
}
