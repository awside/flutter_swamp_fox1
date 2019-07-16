import 'dart:async';

import 'package:flutter/material.dart';
import 'package:swamp_fox/fileCache/file_cache.dart';
import 'package:swamp_fox/firebase/fb_firestore.dart';

import 'package:swamp_fox/loaders/yaml_loader.dart';
import 'package:swamp_fox/localStorage/local_storage.dart';
import 'package:swamp_fox/widgets/document_modal.dart';
import 'package:swamp_fox/widgets/deck.dart';
import 'package:swamp_fox/widgets/doctrine_list_view.dart';

import 'bloc/bloc.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // LocalStorage.instance.deleteFile('doctrine.yaml');
    // YAMLLoader.instance.loadDocuments('doctrine.yaml');
    return Stack(
      children: <Widget>[
        Container(
          color: Colors.white,
        ),
        // DoctrineListView(),
        Test1(),
        // BottomBar.instance,
        // TopBar.instance,
        // StatusBar.instance,
        // DocumentModal.instance,
      ],
    );
  }
}

class Test1 extends StatefulWidget {
  @override
  _Test1State createState() => _Test1State();
}

class _Test1State extends State<Test1> {
  final _bloc = Bloc();
  final fileCache = FileCache('doctrine.yaml');

  _Test1State() {
    fileCache.stream.listen((data) {
      _bloc.sink.add(data as String);
    });
  }

  @override
  void dispose() {
    super.dispose();
    fileCache.close();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _bloc.stream,
      initialData: 'loading',
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Center(
          child: IntrinsicHeight(
            child: Column(
              children: <Widget>[
                Container(
                  child: Text(snapshot.data.toString().substring(0, 4)),
                ),
                RaisedButton(
                  onPressed: () => _bloc.sink.add(null),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
