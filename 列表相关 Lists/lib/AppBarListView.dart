import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

/*
为了方便用户查看列表，你可能希望在用户向下滚动列表时隐藏 app bar，尤其在你的 app bar 特别高，导致它占据了很多竖向空间的时候。
一般情况下，你可以通过给 Scaffold 组件设置一个 appBar 属性来创建一个 app bar。这个 app bar 会始终固定在 Scaffold 组件的 body 上方。
把 app bar 从 Scaffold 组件挪到一个 CustomScrollView 里，可以让你创建一个随着你滑动 CustomScrollView 里列表的同时在屏幕外自动随之滚动的 app bar。
通过 CustomScrollView 来生成一个带有随着用户滑动列表同时会在屏幕外随之滚动的 app bar 的列表。
 */
class MyApp extends StatelessWidget {
  MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final title = 'Floating App Bar';

    return MaterialApp(
      title: title,
      home: Scaffold(
        // No appbar provided to the Scaffold, only a body with a
        // CustomScrollView.
        body: CustomScrollView(//1. 创建一个 CustomScrollView
          slivers: <Widget>[
            SliverAppBar(//2. 使用 SliverAppBar 来添加一个浮动的 app bar
/*
接下来为 CustomScrollView 添加一个 app bar。Flutter 提供开箱即用的 SliverAppBar 组件，与普通的 AppBar 组件非常相似，你可以使用 SliverAppBar 来显示标题、标签、图像等内容。
同时，SliverAppBar 组件也提供一种创建 “浮动” app bar 的能力，当用户向下滚动列表时，app bar 会随之在屏幕外滚动。此外，你可以配置 SliverAppBar 在用户滚动时缩小或展开。
要达到这个效果：
1.先创建一个只显示标题的 app bar
2.将 floating 属性设为 true。这使用户在向上滚动列表时能快速显示 app bar。
3.添加一个 flexibleSpace 组件，这个组件将填充可用的 expandedHeight。
 */
              title: Text(title),
              // Allows the user to reveal the app bar if they begin scrolling
              // back up the list of items.
              floating: true,
              // Display a placeholder widget to visualize the shrinking size.
              flexibleSpace: Placeholder(),
              // Make the initial height of the SliverAppBar larger than normal.
              expandedHeight: 200,
            ),
            // Next, create a SliverList
            SliverList(//3. 使用 SliverList 来添加一个列表
              // Use a delegate to build items as they're scrolled on screen.
              delegate: SliverChildBuilderDelegate(
                // The builder function returns a ListTile with a title that
                // displays the index of the current item.
                    (context, index) => ListTile(title: Text('Item #$index')),
                // Builds 1000 ListTiles
                childCount: 1000,
              ),
            ),
          ],
        ),
      ),
    );
  }
}