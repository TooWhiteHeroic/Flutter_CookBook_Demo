import 'package:flutter/material.dart';

//自动聚焦到文本框，无需用户点击

//1.一旦文本框可见，就将其聚焦
//设置文本框属性 autofocus: true,

//2.点击按钮聚焦文本框
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Text Field Focus',
      home: MyCustomForm(),
    );
  }
}
class MyCustomForm extends StatefulWidget {
  @override
  _MyCustomFormState createState() => _MyCustomFormState();
}

class _MyCustomFormState extends State<MyCustomForm> {
  //1. 创建一个 FocusNode
  FocusNode myFocusNode;
  /*
  由于 focus node 是长寿命对象，我们需要使用 State 类来管理生命周期。
  为此，需要在 State 类的 initState 方法中创建 FocusNode 实例，并在 dispose 方法中清除它们。
   */
  @override
  void initState() {
    super.initState();
    myFocusNode = FocusNode();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    myFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Text Field Focus'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(//设置自动获取焦点属性，一旦可见自动获取焦点
              autofocus: true,
            ),
            TextField(//2. 将 FocusNode 传递给 TextField
              focusNode: myFocusNode,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        //3. 通过点击按钮聚焦 TextField
        onPressed: () => FocusScope.of(context).requestFocus(myFocusNode),
        tooltip: 'Focus Second Text Field',
        child: Icon(Icons.edit),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}