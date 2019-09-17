import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '响应文本框内容的更改',
      home: MyCustomForm(),
    );
  }
}

//响应文本框内容的更改
//方案一： 给 TextField 绑定 onChanged 回调
//方案二： 使用 TextEditingController

class MyCustomForm extends StatefulWidget {
  @override
  _MyCustomFormState createState() => _MyCustomFormState();
}

class _MyCustomFormState extends State<MyCustomForm> {
//2. 使用 TextEditingController
/*
另外一种更强大但是更复杂的方法是绑定 TextEditingController 作为 TextField 和 TextFormField 的 controller 属性。
你可以通过如下步骤，使用 addListener() 方法来监听控制，实现在文本更改时收到通知：
1.创建一个 TextEditingController
2.将 TextEditingController 绑定到 text field
3.创建一个函数来打印最新值
4.监听控制器的变化
 */

  final myController = TextEditingController();

  @override
  void initState() {
    super.initState();
    myController.addListener(_printLatestValue);
  }

  @override
  void dispose() {
    myController.dispose();//请在 TextEditingController 使用完毕时将其 dispose ，从而确保所有被这个对象所使用的资源被释放。
    super.dispose();
  }

  _printLatestValue() {
    print("Second text field: ${myController.text}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('响应文本框内容的更改'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(//1. 给 TextField 绑定 onChanged 回调
              onChanged: (text) {
                print("First text field: $text");
              },
            ),
            TextField(
              //最简单的方法是给 TextField 绑定 onChanged 回调。每当文本内容改变时，回调函数会被触发。但这种方法有一个缺点，它不适用于 TextFormField 组件。
              controller: myController,
            ),
          ],
        ),
      ),
    );
  }
}