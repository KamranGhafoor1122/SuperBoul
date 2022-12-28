import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import '../../Constant/Color.dart';

class MyCustomGradient extends StatelessWidget {
  final Widget? child;
  const MyCustomGradient({Key? key,this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
        blendMode: BlendMode.srcIn,
        shaderCallback: (Rect bounds) {
          return ui.Gradient.linear(
            Offset(20.0, 40.0),
            Offset(4.0, 1.0),
            [
              Colors.orangeAccent,
              AppColor.redcolor,
            ],
          );
        },
        child: child);
  }
}
