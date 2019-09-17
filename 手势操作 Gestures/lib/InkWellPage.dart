import 'package:flutter/material.dart';
/*
当我们在开发遵循 Material Design 规范应用的时候，我们可能会需要为某个 Widgets 的点击加入涟漪效果。
Flutter 提供了 InkWell Widget 来实现这个功能。你可以通过以下步骤实现涟漪效果：
1.创建一个想要点击的 Widget
2.用 InkWell Widget 包裹它，并设置回调函数，就可以显示涟漪动画了。
 */
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final title = 'InkWell Demo';

    return MaterialApp(
      title: title,
      home: MyHomePage(title: title),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;

  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(child: MyButton()),
    );
  }
}

class MyButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // The InkWell wraps the custom flat button widget.
    return InkWell(
      // When the user taps the button, show a snackbar.
      onTap: () {
        Scaffold.of(context).showSnackBar(SnackBar(content: Text('Tap'),));
      },
      child: Container(
        padding: EdgeInsets.all(12.0),
        child: Text('Flat Button'),
      ),
    );
  }
}