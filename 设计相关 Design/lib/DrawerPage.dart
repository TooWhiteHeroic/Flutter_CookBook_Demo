import 'package:flutter/material.dart';

/*
在 Material Design 设计准则里，主要提供了两种导航方式：Tab 和 Drawer。当没有足够的空间来支持 tab 导航时，drawer 提供了另一个方便的选择。
 */
class MyApp extends StatelessWidget {
  final appTitle = 'Drawer Demo';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      home: MyHomePage(title: appTitle),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;

  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(            //1.创建一个 Scaffold
      appBar: AppBar(title: Text(title)),
      body: Center(child: Text('My Page!')),
      drawer: Drawer(//2. 添加一个 drawer  抽屉
      // Add a ListView to the drawer. This ensures the user can scroll
        child: ListView(//3.向 drawer 中添加内容
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(//使用DrawerHeader和ListTile填充Drawer
              child: Text('Drawer Header'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Item 1'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                /*
                我们经常需要在用户点击某个项目后就将 Drawer 关掉。那么怎样才能做到这一点呢？
                当用户打开 Drawer 时，Flutter 会将 drawer widget 覆盖在当前的导航堆栈上。
                因此，要关闭 drawer，我们可以通过调用 Navigator.pop(context) 来实现。
                 */
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Item 2'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}