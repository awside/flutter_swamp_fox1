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
      alignment: Alignment(-1, 1),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 400),
        height: 44 + MediaQuery.of(context).padding.bottom,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(top: BorderSide(color: Colors.grey.shade300))),
        child: Column(
          children: <Widget>[
            Container(
              height: 43,
              child: Row(
                children: <Widget>[...buildButtons()],
              ),
            ),
            Container(
              height: MediaQuery.of(context).padding.bottom,
            )
          ],
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

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          HapticFeedback.lightImpact();
          parent.selectButton(buttonName);
        },
        child: Container(
          decoration:
              BoxDecoration(border: Border.all(color: Colors.transparent)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Icon(
                  iconData,
                  color: parent.currentButtonName == buttonName
                      ? Colors.lightBlueAccent
                      : Colors.grey,
                ),
              ),
              Icon(
                Icons.lens,
                size: 6,
                color: parent.currentButtonName == buttonName
                    ? Colors.lightBlueAccent
                    : Colors.transparent,
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
