import 'package:flutter/material.dart';

class Page1 extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: RaisedButton(
          child: Text('Go!'),
          onPressed: () {
            Navigator.of(context).push(_createRoute());
          },
        ),
      ),
    );
  }
}

Route _createRoute() {

/*
PageRouteBuilder 有两个回调，第一个是创建这个路由的内容（pageBuilder），另一个则是创建一个路由的转换器（transitionsBuilder）.
transitionsBuilder 的 child 参数是通过 pageBuilder 方法来返回一个 transitionsBuilder widget。
这个 pageBuilder 方法仅会在第一次构建路由的时候被调用。框架能够自动避免做额外的工作，因为整个过渡期间 child 保存了同一个实例
 */
//1. 搭建一个 PageRouteBuilder
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => Page2(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(0.0, 1.0);
      var end = Offset.zero;
      var curve = Curves.ease;
      //2. 创建一个 Tween
      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));//4. 使用 CurveTween
      /*
      Flutter 提供了一系列缓和曲线，可以调整一段时间内的动画速率。 Curves 类提供了一个提前定义的用法相似的 curves。例如，Curves.easeOut 将会让动画开始很快结束很慢。
       */
      //5. 结合两个 Tween 使用chain  它们通过把这个 tween 传递给 animation.drive() 来创建一个新的 Animation<Offset>，然后你就能把它传给 SlideTransition widget
/*
为了使新页面从底部动画出来，它应该从 Offset(0,1) 到 Offset(0, 0) 进行动画。（通常我们会使用 Offset.zero 构造器。）
在这个情况下，对于 FractionalTranslation widget 来说偏移量是一个 2D 矢量值。将 dy 参数设为 1，这代表在竖直方向上切换整个页面的高度。
transitionsBuilder 的回调有一个 animation 参数。它其实是一个 Animation<double>，提供 0 到 1 的值。使用 Tween 来将 Animation 转为 Animation。
 */
//3. 使用 继承至AnimatedWidget的widget 它们能够在动画的值发生改变时自动重建自己
      return SlideTransition(
        //SlideTransition 拿到一个 Animation<Offset> 并在动画改变时使用 FractionalTranslation widget 转换其子级。
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

class Page2 extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text('Page 2'),
      ),
    );
  }
}