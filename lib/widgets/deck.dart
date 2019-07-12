import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:typicons_flutter/typicons_flutter.dart';

class StatusBar extends StatelessWidget {
  static final StatusBar instance = StatusBar._privateConstructor();
  StatusBar._privateConstructor();

  final Color backgroundColor = Color.fromRGBO(216, 225, 211, 1);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).padding.top,
      color: Colors.white,
    );
  }
}

class TopBar extends StatefulWidget {
  static final TopBar instance = TopBar._privateConstructor();
  TopBar._privateConstructor();
  static final _TopBarState state = _TopBarState();

  final double height = 34;
  final Color iconColor = Color.fromRGBO(58, 74, 81, 1);
  final Color iconColorSelected = Color.fromRGBO(255, 111, 61, 1);
  final Color backgroundColor = Color.fromRGBO(216, 225, 211, 1);

  @override
  _TopBarState createState() => state;
}

class _TopBarState extends State<TopBar> {
  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Container(height: MediaQuery.of(context).padding.top),
            Container(
              height: widget.height,
              child: Text(
                'Title',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.5,
                  color: widget.iconColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BottomBar extends StatefulWidget {
  static final BottomBar instance = BottomBar._privateConstructor();
  BottomBar._privateConstructor();
  static final _BottomBarState state = _BottomBarState();

  @override
  _BottomBarState createState() => state;
}

class _BottomBarState extends State<BottomBar> {
  Color backgroundColor = Color.fromRGBO(216, 225, 211, 1);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment(0, 1),
      child: IntrinsicHeight(
        child: Container(
          color: backgroundColor,
          child: Column(
            children: <Widget>[
              ButtonBar(),
              Container(height: MediaQuery.of(context).padding.bottom)
            ],
          ),
        ),
      ),
    );
  }
}

class ButtonBar extends StatefulWidget {
  @override
  _ButtonBarState createState() => _ButtonBarState();
}

class _ButtonBarState extends State<ButtonBar> {
  final Color backgroundColor = Color.fromRGBO(216, 225, 211, 1);
  int selectedIndex = 0;

  setSelectedIndex(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: Row(
        children: <Widget>[
          ButtonBarButton(
            index: 0,
            selectedIndex: selectedIndex,
            iconData: Icons.home,
            callback: () => setSelectedIndex(0),
          ),
          ButtonBarButton(
            index: 1,
            selectedIndex: selectedIndex,
            iconData: Icons.home,
            callback: () => setSelectedIndex(1),
          ),
          ButtonBarButton(
            index: 2,
            selectedIndex: selectedIndex,
            iconData: Icons.home,
            callback: () => setSelectedIndex(2),
          ),
        ],
      ),
    );
  }
}

class ButtonBarButton extends StatelessWidget {
  final Color iconColor = const Color.fromRGBO(58, 74, 81, 1);
  final Color iconColorSelected = const Color.fromRGBO(255, 111, 61, 1);
  final int index;
  final int selectedIndex;
  final IconData iconData;
  final Function callback;

  const ButtonBarButton({
    Key key,
    @required this.index,
    @required this.selectedIndex,
    this.iconData,
    this.callback,
  }) : super(key: key);

  handleButton() {
    HapticFeedback.lightImpact();
    callback?.call();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: handleButton(),
        child: Container(
          color: Colors.transparent,
          child: Center(
            child: Icon(
              iconData ?? Typicons.beer,
              size: 32,
              color: index == selectedIndex ? iconColorSelected : iconColor,
            ),
          ),
        ),
      ),
    );
  }
}
