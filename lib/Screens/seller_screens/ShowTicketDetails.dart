import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:superlotto/Constant/Color.dart';
import 'package:superlotto/Screens/Widgets/CustomeWidgets.dart';
import 'package:superlotto/Screens/Widgets/customLoader.dart';
import 'package:superlotto/Screens/Widgets/ticketInfoWidget.dart';
import 'package:superlotto/Screens/seller_screens/print_single_ticket_details.dart';
import 'package:superlotto/models/ViewSellerTickets.dart';
import 'package:superlotto/providers/sellerTicketsProvider.dart';

class ShowTicketDetails extends StatefulWidget {
  Data ticketData;
  ShowTicketDetails({Key? key,required this.ticketData}) : super(key: key);

  @override
  State<ShowTicketDetails> createState() => _ShowTicketDetailsState();
}

class _ShowTicketDetailsState extends State<ShowTicketDetails> {

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<SellerTicketsProvider>(context, listen: false).callGetTicketDetailAPI(context,widget.ticketData.id??0);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: AppColor.redcolor,
          title: Text(
            "Ticket Details",
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
        ),
        body: Consumer<SellerTicketsProvider>(
          builder: (ctx, sellerProvider, child) =>
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: SafeArea(
                  child:

                      sellerProvider.fetching ? Center(
                        child: SizedBox(
                          height: 65,
                          width: 65,
                          child: CircularProgressIndicator(
                            strokeWidth: 1,
                            valueColor: new AlwaysStoppedAnimation<Color>(AppColor.redcolor),
                          ),
                        ),
                      ):
                  sellerProvider.ticketDetailsModel == null ||
                      sellerProvider.ticketDetailsModel!.data == null ?
                  Container() :
                  ListView(
                    children: sellerProvider.ticketDetailsModel!.data!.map((
                        e) =>
                        Column(
                            children: [

                              TicketInfoWidget(info: e.lotteryName ?? "",
                                  title: "Lottery Name" ),


                              SizedBox(height: 15,),
                              TicketInfoWidget(info:e.ticketName ?? "",
                                  title: "Ticket Name" ),

                              SizedBox(height: 15,),
                              TicketInfoWidget(
                                  info: e.userName ?? "", title: "User Name"),

                              SizedBox(height: 15,),
                              TicketInfoWidget(
                                  info: e.userPhone ?? "", title: "User Phone" ),

                              SizedBox(height: 15,),
                              TicketInfoWidget(
                                  info: e.ticketNo ?? "", title: "Ticket Number"),

                              SizedBox(height: 15,),
                              TicketInfoWidget(info: e.entry
                                  ?.toString() ?? "", title: "Entry"),

                              SizedBox(height: 15,),
                              TicketInfoWidget(info: e.number
                                  ?.toString() ?? "", title:"Numbers" ),



                              SizedBox(height: 35,),
                              Row(
                                children: [
                                  Expanded(child: CustomButton("Print",onpressed: (){
                                     Navigator.push(context, MaterialPageRoute(builder: (ctx)=>PrintSingleTicketDetails(ticketData: e)));
                                  },

                                  ))
                                ],
                              )
                            ]
                        )
                    ).toList(),
                  ),
                ),
              ),
        ));
  }
}
