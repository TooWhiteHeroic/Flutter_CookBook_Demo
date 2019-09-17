import 'package:flutter/material.dart';

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  MyAppState createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  //创建一个数据源
  final items = List<String>.generate(20, (i) => "Item ${i + 1}");

  @override
  Widget build(BuildContext context) {
    final title = 'Dismissing Items';

    return MaterialApp(
      title: title,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: ListView.builder(//1. 创建项目列表
          itemCount: items.length,//列表大小
          itemBuilder: (context, index) {//通过更新 itemBuilder() 函数来返回一个Dismissible Widget
            final item = items[index];

            return Dismissible(//2. 把每一项打包一个 Dismissible Widget
/*
在这个步骤中，用户可以通过使用 Dismissible 来删除列表中的某项。
在用户将某一项滑出屏幕后，我们需要将那一项从列表中删除并显示一个 Snackbar。在真实的应用中，你可能需要执行更复杂的逻辑，比如从网页服务或数据库中删除此项。
 */
              // 每个Dismissible实例都必须包含一个Key。Key让Flutter能够对Widgets做唯一标识。
              key: Key(item),
              // 我们还需要提供一个函数，告诉应用，在项目被移出后，要做什么。
              onDismissed: (direction) {
                // 从数据源中移除项目
                setState(() {
                  items.removeAt(index);
                });
                // 展示一个 snackbar！
                Scaffold.of(context).showSnackBar(SnackBar(content: Text("$item dismissed")));//3. 提供“滞留”提示
              },
              // 列表项被滑出时，显示一个红色背景(Show a red background as the item is swiped away)
              background: Container(color: Colors.red),
              /*
              顾名思义，我们的应用允许用户将列表项滑出列表，但是应用可能没有向用户给出视觉提示，告诉他们操作时发生了什么。
              要给出提示，表明我们正在删除列表项，就需要在他们将列表项滑出屏幕的时候，展示一个“滞留”提示。这个例子中，我们使用了一个红色背景！
               */
              child: ListTile(title: Text('$item')),//将数据源转换成一个 List
            );
          },
        ),
      ),
    );
  }
}