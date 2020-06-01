import 'dart:async';

import 'package:flutter/material.dart';

class ListPage extends StatefulWidget {
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Copouns'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    Timer.run(() {
      showAlertDialog(context);
    });
  }

  void showAlertDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(
              margin: EdgeInsets.only(left: 15), child: Text("Loading...")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: alert,
        );
      },
    );
  }
}
