
import 'package:otp_text_field/otp_text_field.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:superlotto/Screens/seller_screens/seller_dashboard.dart';
import 'package:superlotto/helpers/helperFunctions.dart';

import '../../models/TicketDetailsModel.dart';


class PrintSingleTicketDetails extends StatefulWidget {

  Data ticketData;
  PrintSingleTicketDetails({Key? key,required this.ticketData}) : super(key: key);



  @override
  State<PrintSingleTicketDetails> createState() => _PrintSingleTicketDetailsState();
}

class _PrintSingleTicketDetailsState extends State<PrintSingleTicketDetails> {

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
    return Container();
  }

  void _printTickets() async{
    final doc = pw.Document();
    doc.addPage(pw.Page(
        pageFormat: PdfPageFormat.standard,
        build: (pw.Context context) {
          return pw.Column(
                 children: [

                   pw.SizedBox(
                       height: 15
                   ),

                   pw.Row(
                       mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                       children: [
                         pw.Text(
                             "Lottery Name",
                             style: pw.TextStyle(
                                 fontSize: 14
                             )
                         ),

                         pw.Text(
                             "${widget.ticketData.lotteryName}",
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
                             "Ticket Name",
                             style: pw.TextStyle(
                                 fontSize: 14
                             )
                         ),

                         pw.Text(
                             "${widget.ticketData.ticketName}",
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
                             "Username",
                             style: pw.TextStyle(
                                 fontSize: 14
                             )
                         ),

                         pw.Text(
                             "${widget.ticketData.userName}",
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
                             "User Phone",
                             style: pw.TextStyle(
                                 fontSize: 14
                             )
                         ),

                         pw.Text(
                             "${widget.ticketData.userPhone}",
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
                           "${widget.ticketData.ticketNo}",
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
                             "${widget.ticketData.number.toString()}",
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
                             "${widget.ticketData.entry}",
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
              );
        }));

    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => doc.save());// Pag
  }



}
