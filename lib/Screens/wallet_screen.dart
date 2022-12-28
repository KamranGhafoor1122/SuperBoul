import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:superlotto/Constant/Color.dart';
import 'package:superlotto/Screens/Widgets/CustomeWidgets.dart';
import 'package:superlotto/Screens/Widgets/customLoader.dart';
import 'package:superlotto/models/WalletPointsModel.dart';
import 'package:superlotto/providers/lottteryProvider.dart';
class WalletScreen extends StatefulWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  bool loading=true;

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async{
       await Provider.of<LotteryProvider>(context,listen: false).callGetWalletPointsAPI(context,showAlert: false);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<LotteryProvider>(
      builder:(ctx,lotteryProvider,child)=>
          Scaffold(
          appBar: AppBar(
            title: CustomeText(FontWeight.w600,14.sp,"Wallet",Colors.white),
            centerTitle: true,
            backgroundColor: AppColor.redcolor,
            automaticallyImplyLeading: true,
          ),
        body: CustomLoader(
          isLoading: lotteryProvider.isLoading,
          child: Padding(
            padding: const EdgeInsets.all(1.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20.h,
                ),
                Image.asset(
                  'assets/Images/splashlogo.png',
                  scale: 4,
                ),
                SizedBox(
                  height: 15.h,
                ),

                CustomeText(FontWeight.w600,16.sp,"Your available balance in the wallet is",Colors.black),
                SizedBox(
                  height: 10,
                ),
                lotteryProvider.walletPoints==null?Container():
                CustomeText(FontWeight.w800,32.sp,"${lotteryProvider.walletPoints!.walletPoints??""}",Colors.black),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
