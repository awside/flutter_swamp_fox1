import 'package:flutter/material.dart';
import 'package:swamp_fox/helper/screen_ruler.dart';
import 'widgets/deck/deck.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenSize.instance.setSizes(context);
    return Deck.instance;
  }
}
