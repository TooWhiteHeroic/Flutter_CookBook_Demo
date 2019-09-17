import 'package:flutter/material.dart';
/*
应用程序通常会要求用户在文本框中输入信息。例如，我们可能正在开发一个应用程序，该应用程序就需要用户输入邮箱和密码登录。
为了让应用程序更为安全易用，我们通常都需要验证用户输入的信息是否有效。
如果用户输入了正确的信息，就可以针对该信息进行后续处理。
如果用户输入了错误的信息，就需要在相关的输入区域展示一条输入信息出错的提示，以便用户更正输入。
你可以通过以下步骤，在下面的例子中学习如何为表单中的文本输入框加入验证判断的功能：
1.创建表单 Form，并以 GlobalKey 作为唯一性标识
2.添加带验证逻辑的 TextFormField 到表单中
3.创建按钮以验证和提交表单
 */
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Form Validation Demo';

    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: Text(appTitle),
        ),
        body: MyCustomForm(),
      ),
    );
  }
}

// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

//1. 创建表单 Form，并以 GlobalKey 作为唯一性标识
class MyCustomFormState extends State<MyCustomForm> {
//首先，我们需要创建一个表单组件 Form 作为容器承载和验证多个表单域。
//当我们创建表单 Form 的时候，需要提供一个 GlobalKey。
//GlobalKey 唯一标识了这个表单 Form，在后续的表单验证步骤中，也起到了关键的作用。

  final _formKey = GlobalKey<FormState>();//一般情况下，推荐使用 GlobalKey 来访问一个表单。嵌套组件且组件树比较复杂的情况下，可以使用 Form.of() 方法访问表单。

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(//2. 添加带验证逻辑的 TextFormField 到表单中
            /*
            通过给 TextFormField 加入 validator() 函数可以验证输入是否正确。
            validator 函数会校验用户输入的信息，如果信息有误，会返回包含出错原因的字符串 String。如果信息无误，则不返回。
            在下面的实例中，我们会在 TextFormField 中加入一个 validator 验证函数，它的功能是判断用户输入的文本是否为空，如果为空，就返回「请输入文本」的友情提示。
             */
            validator: (value) {
              if (value.isEmpty) {
                return '请输入文本';
              }
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: RaisedButton(//3. 创建按钮以验证和提交表单
              onPressed: () {
                if (_formKey.currentState.validate()) {//判度TextFromField中的条件是否满足
                  /*
                  在创建完表单以及文本框后，还需要提供一个按钮让用户提交表单。
                  当用户提交表单后，我们会预先检查表单信息是否有效。
                  如果文本框有内容，表单有效，则会显示正确信息。
                  如果文本框没有输入任何内容，表单无效，会在文本框区域展示错误提示。
                   */
                  // If the form is valid, display a Snackbar.
                  Scaffold.of(context).showSnackBar(SnackBar(content: Text('处理数据。。。')));
                }
              },
              child: Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}
/*
实现原理：
为了验证表单，我们需要使用到步骤1中的 _formKey。
使用 _formKey.currentState() 方法去访问 FormState，而 FormState 是在创建表单 Form 时 Flutter 自动生成的。
FormState 类包含了 validate() 方法。
当 validate() 方法被调用的时候，会遍历运行表单中所有文本框的 validator() 函数。
如果所有 validator() 函数验证都通过，validate() 方法返回 true。
如果有某个文本框验证不通过，就会在那个文本框区域显示错误提示，同时 validate() 方法返回 false。
 */