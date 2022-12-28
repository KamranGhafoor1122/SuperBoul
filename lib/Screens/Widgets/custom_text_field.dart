import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextsField extends StatefulWidget {
  final String hintText;
  final Text? label;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final FocusNode? nextFocus;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final bool isPassword;
  final Function? onChanged;
  final Function? onSubmit;
  final bool isEnabled;
  final int maxLines;
  final TextCapitalization capitalization;
  final String? prefixIcon;
  final bool divider;

  CustomTextsField(
      {this.hintText = 'Write something...',
      this.controller,
      this.focusNode,
      this.nextFocus,
      this.isEnabled = true,
      this.inputType = TextInputType.text,
      this.inputAction = TextInputAction.next,
      this.maxLines = 1,
      this.onSubmit,
      this.onChanged,
      this.prefixIcon,
      this.capitalization = TextCapitalization.none,
      this.isPassword = false,
      this.divider = false,
      this.label});

  @override
  _CustomTextsFieldState createState() => _CustomTextsFieldState();
}

class _CustomTextsFieldState extends State<CustomTextsField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: widget.maxLines,
      controller: widget.controller,
      focusNode: widget.focusNode,
      //style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeLarge),
      textInputAction: widget.inputAction,
      keyboardType: widget.inputType,
      cursorColor: Theme.of(context).primaryColor,
      textCapitalization: widget.capitalization,
      enabled: widget.isEnabled,
      autofocus: false,
      readOnly: true,
      obscureText: widget.isPassword ? _obscureText : false,
      inputFormatters: widget.inputType == TextInputType.phone ? <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp('[0-9]'))] : null,
      decoration: InputDecoration(
        border: InputBorder.none,
        fillColor: const Color(0xffEAEAEA),
        filled: true,
        labelStyle: const TextStyle(fontWeight: FontWeight.w500, color: Colors.black),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 0),
          borderRadius: BorderRadius.circular(10.r),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 0),
          borderRadius: BorderRadius.circular(10.r),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 0),
          borderRadius: BorderRadius.circular(10.r),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 0),
          borderRadius: BorderRadius.circular(10.r),
        ),
        label: widget.label,
        /* border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
          borderSide: BorderSide(style: BorderStyle.none, width: 0),
        ),*/
        isDense: true,
        hintText: widget.hintText,
        // hintStyle: TextStyle(fontSize: 2),
        prefixIcon: widget.prefixIcon != null
            ? Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Image.asset("${widget.prefixIcon}", height: 20, width: 20),
              )
            : null,
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility, color: Theme.of(context).hintColor.withOpacity(0.3)),
                onPressed: _toggle,
              )
            : null,
      ),
      /* onSubmitted: (text) => widget.nextFocus != null ? FocusScope.of(context).requestFocus(widget.nextFocus)
          : widget.onSubmit != null ? widget.onSubmit(text) : null,
      onChanged: widget.onChanged,*/
    );
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
}
