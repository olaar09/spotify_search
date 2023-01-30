import 'package:flutter/material.dart';

class YSpaceBetween extends StatelessWidget {
  final double space;

  const YSpaceBetween({Key? key, this.space = 10}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: space);
  }
}

class XSpaceBetween extends StatelessWidget {
  final double space;

  const XSpaceBetween({Key? key, this.space = 10}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: space);
  }
}
