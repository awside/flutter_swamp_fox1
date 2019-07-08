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
            padding: EdgeInsets.only(left: 16, right: 16),
            child: Text(
              'Doctrine',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w600,
              ),
            ),
          );
        return widgetList[index - 1];
      },
    );
  }
}
