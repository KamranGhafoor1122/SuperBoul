import 'package:flutter/material.dart';

import '../Constant/Color.dart';

class AcceptedInvations extends StatelessWidget {
  const AcceptedInvations({Key? key}) : super(key: key);

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
        body: ListView.builder(
            itemCount: 2,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  ListTile(
                    leading: const CircleAvatar(
                      backgroundImage: AssetImage(
                        "assets/Images/invite.png",
                      ),
                    ),
                    title: Text(
                      "Zameer Haider",
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: const Text(
                      "Kathmandu",
                      style: TextStyle(
                        color: AppColor.redcolor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const Divider(
                    color: Colors.orange,
                  ),
                ],
              );
            }));
  }
}
