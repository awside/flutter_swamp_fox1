import 'package:flutter/material.dart';
import 'package:swamp_fox/widgets/topBar.dart';

class ListPage extends StatelessWidget {
  final List<Widget> widgetList;

  const ListPage({Key key, @required this.widgetList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widgetList.length + 1,
      itemBuilder: (BuildContext context, int index) {
        if (index == 0)
          return Container(
            height: TopBar.height,
          );
        return widgetList[index - 1];
      },
    );
  }
}
