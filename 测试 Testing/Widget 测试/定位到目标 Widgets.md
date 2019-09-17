## 定位到目标Widgets

在测试环境下，为了定位 Widgets，我们需要用到 `Finder` 类。我们可以编写自己的 `finder`classes，不过通常使用 [`flutter_test`](https://api.flutter.cn/flutter/flutter_test/flutter_test-library.html) 包提供的工具来定位 Widgets 更加方便。

下面，我们来看看 `flutter_test` 包提供的 [`find`](https://api.flutter.cn/flutter/flutter_test/find-constant.html) 常量并演示如何使用其所提供的 `Finders`。如需查看完整的 finders 的列表，请参阅 [`CommonFinders` 文档](https://api.flutter.cn/flutter/flutter_driver/CommonFinders-class.html)。

如果你还不熟悉 Widget 测试和 Finder 类使用方法，请参阅 [在 Flutter 里做集成测试](https://flutter.cn/docs/cookbook/testing/integration)。

本教程包含以下步骤：

1. 查找 `Text` Widget
2. 使用具体 `Key` 查找 Widget
3. 查找具体的 Widget 实例

### 一. 查找 Text Widget

在测试中，我们经常需要查找含有特定文本的 Widget。这正是 `find.text()` 的用途。它会创建一个 `Finder` 来寻找显示特定文本 `String` 的 Widget。

```
testWidgets('finds a Text widget', (WidgetTester tester) async {
  // Build an app with a Text widget that displays the letter 'H'.
  await tester.pumpWidget(MaterialApp(
    home: Scaffold(
      body: Text('H'),
    ),
  ));

  // Find a widget that displays the letter 'H'.
  expect(find.text('H'), findsOneWidget);
});
```

### 二. 使用具体 `Key` 查找 Widget

有时，我们可能想要通过已经提供给 Widget 的 Key 来查找 Widget。这样在显示多个相同 Widget实体时会很方便。比如，我们有一个 `ListView` 列表，它显示了数个含有相同文本的 `Text` Widgets。

在这种情况下，我们可以为列表中的每一个 Widget 赋予一个 `Key`。这样我们就可以唯一识别特定的 Widget，在测试环境中更容易查找 Widget。

```
testWidgets('finds a widget using a Key', (WidgetTester tester) async {
  // Define the test key.
  final testKey = Key('K');

  // Build a MaterialApp with the testKey.
  await tester.pumpWidget(MaterialApp(key: testKey, home: Container()));

  // Find the MaterialApp widget using the testKey.
  expect(find.byKey(testKey), findsOneWidget);
});
```

### 三. 查找具体的 Widget 实例

最后，我们有时会需要查找 Widget 的具体实例。比如，当创建含有 `child` 属性的 Widget 并需要确保渲染 `child` Widget。

```
testWidgets('finds a specific instance', (WidgetTester tester) async {
  final childWidget = Padding(padding: EdgeInsets.zero);

  // Provide the childWidget to the Container.
  await tester.pumpWidget(Container(child: childWidget));

  // Search for the childWidget in the tree and verify it exists.
  expect(find.byWidget(childWidget), findsOneWidget);
});
```

### 总结

在测试环境下，`flutter_test` 包提供的 `find` 常量给了我们多种查找 Widget 的方法。本篇列举了三种方法，另外还有一些其他用途的方法。

如果上述示例不适用于一些特殊情况，请到 [`CommonFinders` 文档](https://api.flutter.cn/flutter/flutter_driver/CommonFinders-class.html) 中查看更多用法。

### 完整样例

```
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('finds a Text widget', (WidgetTester tester) async {
    // Build an App with a Text widget that displays the letter 'H'.
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Text('H'),
      ),
    ));

    // Find a widget that displays the letter 'H'.
    expect(find.text('H'), findsOneWidget);
  });

  testWidgets('finds a widget using a Key', (WidgetTester tester) async {
    // Define the test key.
    final testKey = Key('K');

    // Build a MaterialApp with the testKey.
    await tester.pumpWidget(MaterialApp(key: testKey, home: Container()));

    // Find the MaterialApp widget using the testKey.
    expect(find.byKey(testKey), findsOneWidget);
  });

  testWidgets('finds a specific instance', (WidgetTester tester) async {
    final childWidget = Padding(padding: EdgeInsets.zero);

    // Provide the childWidget to the Container.
    await tester.pumpWidget(Container(child: childWidget));

    // Search for the childWidget in the tree and verify it exists.
    expect(find.byWidget(childWidget), findsOneWidget);
  });
}
```