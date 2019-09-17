import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;//1. 添加 http 包

Future<Post> fetchPost() async {
  final response = await http.get('https://jsonplaceholder.typicode.com/posts/1');//2. 进行网络请求

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON.
    return Post.fromJson(json.decode(response.body));//3. 将返回的响应转换成一个自定义的 Dart 对象
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}

class Post {
  final int userId;
  final int id;
  final String title;
  final String body;

  Post({this.userId, this.id, this.title, this.body});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }
}

void main() => runApp(MyApp(post: fetchPost()));

class MyApp extends StatelessWidget {
  final Future<Post> post;//5. 将数据请求移出 build() 方法
/*
虽然这样会比较方便，但是我们仍然不推荐将 API 调用置于 build() 方法内部。
每当 Flutter 需要改变视图中的一些内容时（这个发生的频率非常高），就会调用 build() 方法。因此，如果你将数据请求置于 build() 内部，就会造成大量的无效调用，同时还会拖慢应用程序的速度。
关于如何在页面初始化的时候，只调用 API，下面有一些更好的选择。
1.传入 StatelessWidget
使用这种策略的话，相当于父组件负责调用数据获取方法，存储结果并传入你的组件中。

2.在 StatefulWidget 状态的生命周期中调用
如果你的组件是有状态的，你可以在 initState() 或者 didChangeDependencies() 方法中调用 fetch 方法。
initState() 只会被调用一次而且再也不会被调用。如果你需要在 InheritedWidget 改变的时候可以重新载入的话，可以把数据调用放在 didChangeDependencies() 方法中

class _MyAppState extends State<MyApp> {
  Future<Post> post;

  @override
  void initState() {
    super.initState();
    post = fetchPost();
  }
 */
  MyApp({Key key, this.post}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Fetch Data Example'),
        ),
        body: Center(
          child: FutureBuilder<Post>(//4. 获取并展示数据
            future: post,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data.title);
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              // By default, show a loading spinner.
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}