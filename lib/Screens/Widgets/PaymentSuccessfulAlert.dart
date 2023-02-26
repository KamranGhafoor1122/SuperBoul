import 'package:flutter/material.dart';
import 'package:superlotto/Screens/Widgets/CustomeWidgets.dart';
class PaymentSuccessfulAlert extends StatelessWidget {
  String points;
   PaymentSuccessfulAlert({Key? key,required this.points}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20)
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [

            SizedBox(height: 15,),

            Text(
              "Points Earned",
              style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 15,),

            Text(
              "Congratulations....! your payment was successful and you have earned ${points}",
              style: TextStyle(color: Colors.black26, fontSize: 14, fontWeight: FontWeight.w600),
            ),


            SizedBox(height: 25,),

            CustomButton('Done', onpressed: () {
               Navigator.pop(context);

            }),

            SizedBox(height: 15,),
          ],
        ),
      ),
    );
  }
}
