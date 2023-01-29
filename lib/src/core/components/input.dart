import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class TextInput extends StatefulWidget {
  final String hintText;
  final Function? validator;
  final Function? onChanged;
  final Function? doFocusChanged;
  final bool isPassword;
  final int? maxLines;
  final TextEditingController? controller;
  final bool autoFocus;
  final Widget? titleWidget;
  final double letterSpacing;
  final TextInputType keyboardType;
  final Color? bgColor;
  final Color? textColor;
  final double textBoxPadding;
  final double fontSize;
  final bool disableBorder;
  final Color? hintColor;

  TextInput(
      {required this.hintText,
      this.validator,
      required this.onChanged,
      this.isPassword = false,
      this.controller,
      this.autoFocus = false,
      this.letterSpacing = 0,
      this.titleWidget,
      this.textBoxPadding = 16,
      this.fontSize = 16,
      this.bgColor,
      this.maxLines,
      this.textColor,
      this.hintColor,
      this.doFocusChanged,
      this.disableBorder = false,
      this.keyboardType = TextInputType.text});

  @override
  _TextInputState createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  FocusNode focusNode = FocusNode();
  Color borderColor = Colors.transparent;

  onFocusChanges() {
    if (widget.doFocusChanged != null) {
      widget.doFocusChanged!();
    }
  }

  @override
  void initState() {
    focusNode.addListener(() => onFocusChanges());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: CupertinoTextField(
        controller: widget.controller,
        placeholder: widget.hintText,
        autofocus: widget.autoFocus,
        cursorColor: widget.textColor,
        focusNode: focusNode,
        maxLines: widget.maxLines ?? 1,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(5.0) //
              ),
          color: widget.bgColor ?? Colors.transparent,
          border: widget.disableBorder
              ? const Border.symmetric()
              : Border.all(color: borderColor),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: widget.textBoxPadding,
          vertical: 15,
        ),
        style: TextStyle(
            fontSize: widget.fontSize,
            color: widget.textColor ?? Colors.transparent,
            fontWeight: FontWeight.normal,
            letterSpacing: widget.letterSpacing),
        placeholderStyle: TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: widget.fontSize,
          color: widget.hintColor ?? Colors.grey.shade400,
        ),
        obscureText: widget.isPassword ? true : false,
        onChanged: (String text) =>
            widget.onChanged != null ? widget.onChanged!(text) : (text) {},
        keyboardType: widget.keyboardType,
      ),
    );
  }
}
