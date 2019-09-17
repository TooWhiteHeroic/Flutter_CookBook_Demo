import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';//缓存加载图片
import 'package:transparent_image/transparent_image.dart';//预加载透明图片
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final title = '缓存图片Cached Images';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: title),
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
          children: <Widget>[
            //使用缓存图片，在一些情况下，缓存从网络下载的图片用于离线显示是十分方便的。
            //除了缓存，cached_image_network 包也支持占位符和加载后的图片淡入。
            CachedNetworkImage(imageUrl: 'https://picsum.photos/250?image=9',width: 100,height: 100),
            //添加占位符
            CachedNetworkImage(
              //cached_network_image 包允许任何 Widget 充当占位符。在本例中，加载图片时会展示一个旋转加载的效果（spinner）作为占位符。
                placeholder: (context, url) => CircularProgressIndicator(),
                imageUrl: "https://picsum.photos/250?image=7",
                width: 100,
                height: 100
            ),

            //淡入淡出的图片加载
            //内存加载占位符
            FadeInImage.memoryNetwork(
              /*
              当使用默认的 Image widget 显示图片时，你可能会注意到图片只是在加载完后直接显示到屏幕上。用户可能会觉得这看起来不舒服。
              如果可以先展示占位符，待图片加载完成后淡入显示图片不是很酷么？可以使用 Flutter 自带的 FadeInImage Widget 来实现这个功能。
              FadeInImage 适用于任何类型的图片：内存中的，本地存储的，亦或是网络上的。
               */
                placeholder: kTransparentImage,
                image: "https://picsum.photos/250?image=9",width: 100,height: 100),
            //本地存储资源加载占位符  使用本地资源作为占位符
            FadeInImage.assetNetwork(
                placeholder: 'images/loading.gif',
                image: "https://picsum.photos/250?image=7",
                width: 100,
                height: 100),
            //网络加载图片
            Image.network("https://picsum.photos/250?image=9",width: 100,height: 100,),
            //asset 本地加载图片
            Image.asset("images/loading.gif"),
          ],
        ),
      ),
    );
  }
}
