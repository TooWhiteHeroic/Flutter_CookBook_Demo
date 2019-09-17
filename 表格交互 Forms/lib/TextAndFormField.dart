import 'package:flutter/material.dart';

//Flutter 提供了两个开箱即用的文本框组件：TextField 和 TextFormField。
//文本框作为一个接收用户输入的组件，被广泛应用于表单构建、即时通讯、搜索等场景中。
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = '文本框';

    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: Text(appTitle),
        ),
        body: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Enter a search term'
              ),
            ),
            TextFormField(
              decoration: InputDecoration(
                  labelText: 'Enter your username'
              ),
            )
          ],
        )
      ),
    );
  }
}