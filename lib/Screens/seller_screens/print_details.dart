
import 'package:otp_text_field/otp_text_field.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:superlotto/Screens/seller_screens/seller_dashboard.dart';
import 'package:superlotto/helpers/helperFunctions.dart';

import '../../models/PlayLotteryModel.dart';

class PrintDetails extends StatefulWidget {

  String userName;

  List<PlayLotteryModel> playLotteryResponses = [];

  PrintDetails({Key? key,required this.playLotteryResponses,required this.userName}) : super(key: key);

  @override
  State<PrintDetails> createState() => _PrintDetailsState();
}

class _PrintDetailsState extends State<PrintDetails> {

  //String? name;
  String? token;

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async{
      String? fname =await HelperFunctions.getFromPreference("fname");
      String? lname = await HelperFunctions.getFromPreference("lname");
      token = await HelperFunctions.getFromPreference("token");
      _printTickets();
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async{
           Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx)=>SellerDashboard(token: token??"")));
          return Future.value(false);
        },
        child: Container());
  }

  void _printTickets() async{
    final doc = pw.Document();
    doc.addPage(pw.Page(
        pageFormat: PdfPageFormat.standard,
        build: (pw.Context context) {
          return pw.ListView(
              children: widget.playLotteryResponses.map((e) => pw.Column(
                 children: [

                   pw.Row(
                       mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                       children: [
                         pw.Text(
                             "Username",
                             style: pw.TextStyle(
                                 fontSize: 14
                             )
                         ),

                         pw.Text(
                             "${widget.userName}",
                             style: pw.TextStyle(
                                 fontSize: 13
                             )
                         ),
                       ]
                   ),


                   pw.SizedBox(
                       height: 15
                   ),

                   pw.Row(
                     mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                     children: [
                       pw.Text(
                         "Ticket No.",
                         style: pw.TextStyle(
                           fontSize: 14
                         )
                       ),

                       pw.Text(
                           "${e.data?.ticketId}",
                           style: pw.TextStyle(
                               fontSize: 13
                           )
                       ),
                     ]
                   ),
                   pw.SizedBox(
                     height: 15
                   ),

                   pw.Row(

                       mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                       children: [
                         pw.Text(
                             "Numbers Played",
                             style: pw.TextStyle(
                                 fontSize: 14
                             )
                         ),

                         pw.Text(
                             "${e.data?.number}",
                             style: pw.TextStyle(
                                 fontSize: 13
                             )
                         ),
                       ]
                   ),

                   pw.SizedBox(
                       height: 15
                   ),

                   pw.Row(
                       mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                       children: [
                         pw.Text(
                             "Entry",
                             style: pw.TextStyle(
                                 fontSize: 14
                             )
                         ),

                         pw.Text(
                             "${e.data?.entry}",
                             style: pw.TextStyle(
                                 fontSize: 13
                             )
                         ),
                       ]
                   ),

                   pw.SizedBox(
                       height: 35
                   ),
                 ]
              )).toList()
          ); // Center
        }));

    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => doc.save());// Pag
  }



}
