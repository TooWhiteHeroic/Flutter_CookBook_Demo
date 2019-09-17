## Widget测试介绍

在 [单元测试介绍](https://flutter.cn/docs/cookbook/testing/unit/introduction) 部分，我们学习了使用 `test` 这个 package 测试 Dart 类的方法。为了测试 widget 类，我们需要使用 [`flutter_test`](https://api.flutter.cn/flutter/flutter_test/flutter_test-library.html) package 提供的额外工具，这些工具是跟 Flutter SDK 一起发布的。

`flutter_test` package 提供了以下工具用于 widget 的测试：

- [`WidgetTester`](https://api.flutter.cn/flutter/flutter_test/WidgetTester-class.html)，使用该工具可在测试环境下建立 widget 并与其交互。
- [`testWidgets()`](https://api.flutter.cn/flutter/flutter_test/testWidgets.html) 函数，此函数会自动为每个测试创建一个 `WidgetTester`，用来代替普通的 `test` 函数。
- [`Finder`](https://api.flutter.cn/flutter/flutter_test/Finder-class.html) 类，允许我们在测试环境下查找 widgets。
- Widget-specific [`Matcher`](https://api.flutter.cn/flutter/package-matcher_matcher/Matcher-class.html) 常量，该常量在测试环境下帮助我们验证 `Finder` 是否定位到一个或多个 widgets。

如果觉得太复杂，别担心！让我们通过下面这些步骤把这些内容整合起来。

### 步骤：

1. 添加一个 `flutter_test` 依赖
2. 创建一个测试用的 widget
3. 创建一个 `testWidgets` 测试方法
4. 使用 `WidgetTester` 建立 widget
5. 使用 `Finder` 查找 widget
6. 使用 `Matcher` 验证 widget 是否正常工作

### 一. 添加一个 `flutter_test` 依赖

我们开始编写测试之前，需要先给 `pubspec.yaml` 文件的 `dev_dependencies` 段添加 `flutter_test` 依赖。如果使用命令行或编译器新建一个 Flutter 项目，那么依赖已经默认添加了。

```
dev_dependencies:
  flutter_test:
    sdk: flutter
```

### 二. 创建一个测试用的 Widget

接下来，我们需要创建一个可以测试的 widget！在此例中，我们创建了一个 widget 显示一个`标题`和`信息`。

```
class MyWidget extends StatelessWidget {
  final String title;
  final String message;

  const MyWidget({
    Key key,
    @required this.title,
    @required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Center(
          child: Text(message),
        ),
      ),
    );
  }
}
```

### 三. 创建一个 `testWidgets` 测试方法

现在我们有了一个可以测试的 widget，可以开始编写第一个测试了！第一步，我们用 `flutter_test` 这个 package 提供的 [`testWidgets()`](https://api.flutter.cn/flutter/flutter_test/testWidgets.html) 函数定义一个测试。 `testWidgets` 函数可以定义一个 Widget 测试并创建一个可以使用的 `WidgetTester`。

我们的测试会验证 `MyWidget` 是否显示给定的标题和信息。

```
void main() {
  // Define a test. The TestWidgets function also provides a WidgetTester
  // to work with. The WidgetTester allows you to build and interact
  // with widgets in the test environment.
  testWidgets('MyWidget has a title and message', (WidgetTester tester) async {
    // Test code goes here.
  });
}
```

### 四. 使用 `WidgetTester` 建立 Widget

下一步，为了在测试环境中建立 `MyWidget`，我们可以使用 `WidgetTester` 提供的 [`pumpWidget()`](https://api.flutter.cn/flutter/flutter_test/WidgetTester/pumpWidget.html) 方法。 `pumpWidget` 方法会建立并渲染我们提供的 widget。

在这个示例中，我们将创建一个显示标题“T”和信息“M”的 `MyWidget` 示例。

```
void main() {
  testWidgets('MyWidget has a title and message', (WidgetTester tester) async {
    // Create the widget by telling the tester to build it.
    await tester.pumpWidget(MyWidget(title: 'T', message: 'M'));
  });
}
```

#### 备注

初次调用 `pumpWidget()` 之后，`WidgetTester` 会提供其他方式来重建相同的 widget。这对使用 `StatefulWidget` 或者动画会非常有用。

例如，如果我们点击调用 `setState()` 的按钮，在测试环境中，Flutter 并不会自动重建你的 widget。我们需要用以下列举的方法来让 Flutter 再一次建立我们的 widget。

- [tester.pump()](https://api.flutter.cn/flutter/flutter_test/TestWidgetsFlutterBinding/pump.html)
  在一段给定时间后重建 widget。
- [tester.pumpAndSettle()](https://api.flutter.cn/flutter/flutter_test/WidgetTester/pumpAndSettle.html)
  在给定期间内不断重复调用 pump 直到完成所有绘制帧。一般需要等到所有动画全部完成。

这些方法在构建周期中保证细粒度控制，这在测试中非常有用。

### 五. 使用 `Finder` 查找 widget

现在让我们在测试环境中建立 widget。我们需要用 `Finder` 通过 widget 树来查找 `标题` 和 `信息` Text widgets，这样可以验证这些 Widgets 是否正确显示。

为了实现这个目的，我们使用 `flutter_test` 这个 package 提供的顶级 [`find()`](https://api.flutter.cn/flutter/flutter_test/find-constant.html) 方法来创建我们的 `Finders`。因为我们要查找的是 `Text` widgets，所以可以使用 [`find.text()`](https://api.flutter.cn/flutter/flutter_test/CommonFinders-class.html) 方法。

关于 `Finder` classes 的更多信息，请参阅 [定位到目标 Widgets](https://flutter.cn/docs/cookbook/testing/widget/finders) 章节。

```
void main() {
  testWidgets('MyWidget has a title and message', (WidgetTester tester) async {
    await tester.pumpWidget(MyWidget(title: 'T', message: 'M'));

    // Create the Finders.
    final titleFinder = find.text('T');
    final messageFinder = find.text('M');
  });
}
```

### 六. 使用 `Matcher` 验证 widget 是否正常工作

最后，让我们来用 `flutter_test` 提供的 `Matcher` 常量验证 `Text` widgets 显示的标题和信息。`Matcher` 类是 `test` 包里的核心部分，它提供一种通用方法来验证给定值是否符合我们的预期。

在这个示例中，我们要确保 Widget 只在屏幕中出现一次。因此，可以使用 [`findsOneWidget`](https://api.flutter.cn/flutter/flutter_test/findsOneWidget-constant.html) `Matcher`。

```
void main() {
  testWidgets('MyWidget has a title and message', (WidgetTester tester) async {
    await tester.pumpWidget(MyWidget(title: 'T', message: 'M'));
    final titleFinder = find.text('T');
    final messageFinder = find.text('M');

    // Use the `findsOneWidget` matcher provided by flutter_test to verify
    // that the Text widgets appear exactly once in the widget tree.
    expect(titleFinder, findsOneWidget);
    expect(messageFinder, findsOneWidget);
  });
}
```

#### 其他的 Matchers

除了 `findsOneWidget`，`flutter_test` 还为常见情况提供了其他的 matchers。

- [findsNothing](https://api.flutter.cn/flutter/flutter_test/findsNothing-constant.html)
  验证没有可被查找的 widgets。
- [findsWidgets](https://api.flutter.cn/flutter/flutter_test/findsWidgets-constant.html)
  验证一个或多个 widgets 被找到。
- [findsNWidgets](https://api.flutter.cn/flutter/flutter_test/findsNWidgets.html)
  验证特定数量的 widgets 被找到。

### 完整样例

```
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // Define a test. The TestWidgets function also provides a WidgetTester
  // to work with. The WidgetTester allows building and interacting
  // with widgets in the test environment.
  testWidgets('MyWidget has a title and message', (WidgetTester tester) async {
    // Create the widget by telling the tester to build it.
    await tester.pumpWidget(MyWidget(title: 'T', message: 'M'));

    // Create the Finders.
    final titleFinder = find.text('T');
    final messageFinder = find.text('M');

    // Use the `findsOneWidget` matcher provided by flutter_test to
    // verify that the Text widgets appear exactly once in the widget tree.
    expect(titleFinder, findsOneWidget);
    expect(messageFinder, findsOneWidget);
  });
}

class MyWidget extends StatelessWidget {
  final String title;
  final String message;

  const MyWidget({
    Key key,
    @required this.title,
    @required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Center(
          child: Text(message),
        ),
      ),
    );
  }
}
```