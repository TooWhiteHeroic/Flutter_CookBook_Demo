import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

//全局主题和局部主题
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(//全局主题
        // Define the default brightness and colors.
        brightness: Brightness.dark,
        primaryColor: Colors.lightBlue[800],
        accentColor: Colors.cyan[600],
        primarySwatch: Colors.blue,
        // Define the default font family.
        fontFamily: 'Montserrat',
        textTheme: TextTheme(
          headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          title: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          body1: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        ),
      ),
      home: MyHomePage(title: '全局主题和局部主题'),
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
          child: Container(
/*
Theme.of(context) 会查询 widget 树，并返回其中最近的 Theme。所以他会优先返回我们之前定义过的一个独立的 Theme，如果找不到，它会返回全局 theme。
 */
            color: Theme.of(context).accentColor,//局部Theme
            child: Text(
              'Text with a background color',
              style: Theme.of(context).textTheme.title,
            ),
          ),
        ),
      floatingActionButton: Theme(
        data: Theme.of(context).copyWith(//copyWith  使用定义好的Theme
          colorScheme: Theme.of(context).colorScheme.copyWith(secondary: Colors.yellow),
        ),
        child: FloatingActionButton(
          onPressed: null,
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}