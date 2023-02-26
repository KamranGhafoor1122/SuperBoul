
import 'package:otp_text_field/otp_text_field.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:superlotto/helpers/helperFunctions.dart';

import '../../models/PlayLotteryModel.dart';

class PrintDetails extends StatefulWidget {

  List<PlayLotteryModel> playLotteryResponses = [];

  PrintDetails({Key? key,required this.playLotteryResponses}) : super(key: key);

  @override
  State<PrintDetails> createState() => _PrintDetailsState();
}

class _PrintDetailsState extends State<PrintDetails> {

  String? name;

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async{
      String? fname =await HelperFunctions.getFromPreference("fname");
      String? lname = await HelperFunctions.getFromPreference("lname");
      name = "$fname $lname";
      _printTickets();
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Container();
  }

  void _printTickets() async{
    final doc = pw.Document();
    doc.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
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
                             "${name}",
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
