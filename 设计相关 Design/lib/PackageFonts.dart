import 'package:flutter/material.dart';
//自定义字体
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: '自定义字体'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '依赖包中字体 abcdefg123',
              style: TextStyle(
                  package: 'awesome_package',
                  fontFamily: 'SemiBold'
              ),
            ),
            Text(
              '资源定义字体 abcdefg123',
              style: TextStyle(
                  fontFamily: 'Chilanka'
              ),
            ),
          ],
        ),
      ),
    );
  }
}