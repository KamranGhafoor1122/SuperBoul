import 'package:flutter/material.dart';


class OTPField extends StatefulWidget {
  const OTPField({Key? key}) : super(key: key);

  @override
  State<OTPField> createState() => _OTPFieldState();
}

class _OTPFieldState extends State<OTPField> {

  double ? height;

  double ? width;
  TextEditingController ? contrller1;
  TextEditingController ? contrller2;
  TextEditingController ? contrller3;
  TextEditingController ? contrller4;
  TextEditingController ? contrller5;
  TextEditingController ? contrller6;

  @override
  void initState() {
    // TODO: implement initState
    contrller1 = TextEditingController();
    contrller2 = TextEditingController();
    contrller3 = TextEditingController();
    contrller4 = TextEditingController();
    contrller5 = TextEditingController();
    contrller6 = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    height= MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: _textFieldOTP(first: true, last: false, controllerr:
          contrller1),
        ),
        SizedBox(
          width: 6,
        ),
        Expanded(
          child: _textFieldOTP(first: false, last: false, controllerr:
          contrller2),
        ),
        SizedBox(
          width: 6,
        ),
        Expanded(
          child: _textFieldOTP(first: false, last: false, controllerr:
          contrller3),
        ),
        SizedBox(
          width: 6,
        ),
        Expanded(
          child: _textFieldOTP(first: false, last: false, controllerr:
          contrller4),
        ),
        SizedBox(
          width: 6,
        ),
        Expanded(
          child: _textFieldOTP(first: false, last: false, controllerr:
          contrller5),
        ),
        SizedBox(
          width: 6,
        ),
        Expanded(
          child: _textFieldOTP(first: false, last: true, controllerr:
          contrller6),
        ),
      ],
    );
  }


  Widget _textFieldOTP({bool ? first, last,
    TextEditingController ?
    controllerr}) {
    return TextField(
      controller: controllerr,
      autofocus: true,
      onChanged: (value) {
        if (value.length == 2 && last == false) {
          FocusScope.of(context).nextFocus();
        }
        if (value.length == 0 && first == false) {
          FocusScope.of(context).previousFocus();
        }
      },
      showCursor: true,
      readOnly: false,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
      keyboardType: TextInputType.number,
      maxLength: 2,
      decoration: InputDecoration(
        counter: Offstage(),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: Colors.black54),
            borderRadius: BorderRadius.circular(12)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: Colors.black54),
            borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
