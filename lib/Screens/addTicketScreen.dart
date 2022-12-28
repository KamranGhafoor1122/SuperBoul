import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:superlotto/helpers/helperFunctions.dart';
import 'package:superlotto/providers/onbordingProvider.dart';

import '../Constant/Color.dart';
import '../providers/lottteryProvider.dart';
import 'Widgets/CustomeWidgets.dart';
import 'Widgets/customLoader.dart';

class AddTicketScreen extends StatelessWidget {
  final String ticketId;
  AddTicketScreen({Key? key, required this.ticketId}) : super(key: key);

  final _ticketNamecontroller = TextEditingController(text: "ticket");

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.redcolor,
          title: Text(
            "Create Ticket",
            style: TextStyle(color: Colors.white, fontSize: size.width * 0.037),
          ),
        ),
        body: Consumer<LotteryProvider>(builder: (context, lotteryProvider, child) {
          return CustomLoader(
            isLoading: lotteryProvider.isLoading,
            child: Padding(
              padding: EdgeInsets.all(size.width * 0.035),
              child: Column(
                children: [
                  const SizedBox(height: 20.0),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        border: Border.all(color: Colors.grey.shade300),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 10.0,
                            color: Theme.of(context).primaryColor,
                            offset: const Offset(2, 2),
                          ),
                        ]),
                    child: Column(
                      children: <Widget>[
                        Stack(
                          children: <Widget>[
                            Container(
                                height: 200.0,
                                color: Theme.of(context).primaryColor.withOpacity(0.1),
                                padding: const EdgeInsets.all(16.0),
                                width: double.infinity,
                                child: Image.asset(
                                  "assets/Images/lottery.png",
                                  fit: BoxFit.contain,
                                )),
                          ],
                        ),
                        const SizedBox(height: 10.0),
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 8.0),
                            child: Text(
                              "Create a ticket to enter the lottery",
                              textAlign: TextAlign.center,
                            )),
                        const SizedBox(height: 20.0),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  // CustomTextfeild(15, _ticketNamecontroller, 'Ticket name', ''),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  CustomButton('Create', onpressed: () async{
                    // if (_ticketNamecontroller.text.isEmpty) {
                    //   HelperFunctions.showSnackBar(context: context, alert: "Please enter ticket name");
                    // } else
                    {
                      lotteryProvider.lotteryId = ticketId;
                      lotteryProvider.ticketName = _ticketNamecontroller.text.toString();
                      await lotteryProvider.callcreateTicketAPI(context);


                    }
                  }),
                ],
              ),
            ),
          );
        }));
  }
}
