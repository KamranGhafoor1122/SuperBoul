import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:superlotto/models/OrderStatusModel.dart';
import 'package:superlotto/providers/lottteryProvider.dart';
import 'package:superlotto/providers/onbordingProvider.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../Constant/Color.dart';

class PaymentWebView extends StatefulWidget {
  String url;
  String amount;
  PaymentWebView({Key? key,required this.url,required this.amount}) : super(key: key);

  @override
  State<PaymentWebView> createState() => _PaymentWebViewState();
}

class _PaymentWebViewState extends State<PaymentWebView> {
  late WebViewController webViewController;
  bool pageLoaded=false;
  Timer? timer;



  @override
  void initState() {
    webViewController=WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {
            print("started page url: $url}");
          },
          onPageFinished: (String url) {
            print("finished page url: $url");
            setState(() {
              pageLoaded=true;
            });
          },
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            print("page navigate res : ${request.url}");
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async{
      timer = Timer.periodic(Duration(seconds: 5), (Timer t) => checkOrderStatus());
    });
    super.initState();
  }


  checkOrderStatus() async{
   OrderStatusModel? orderStatusModel = await Provider.of<LotteryProvider>(context,listen: false).callCheckOrderStatusAPI(context);
   if(orderStatusModel != null){
      print("order status; ${orderStatusModel.toJson()}");
      if(orderStatusModel.success != null && orderStatusModel.success == true){
        timer!.cancel();
        await Provider.of<LotteryProvider>(context,listen: false).callAddCreditAPI(context, widget.amount);
        await Provider.of<OnboradingProvider>(context,listen: false).fetchUser(context);
        await Provider.of<LotteryProvider>(context,listen: false).callGetWalletPointsAPI(context);
      }
   }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    if(timer != null){
      timer!.cancel();
    }
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return  Scaffold(
            appBar: AppBar(
              centerTitle: true,
              automaticallyImplyLeading: true,
              backgroundColor: AppColor.redcolor,
              title: Text(
                "Payment",
                style: TextStyle(color: Colors.white, fontSize: size.width * 0.037),
              ),
            ),
            body: pageLoaded?WebViewWidget(controller: webViewController):Center(child: SizedBox(
                width: 55,
                height: 55,
                child: const LoadingIndicator(
                  indicatorType: Indicator.circleStrokeSpin,
                  colors: [
                    Colors.red,
                    // Colors.orange,
                  ],
                  // strokeWidth: 4.0,
                )),));
  }
}
