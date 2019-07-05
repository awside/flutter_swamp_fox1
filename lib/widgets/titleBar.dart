import 'package:flutter/material.dart';

class TitleBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      padding: EdgeInsets.only(left: 16, right: 16),
      height: 44,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
      ),
      child: Row(
        children: <Widget>[
          Container(width: 44, height: 44, child: Icon(Icons.arrow_back)),
          Expanded(
            flex: 5,
            child: Container(
              child: Center(
                child: Text('Doctrine',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    )),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(width: 44, height: 44),
            ],
          )
        ],
      ),
    );
  }
}
