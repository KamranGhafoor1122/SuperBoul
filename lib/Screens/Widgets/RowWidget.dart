import 'package:flutter/material.dart';

class RowWidget extends StatelessWidget {
  String msg;
  Color clr;
  RowWidget({required this.msg, required this.clr});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      color: clr,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Text(
              msg,
              style: TextStyle(color: Colors.white, fontSize: size.height * 0.015),
            ),
          ),
          Container(
            height: 30.0,
            width: 1.0,
            color: Colors.black12,
            margin: const EdgeInsets.only(left: 12.0),
          )
        ],
      ),
    );
  }
}
