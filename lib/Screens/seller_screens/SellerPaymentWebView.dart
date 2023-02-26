import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:superlotto/Constant/ApiConstant.dart';
import 'package:superlotto/Constant/Color.dart';
import 'package:superlotto/Screens/Widgets/CustomeWidgets.dart';
import 'package:superlotto/Screens/Widgets/customLoader.dart';
import 'package:superlotto/Screens/seller_screens/play_lottery.dart';
import 'package:superlotto/helpers/helperFunctions.dart';
import 'package:superlotto/models/CreateSellerTicker.dart';
import 'package:superlotto/models/LotteryModel.dart';
import 'package:superlotto/models/OrderStatusModel.dart';
import 'package:superlotto/providers/lottteryProvider.dart';
import 'package:superlotto/providers/onbordingProvider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SellerPaymentWebView extends StatefulWidget {
  String url;
  String amount;
  String token;
  LottteryModel lotteryModel;
  SellerPaymentWebView({Key? key,required this.url,required this.amount,required this.token,required this.lotteryModel}) : super(key: key);

  @override
  State<SellerPaymentWebView> createState() => _SellerPaymentWebViewState();
}

class _SellerPaymentWebViewState extends State<SellerPaymentWebView> {
  late WebViewController webViewController;
  bool pageLoaded=false;
  Timer? timer;
  bool isLoading = false;
  CreateSellerTicket? createSellerTicket;
  OrderStatusModel? orderStatusModel;


  @override
  void initState() {

    /* webViewController=WebViewController()
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
      ..loadRequest(Uri.parse(widget.url));*/

    _launchUrl(widget.url);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async{
      timer = Timer.periodic(Duration(seconds: 5), (Timer t) => checkOrderStatus());
    });
    super.initState();
  }


  checkOrderStatus() async{
   orderStatusModel = await Provider.of<LotteryProvider>(context,listen: false).callCheckOrderStatusAPI(context);
   if(orderStatusModel != null){
      if(orderStatusModel!.success != null && orderStatusModel!.success == true){
        timer!.cancel();
       // await Provider.of<LotteryProvider>(context,listen: false).callAddCreditAPI(context, widget.amount);
        /*await Provider.of<OnboradingProvider>(context,listen: false).fetchUser(context);
        await Provider.of<LotteryProvider>(context,listen: false).callGetWalletPointsAPI(context);*/

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
            body: (orderStatusModel != null && orderStatusModel!.success == true)?
            CustomLoader(
                isLoading: isLoading,
                child: Center(child: CustomeText(FontWeight.w500,14,"Payment Successful",Colors.black))):
            CustomLoader(
              isLoading: isLoading,
              child: Center(child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomeText(FontWeight.w500,14,"Waiting for payment",Colors.black),
                  SizedBox(height: 25,),
                  SizedBox(
                    width: 250,
                    child: CustomButton("Try Again", onpressed: (){
                      _launchUrl(widget.url);
                    }),
                  )
                ],
              )),
            )

            /*pageLoaded?WebViewWidget(controller: webViewController):Center(child: SizedBox(
                width: 55,
                height: 55,
                child: const LoadingIndicator(
                  indicatorType: Indicator.circleStrokeSpin,
                  colors: [
                    Colors.red,
                    // Colors.orange,
                  ],
                  // strokeWidth: 4.0,
                )),)*/


    );
  }



  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw 'Could not launch $url';
    }
  }


  Future<void> createTicket() async {
    setState(() {
      isLoading = true;
    });
    Map<String, String> header = <String, String>{};

    header['Authorization'] = "Bearer ${widget.token}";

    final response = await http.get(
        Uri.parse(ApiConst.BASE_URL + ApiConst.addSellerTicket),
        headers: header);

    if (response.statusCode == 200) {
      print("lottery resp: ${response.body}");
      createSellerTicket =
          CreateSellerTicket.fromJson(jsonDecode(response.body));
    } else {
      HelperFunctions.showAlert(
        context: context,
        header: "SuperBoul",
        widget: Text(response.body.toString()),
        onDone: () {},
        onCancel: () {},
        btnDoneText: "Ok",
      );
      throw Exception('Failed to load album');
    }
  }
}
