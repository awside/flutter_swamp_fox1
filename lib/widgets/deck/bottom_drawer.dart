// import 'dart:async';

// import 'package:flutter/material.dart';

// import 'tint.dart';

// class Reader extends StatefulWidget {
//   static final _ReaderState instance = _ReaderState();

//   @override
//   _ReaderState createState() => instance;
// }

// class _ReaderState extends State<Reader> {
//   Widget _content = Container();
//   set content(Widget content) {
//     _content = content;
//   }

//   open() {
//     Tint.instance.turnOn(Duration(milliseconds: 300));
//     ModalWindow.instance.turnOn();
//   }

//   close() {
//     Tint.instance.turnOff(Duration(milliseconds: 300));
//     ModalWindow.instance.turnOff();
//   }

//   closeQuickly() {
//     Tint.instance.turnOff(Duration(milliseconds: 200));
//     ModalWindow.instance.turnOffQuickly();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Stack(children: <Widget>[
//       Tint(),
//       ModalWindow(),
//     ]);
//   }
// }


// class ModalWindow extends StatefulWidget {
//   static final _ModalWindowState instance = _ModalWindowState();
//   @override
//   _ModalWindowState createState() => instance;
// }

// class _ModalWindowState extends State<ModalWindow> {

//   Widget _content = Container();
//   bool _isActive = false;
//   double _yOffset = 0;
//   Duration _duration = Duration(milliseconds: 300);

//   updateContent(Widget content) {
//     setState(() {
//       _content = content;
//     });
//   }

//   turnOn() {
//     setState(() {
//       isActive = true;
//       duration = Duration(milliseconds: 300);
//     });
//   }

//   turnOff() {
//     setState(() {
//       isActive = false;
//       yOffset = 0;
//       duration = Duration(milliseconds: 300);
//     });
//   }

//   turnOffQuickly() {
//     setState(() {
//       isActive = false;
//       yOffset = 0;
//       duration = Duration(milliseconds: 200);
//     });
//   }

//   setInstantMode() {
//     setState(() {
//       duration = Duration(milliseconds: 0);
//     });
//   }

//   resetQuicklyToTop() {
//     setState(() {
//       yOffset = 0;
//       duration = Duration(milliseconds: 50);
//     });
//   }

//   shouldTurnOff() {
//     if (yOffset > 50) {
//       // DocumentModal.instance.turnOff();
//     } else {
//       resetQuicklyToTop();
//     }
//   }

//   move(double dy) {
//     if (dy > 10) {
//       // DocumentModal.instance.turnOffQuickly();
//       return;
//     }
//     setState(() {
//       yOffset = yOffset + dy < 0 ? 0 : yOffset + dy;
//     });
//   }

//   _getWindowPosition(BuildContext context) {
//     if (!isActive) {
//       return MediaQuery.of(context).size.height;
//     } else {
//       return MediaQuery.of(context).padding.top + yOffset;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedPositioned(
//       top: _getWindowPosition(context),
//       width: MediaQuery.of(context).size.width,
//       height: MediaQuery.of(context).size.height -
//           MediaQuery.of(context).padding.top,
//       duration: duration,
//       curve: Curves.easeInOut,
//       child: ClipRRect(
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(30),
//           topRight: Radius.circular(30),
//         ),
//         child: Stack(
//           children: <Widget>[
//             Container(color: Colors.white),
//             _content,
//             PullBar(),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class PullBar extends StatefulWidget {
//   @override
//   _PullBarState createState() => _PullBarState();
// }

// class _PullBarState extends State<PullBar> {
//   double topStakedDragPositionY;

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onVerticalDragStart: (DragStartDetails value) {
//         topStakedDragPositionY = value.globalPosition.dy;
//         ModalWindow.instance.setInstantMode();
//       },
//       onVerticalDragUpdate: (DragUpdateDetails value) {
//         // if (value.globalPosition.dy < MediaQuery.of(context).padding.top) {
//         //   ModalWindow.instance.resetQuicklyToTop();
//         //   return;
//         // }
//         if (value.globalPosition.dy < topStakedDragPositionY) {
//           ModalWindow.instance.resetQuicklyToTop();
//           return;
//         }
//         ModalWindow.instance.move(value.delta.dy);
//       },
//       onVerticalDragEnd: (f) {
//         ModalWindow.instance.shouldTurnOff();
//       },
//       child: Container(
//         height: 35,
//         decoration: BoxDecoration(
//           color: Colors.transparent,
//         ),
//         child: Center(
//           child: Container(
//             constraints: BoxConstraints(maxHeight: 5, maxWidth: 60),
//             decoration: BoxDecoration(
//               color: Colors.grey.shade400,
//               borderRadius: BorderRadius.circular(6),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
