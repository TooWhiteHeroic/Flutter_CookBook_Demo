import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SnackBar Demo',
      home: Scaffold(//1. 创建一个 Scaffold    Drawer Tabs Snackbars
        appBar: AppBar(
          title: Text('SnackBar Demo'),
        ),
        body: SnackBarPage(),
      ),
    );
  }
}

class SnackBarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: RaisedButton(
        onPressed: () {
          final snackBar = SnackBar(
            content: Text('Yay! A SnackBar!'),
            action: SnackBarAction(
              label: 'Undo',
              onPressed: () {//3. 提供一个附加的操作
                // Some code to undo the change.
                //在某些情况下，我们可能想在显示 SnackBar 的时候给用户提供一个附加的操作。比如，当他们意外的删除了一个消息，我们可以提供一个撤销更改的操作。
              },
            ),
          );
          //2.显示一个 SnackBar
          Scaffold.of(context).showSnackBar(snackBar);
        },
        child: Text('Show SnackBar'),
      ),
    );
  }
}