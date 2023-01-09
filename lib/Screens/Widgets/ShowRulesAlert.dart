

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:superlotto/Constant/Color.dart';
import 'package:superlotto/Screens/Widgets/CustomeWidgets.dart';
import 'package:superlotto/helpers/helperFunctions.dart';
class ShowRulesAlert extends StatelessWidget {

  ShowRulesAlert({Key? key}) : super(key: key);


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
              "About the App",
              style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 15,),





            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.send,size: 25,color: AppColor.redcolor,
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: CustomeText(FontWeight.w500, 14, "The app does not contain any illegal operation , like stealing money, gambling or"
                      "fraud etc.", Colors.black),
                ),
              ],
            ),
            SizedBox(height: 15,),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.send,size: 25,color: AppColor.redcolor,
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(child: CustomeText(FontWeight.w500, 14, "All the features of app are fully secured and privacy of the users data is completely ensured", Colors.black)),
              ],
            ),
            SizedBox(height: 15,),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.send,size: 25,color: AppColor.redcolor,
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(child: CustomeText(FontWeight.w500, 14, "Any unusual activity is not allowed", Colors.black)),
              ],
            ),



            SizedBox(height: 15,),


            CustomButton(
                'Okay, Got It!', onpressed: () async{
                 await HelperFunctions.saveInPreference("about_the_app_read", "yes");
              Navigator.pop(context);
            }),

            SizedBox(height: 15,),
          ],
        ),
      ),
    );
  }
}
