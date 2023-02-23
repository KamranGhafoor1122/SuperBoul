import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:superlotto/Constant/Color.dart';
import 'package:superlotto/Screens/Widgets/CustomeWidgets.dart';
import 'package:superlotto/Screens/Widgets/custom_gradient.dart';
import 'package:superlotto/helpers/helperFunctions.dart';
import 'package:superlotto/models/CreateSellerTicker.dart';
import 'package:superlotto/providers/lottteryProvider.dart';

import '../../models/LotteryModel.dart';
class PlayLottery extends StatefulWidget {
  CreateSellerTicket createSellerTicket;
  LottteryModel lottteryModel;
   PlayLottery({Key? key,required this.createSellerTicket,required this.lottteryModel}) : super(key: key);

  @override
  State<PlayLottery> createState() => _PlayLotteryState();
}

class _PlayLotteryState extends State<PlayLottery> {
  TextEditingController name = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController tickerNumber = TextEditingController();
  TextEditingController amount = TextEditingController();

  RxList numbers = [].obs;
  final winningNumAmt = 7;
  final winningNumLimit = 69;
  var winningNumList = List.generate(69, (i) => i + 1);

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
      appBar: AppBar(
        backgroundColor: AppColor.redcolor,
        title: CustomeText(FontWeight.w500,15.sp,"Play Number",Colors.white),
        centerTitle: false,
      ),
       body: SingleChildScrollView(
         child: SafeArea(
           child: Padding(
             padding: const EdgeInsets.all(12.0),
             child: Column(
               children: [
                 SizedBox(
                   height: 30,
                 ),

                  CustomTextfeild(null, name, "Name", "Name"),
                 SizedBox(height: 20,),

                 CustomTextfeild(null, phoneNumber, "Phone", "Phone No.",textInputType: TextInputType.number,),
                 SizedBox(height: 20,),


                 CustomTextfeild(null, tickerNumber, "Ticker Number", "Ticket No.",readOnly: true,),
                 SizedBox(height: 20,),


                 CustomTextfeild(null, tickerNumber, "Amount", "Amount",readOnly: true,),
                 SizedBox(height: 20,),


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
                   height: size.height*0.01,
                 ),

                 SizedBox(
                     height: size.height * 0.6,
                     child: _numberChoices(winningNumLimit,context)),

                 SizedBox(
                   height: size.height*0.01,
                 ),

                 CustomButton('Confirm', onpressed: () {
                   if(name.text.isEmpty){
                     HelperFunctions.showSnackBar(context: context, alert: "Name cannot be empty");
                     return;
                   }
                   if(phoneNumber.text.isEmpty){
                     HelperFunctions.showSnackBar(context: context, alert: "Phone number cannot be empty");
                     return;
                   }
                   if (numbers.length<6) {
                     HelperFunctions.showSnackBar(context: context, alert: "Please select six numbers");
                     return;
                   }


                     if(DateTime.parse(widget.lottteryModel.data!.expireOn.toString()).difference(DateTime.now()).inSeconds>0){


                       Map<String,dynamic> body = {
                         'user_name':name.text.trimRight(),
                         'user_phone':phoneNumber.text.trimRight(),
                         'ticket_no':tickerNumber.text,
                         'amount': amount.text,
                         'number':numbers.value,
                       };
                       Provider.of<LotteryProvider>(context, listen: false).callSellerdrawEntryAPI(context,body).then((value) {
                         // _amountController.clear();
                         numbers.value=[];
                       });
                     }
                     else{
                       HelperFunctions.showSnackBar(context: context, alert: "This lottery has been expired");
                     }

                 })

               ],
             ),
           ),
         ),
       ),
    );
  }

  void init() async{
    tickerNumber.text = widget.createSellerTicket.data?.ticketNo.toString()??"";
    amount.text = widget.createSellerTicket.data?.amount.toString()??"";
    String? fname =await HelperFunctions.getFromPreference("fname");
    String? lname = await HelperFunctions.getFromPreference("lname");
    name.text = "${fname} ${lname}";

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

  void removeNum(int pickedNumber, BuildContext context) {
    final bool chosen = numbers.contains(pickedNumber);
    // final scaffold = Scaffold.of(context);
    print("*****skkkkk");

    setState(() {
      if (chosen) {
        print("*****0");
        numbers.remove(pickedNumber);
      }
    });
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

            }
          }
        }
      }
      print(numbers);
    });
  }
}
