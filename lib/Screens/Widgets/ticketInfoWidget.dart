import 'package:flutter/material.dart';

class TicketInfoWidget extends StatelessWidget {
   TicketInfoWidget({
    Key? key,
    required this.info,
    required this.title,
     this.color,
  }) : super(key: key);

  final String title;
  final String? info;
  Color? color;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(color: Colors.black, fontSize: size.height * 0.015, fontWeight: FontWeight.bold),
        ),
        Text(
          info ?? " ",
          style: TextStyle(color: color??Colors.black, fontSize: size.height * 0.015, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
