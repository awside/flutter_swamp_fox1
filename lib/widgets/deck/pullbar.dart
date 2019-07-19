import 'package:flutter/material.dart';


class PullBar extends StatelessWidget {
  final Function(DragStartDetails) onVerticalDragStart;
  final Function(DragUpdateDetails) onVerticalDragUpdate;
  final Function onVerticalDragEnd;

  const PullBar(
      {this.onVerticalDragStart,
      this.onVerticalDragUpdate,
      this.onVerticalDragEnd});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragStart: (DragStartDetails value) =>
          onVerticalDragStart(value),
      onVerticalDragUpdate: (DragUpdateDetails value) =>
          onVerticalDragUpdate(value),
      onVerticalDragEnd: (f) => onVerticalDragEnd,
      child: Container(
        height: 35,
        decoration: BoxDecoration(
          color: Colors.transparent,
        ),
        child: Center(
          child: Container(
            constraints: BoxConstraints(maxHeight: 5, maxWidth: 60),
            decoration: BoxDecoration(
              color: Colors.grey.shade400,
              borderRadius: BorderRadius.circular(6),
            ),
          ),
        ),
      ),
    );
  }
}
