import 'package:flutter/material.dart';

class StatusBar extends StatelessWidget {
  final Color backgroundColor = Color.fromRGBO(216, 225, 211, 1);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).padding.top,
      color: backgroundColor,
    );
  }
}
