import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:swamp_fox/bloc/bloc.dart';
import 'package:swamp_fox/helper/screen_ruler.dart';
import 'package:typicons_flutter/typicons.dart';

class NavBarData {
  Color backgroundColor = Color.fromRGBO(216, 225, 211, 1);
  List<Widget> buttons = [];
}

class NavBarBloc extends Bloc<NavBarData> {
  var eventStateObj = NavBarData();
  List<IconData> icons = [Typicons.home, Typicons.book, Icons.people];

  NavBarBloc() {
    _buildButtons();
  }

  _buildButtons({int selectedIndex = 0}) {
    eventStateObj.buttons.clear();
    for (var i = 0; i < icons.length; i++) {
      eventStateObj.buttons.add(NavBarButton(
        index: i,
        selected: i == selectedIndex,
        iconData: icons[i],
        callback: handleButton,
      ));
    }
  }

  handleButton(int index) {
    _buildButtons(selectedIndex: index);
    sink();
  }
}

class NavBar extends StatelessWidget {
  final bloc = NavBarBloc();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<NavBarData>(
        stream: bloc.stream,
        initialData: bloc.eventStateObj,
        builder: (context, snapshot) {
          return Align(
            alignment: Alignment(0, 1),
            child: IntrinsicHeight(
              child: Container(
                color: snapshot.data.backgroundColor,
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 40,
                      child: Row(
                        children: snapshot.data.buttons,
                      ),
                    ),
                    Container(height: ScreenSize.instance.paddingBottom)
                  ],
                ),
              ),
            ),
          );
        });
  }
}

class NavBarButton extends StatelessWidget {
  final Color iconColor = const Color.fromRGBO(58, 74, 81, 1);
  final Color iconColorSelected = const Color.fromRGBO(255, 111, 61, 1);
  final int index;
  final bool selected;
  final IconData iconData;
  final Function(int) callback;

  NavBarButton({
    @required this.index,
    @required this.selected,
    this.iconData,
    this.callback,
  });

  handleButton() {
    HapticFeedback.lightImpact();
    callback?.call(index);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: handleButton,
        child: Container(
          color: Colors.transparent,
          child: Center(
            child: Icon(
              iconData ?? Typicons.beer,
              size: 32,
              color: selected ? iconColorSelected : iconColor,
            ),
          ),
        ),
      ),
    );
  }
}
