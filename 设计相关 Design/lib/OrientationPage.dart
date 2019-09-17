import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Orientation Demo';

    return MaterialApp(
      title: appTitle,
      home: OrientationList(
        title: appTitle,
      ),
    );
  }
}

class OrientationList extends StatelessWidget {
  final String title;

  OrientationList({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: OrientationBuilder(//2.使用 OrientationBuilder 更改列数
        builder: (context, orientation) {
          return GridView.count(//1.创建一个列的数量为 2 的 GridView
            crossAxisCount: orientation == Orientation.portrait ? 2 : 3,//在纵向模式下显示两列，在横向模式下显示三列。
            // Generate 50 widgets that display their index in the List.
            children: List.generate(50, (index) {
              return Center(
                child: Text(
                  'Item $index',
                  style: Theme.of(context).textTheme.headline,
                ),
              );
            }),
          );
        },
      ),
    );
  }
}