import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:swamp_fox/bloc/bloc.dart';
import 'package:swamp_fox/helper/screen_ruler.dart';
import 'package:typicons_flutter/typicons.dart';

class NavBarData {
  Color backgroundColor = Color.fromRGBO(216, 225, 211, 1);
}

class NavBarBloc extends Bloc<NavBarData> {
  var eventStateObj = NavBarData();
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
                        children: <Widget>[
                          ButtonBarButton(
                            index: 0,
                            selectedIndex: 1,
                            iconData: Typicons.home,
                            callback: () => null,
                          )
                        ],
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

// iconData: Typicons.home
// iconData: Typicons.book
// iconData: Icons.people

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
        onTap: handleButton,
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
