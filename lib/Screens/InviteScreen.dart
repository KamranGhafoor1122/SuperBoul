import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'package:superlotto/Constant/Color.dart';
import 'package:superlotto/Screens/Widgets/CustomeWidgets.dart';
import 'package:superlotto/Screens/acceptedInvitations.dart';
import 'package:superlotto/helpers/helperFunctions.dart';

class InviteScreen extends StatelessWidget {
  const InviteScreen({Key? key}) : super(key: key);
  Future<void> share(String refralcode) async {
    try {
      await Share.share(
        "Download supper lotto and user reffral code$refralcode to earn rewards https://play.google.com/store/games ",
        subject: "Supperlotto",
        // sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.redcolor,
        title: Text(
          "Invite Friends",
          style: TextStyle(color: Colors.white, fontSize: size.width * 0.037),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // ListTile(
            //   leading: const CircleAvatar(
            //     backgroundImage: const AssetImage(
            //       "assets/Images/invite.png",
            //     ),
            //   ),
            //   title: Text(
            //     "Damodar Lohani",
            //     style: TextStyle(
            //       color: Colors.grey.shade600,
            //       fontWeight: FontWeight.bold,
            //     ),
            //   ),
            //   subtitle: Text(
            //     "Kathmandu",
            //     style: TextStyle(
            //       color: Theme.of(context).primaryColor,
            //       fontWeight: FontWeight.w500,
            //     ),
            //   ),
            // ),
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
                            "assets/Images/invite.png",
                            fit: BoxFit.contain,
                          )),
                      // Positioned(
                      //   right: 0,
                      //   top: 60.0,
                      //   child: MaterialButton(
                      //     elevation: 0,
                      //     textColor: Colors.white,
                      //     minWidth: 0,
                      //     padding: const EdgeInsets.symmetric(
                      //       vertical: 4.0,
                      //       horizontal: 10.0,
                      //     ),
                      //     child: const Icon(Icons.keyboard_arrow_right),
                      //     color: Theme.of(context).primaryColor,
                      //     onPressed: () {},
                      //   ),
                      // ),
                      // Positioned(
                      //   left: 0,
                      //   top: 60.0,
                      //   child: MaterialButton(
                      //     elevation: 0,
                      //     textColor: Colors.white,
                      //     minWidth: 0,
                      //     padding: const EdgeInsets.symmetric(
                      //       vertical: 4.0,
                      //       horizontal: 10.0,
                      //     ),
                      //     child: const Icon(Icons.keyboard_arrow_left),
                      //     color: Theme.of(context).primaryColor,
                      //     onPressed: () {},
                      //   ),
                      // ),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 8.0),
                  //   child: Row(
                  //     children: <Widget>[
                  //       Icon(
                  //         Icons.thumb_up,
                  //         color: Theme.of(context).primaryColor,
                  //       ),
                  //       const SizedBox(width: 5.0),
                  //       const Text("75631"),
                  //       const Spacer(),
                  //       Container(
                  //         height: 20.0,
                  //         width: 1.0,
                  //         color: Colors.grey,
                  //       ),
                  //       const Spacer(),
                  //       const Icon(Icons.comment),
                  //       const SizedBox(width: 5.0),
                  //       const Text("213"),
                  //       const Spacer(),
                  //       Container(
                  //         height: 20.0,
                  //         width: 1.0,
                  //         color: Colors.grey,
                  //       ),
                  //       const Spacer(),
                  //       const Icon(Icons.calendar_today),
                  //       const Spacer(),
                  //       Container(
                  //         height: 20.0,
                  //         width: 1.0,
                  //         color: Colors.grey,
                  //       ),
                  //       const Spacer(),
                  //       const Icon(Icons.location_on),
                  //     ],
                  //   ),
                  // ),

                  const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 8.0),
                      child: Text(
                        "Invite your friends to earn rewards when they sign up with your refrel  code",
                        textAlign: TextAlign.center,
                      )),
                  const SizedBox(height: 20.0),
                  Card(
                    elevation: 5.0,
                    margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(children: [
                        const Text("Copy your refrel code"),
                        const Spacer(),
                        IconButton(
                            onPressed: () {
                              HelperFunctions.getFromPreference("referral").then((value) {
                                Clipboard.setData(ClipboardData(text: value));
                              });
                              HelperFunctions.showSnackBar(context: context, alert: "Copied to clipboard");
                            },
                            icon: const Icon(Icons.copy))
                      ]),
                    ),
                  ),
                  Card(
                    elevation: 5.0,
                    margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(children: [
                        const Text("Share on social platforms"),
                        const Spacer(),
                        IconButton(
                            onPressed: () {
                              HelperFunctions.getFromPreference("referral").then((value) {
                                share(value);
                              });
                            },
                            icon: const Icon(Icons.share))
                      ]),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                ],
              ),
            ),
            const SizedBox(height: 20.0),
            CustomButton("View Friends", onpressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AcceptedInvations()));
            })
          ],
        ),
      ),
      // bottomNavigationBar: Container(
      //   height: 50,
      //   child: Row(
      //     children: <Widget>[
      //       const SizedBox(width: 10.0),
      //       _buildButton(context, "Accept", true),
      //       const Spacer(),
      //       _buildButton(context, "Reject", false),
      //       const Spacer(),
      //       _buildButton(context, "Maybe", false),
      //       const SizedBox(width: 10.0),
      //     ],
      //   ),
      // ),
    );
  }
}
