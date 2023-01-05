

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:superlotto/Screens/Widgets/CustomeWidgets.dart';
class WithdrawCashAlert extends StatelessWidget {

  WithdrawCashAlert({Key? key}) : super(key: key);

  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _accountNumber = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;
    return Dialog(
      backgroundColor: Colors.white,
      insetPadding: EdgeInsets.all(13),
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
              "Withdraw Amount",
              style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 15,),

            Text(
              "Please enter details for withdraw...",
              style: TextStyle(color: Colors.black26, fontSize: 14, fontWeight: FontWeight.w600),
            ),



            SizedBox(height: 15,),

            CustomTextfeild(20, _amountController, "Amount", "Enter Amount"),



            SizedBox(height: 15,),

            CustomTextfeild(30, _accountNumber, "Account Number", "Enter Account Number"),



            SizedBox(height: 15,),

            CustomTextfeild(100, _descriptionController, "Description", "Enter Description"),

            SizedBox(height: 25,),

            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.grey, Colors.grey],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(15))
                        // image: DecorationImage(
                        //   // scale: 1,
                        //   fit: BoxFit.cover,
                        //   image: AssetImage(
                        //     'assets/Images/Rectangle 7.png',
                        //   ),
                        // ),
                      ),
                      child: Center(child: CustomeText(FontWeight.w500, 20.sp, "Cancel", Colors.black)),
                    ),
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: CustomButton(
                      'Pay', onpressed: () {
                    Navigator.pop(context);
                  }),
                ),
              ],
            ),

            SizedBox(height: 15,),
          ],
        ),
      ),
    );
  }
}
