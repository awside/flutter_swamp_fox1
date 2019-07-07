import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ButtonBar extends StatefulWidget {
  static double height = 44;
  static Color iconColor = Color.fromRGBO(58, 74, 81, 1);
  static Color iconColorSelected = Color.fromRGBO(255, 111, 61, 1);
  static Color backgroundColor = Color.fromRGBO(216, 225, 211, 1);

  @override
  _ButtonBarState createState() => _ButtonBarState();
}

class _ButtonBarState extends State<ButtonBar> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ButtonBar.height,
      color: ButtonBar.backgroundColor,
      child: Row(
        children: getButtons(),
      ),
    );
  }

  List<ButtonBarButton> getButtons() {
    return [
      ButtonBarButtonData(
        index: 0,
        iconData: Icons.home,
        callback: () => handleButton(0),
      ),
      ButtonBarButtonData(
        index: 1,
        iconData: Icons.book,
        callback: () => handleButton(1),
      ),
      ButtonBarButtonData(
        index: 2,
        iconData: Icons.people,
        callback: () => handleButton(2),
      ),
    ]
        .map(
          (buttonData) => ButtonBarButton(
            data: buttonData,
            selectedIndex: selectedIndex,
          ),
        )
        .toList();
  }

  handleButton(int index) {
    HapticFeedback.lightImpact();
    setState(() {
      selectedIndex = index;
    });
    switch (index) {
      case 0:
        break;
      case 1:
        break;
      case 3:
        break;
      default:
        break;
    }
  }
}

class ButtonBarButtonData {
  final int index;
  final IconData iconData;
  final Function callback;

  ButtonBarButtonData(
      {@required this.index, @required this.iconData, @required this.callback});
}

class ButtonBarButton extends StatelessWidget {
  final ButtonBarButtonData data;
  final int selectedIndex;

  const ButtonBarButton(
      {Key key, @required this.data, @required this.selectedIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: data.callback,
        child: Container(
          color: Colors.transparent,
          child: Center(
            child: Icon(
              data.iconData,
              size: 32,
              color: data.index == selectedIndex
                  ? ButtonBar.iconColorSelected
                  : ButtonBar.iconColor,
            ),
          ),
        ),
      ),
    );
  }
}
