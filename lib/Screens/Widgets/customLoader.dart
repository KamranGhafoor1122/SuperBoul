import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class CustomLoader extends StatelessWidget {
  Color bgcolor;
  Color loaderColor;
  final bool isLoading;
  final Widget? child;
  static const Color colorPrimary = Color(0xFF17C5CC);
  CustomLoader({this.child, this.isLoading = false, this.bgcolor = Colors.black26, this.loaderColor = colorPrimary});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return isLoading
        ? Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                child: Container(
                  width: width,
                  height: height,
                  child: child,
                ),
              ),
              Positioned(
                child: Align(
                  alignment: FractionalOffset.center,
                  child: Container(
                    width: width,
                    height: height,
                    color: bgcolor,
                    child: Center(
                      child: SizedBox(
                          width: width * 0.12,
                          height: width * 0.12,
                          child: const LoadingIndicator(
                            indicatorType: Indicator.circleStrokeSpin,
                            colors: [
                              Colors.red,
                              // Colors.orange,
                            ],
                            // strokeWidth: 4.0,
                          )),
                    ),
                  ),
                ),
              ),
            ],
          )
        : Container(
            child: child,
          );
  }
}
