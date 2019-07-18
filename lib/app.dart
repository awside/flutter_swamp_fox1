import 'dart:async';

import 'package:flutter/material.dart';
import 'package:swamp_fox/doctrine/doctrine.dart';
import 'package:swamp_fox/fileCache/file_cache.dart';
import 'package:swamp_fox/firebase/fb_firestore.dart';

import 'package:swamp_fox/localStorage/local_storage.dart';
import 'package:swamp_fox/widgets/deck/tint.dart';
// import 'package:swamp_fox/widgets/document_modal.dart';
// import 'package:swamp_fox/widgets/deck.dart';
import 'package:swamp_fox/widgets/doctrine_list_view.dart';

import 'bloc/bloc.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          color: Colors.white,
        ),
        Center(
          child: RaisedButton(
            onPressed: () {
              Tint.instance.event(TintEvent.open);
            },
          ),
        ),
        // DoctrineListView(),
        // BottomBar.instance,
        // TopBar.instance,
        // StatusBar.instance,
        Tint.instance,
        // DocumentModal.instance,
      ],
    );
  }
}

