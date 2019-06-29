import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NavBar extends StatefulWidget {
  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  final Map<String, IconData> buttonData = {
    'home': Icons.home,
    'training': Icons.library_books,
    'students': Icons.people,
    'back': Icons.arrow_back,
  };
  String currentButtonName = 'home';

  @override
  void initState() {
    super.initState();
  }

  List<NavBarButton> buildButtons() {
    List<NavBarButton> buttonList = [];
    buttonData.forEach((buttonName, iconData) {
      buttonList.add(NavBarButton(buttonName, iconData, this));
    });
    return buttonList;
  }

  selectButton(String buttonName) {
    setState(() {
      currentButtonName = buttonName;
    });
  }

// ((16 + MediaQuery.of(context).padding.bottom) / MediaQuery.of(context).size.height)

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment(1, 1),
      child: AnimatedContainer(
        decoration: BoxDecoration(
            // borderRadius: BorderRadius.circular(15),
            border: Border.all(
          width: 0.15,
          color: Colors.blueGrey,
        )),
        margin: EdgeInsets.only(left: 0, right: 0),
        duration: Duration(milliseconds: 0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(0),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Container(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).padding.bottom),
              // padding: EdgeInsets.only(top: 4, bottom: 4),
              decoration:
                  BoxDecoration(color: Colors.grey.shade100.withOpacity(0.55)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[...buildButtons()],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class NavBarButton extends StatelessWidget {
  final _NavBarState parent;
  final String buttonName;
  final IconData iconData;

  const NavBarButton(this.buttonName, this.iconData, this.parent, {Key key})
      : super(key: key);

  _dot() {
    if (parent.currentButtonName == buttonName) {
      return Icon(
        Icons.lens,
        size: 8,
        color: Colors.grey,
      );
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          HapticFeedback.lightImpact();
          parent.selectButton(buttonName);
        },
        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                      color: buttonName == 'back'
                          ? Colors.grey
                          : Colors.transparent),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Icon(
                  iconData,
                  color: parent.currentButtonName == buttonName
                      ? Colors.lightBlueAccent
                      : Colors.grey,
                ),
              ),
              // Text(
              //   '$buttonName'.toUpperCase(),
              //   style: TextStyle(
              //     color: parent.currentButtonName == buttonName
              //         ? Colors.lightBlueAccent
              //         : Colors.grey,
              //     fontSize: 10,
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
