## 把报错信息通过服务上传

开发者总是试图创造没有 bug 的应用，但是 bug 还是会时不时地出现。这些 bug 会给用户带来糟糕的体验，所以获知 bug 发生的位置以及出现的频率就显得极为关键了。这样，你就可以根据 bug 的影响程度优先修复它们。

如何确定用户遇到 bug 的频率呢？解决方案是：当异常发生时，生成一份日志，日志中包含发生的异常及相关的堆栈信息。随后，可以将日志发送到异常监控报警平台，比如 Sentry、Fabric 或者 Rollbar。

异常监控报警平台会将上报的崩溃日志异常信息聚合并分组归类，这样就可以知道应用程序出现异常的频率并定位异常发生位置。

这个章节中，你可以通过以下步骤学习如何把异常信息上报给异常监控报警平台 [Sentry](https://sentry.io/welcome/)：

1. 从 Sentry 平台获取 DSN
2. 导入 Sentry 包
3. 创建 `SentryClient`
4. 创建上报异常的函数
5. 捕获并上报 Dart 异常
6. 捕获并上报 Flutter 异常

## 1. 从 Sentry 平台获取 DSN

在向 Sentry 上报异常信息前，需要在 Sentry.io 上获取应用的唯一身份标识 DSN。

根据以下步骤，获取 DSN：

1. [创建 Sentry 账户](https://sentry.io/signup/)
2. 登录账户
3. 在 Sentry 控制台创建一个新的应用
4. 复制 DSN

## 2. 导入 Sentry 包

导入 [`sentry`](https://pub.flutter-io.cn/packages/sentry) 包到应用中，sentry 包会让异常上报更为方便。

```
dependencies:
  sentry: <latest_version>
```

## 3. 创建 `SentryClient`

创建 `SentryClient` 用于将异常日志上报给 sentry 平台。

```
final SentryClient _sentry = SentryClient(dsn: "App DSN goes Here");
```

## 4. 创建上报异常的函数

Sentry 的相关内容都设置好后，就可以开始上报异常了。通常在开发环境下可能不需要把异常上报到 Sentry，所以可以先创建一个函数来区分当前环境是开发环境还是生产环境。

```
bool get isInDebugMode {
  // Assume you're in production mode.
  bool inDebugMode = false;

  // Assert expressions are only evaluated during development. They are ignored
  // in production. Therefore, this code only sets `inDebugMode` to true
  // in a development environment.
  assert(inDebugMode = true);

  return inDebugMode;
}
```

然后，用这个函数结合 `SentryClient` 就可以实现生产环境的异常上报了。

```
Future<void> _reportError(dynamic error, dynamic stackTrace) async {
  // Print the exception to the console.
  print('Caught error: $error');
  if (isInDebugMode) {
    // Print the full stacktrace in debug mode.
    print(stackTrace);
    return;
  } else {
    // Send the Exception and Stacktrace to Sentry in Production mode.
    _sentry.captureException(
      exception: error,
      stackTrace: stackTrace,
    );
  }
}
```

## 5. 捕获并上报 Dart 异常

现在已经有了一个能够根据环境上报异常的函数了，接着还需要知道如何去捕获 Dart 异常。

为了实现这一目的，可以把应用运行在一个自定义的 [`Zone`](https://api.flutter.cn/flutter/dart-async/Zone-class.html) 里面。Zones 为代码建立执行上下文环境。在这个上下文环境中，所有发生的异常在抛出 `onError` 时都能够很容易地被捕获到。

在下面的例子中，将会把应用运行在一个新的 `Zone` 里面，通过 `onError()` 回调捕获所有的异常。

```
runZoned<Future<void>>(() async {
  runApp(CrashyApp());
}, onError: (error, stackTrace) {
  // Whenever an error occurs, call the `_reportError` function. This sends
  // Dart errors to the dev console or Sentry depending on the environment.
  _reportError(error, stackTrace);
});
```

## 6. 捕获并上报 Flutter 异常

除了 Dart 异常，Flutter 也能抛出其他的异常，比如调用原生代码发生的平台异常。这种类型的异常也同样是需要上报的。

为了捕获 Flutter 异常，需要重写 [`FlutterError.onError`](https://api.flutter.cn/flutter/foundation/FlutterError/onError.html) 属性。在开发环境下，可以将异常格式化输出到控制台。在生产环境下，可以把异常传递给上个步骤中的 `onError` 回调。

```
// This captures errors reported by the Flutter framework.
FlutterError.onError = (FlutterErrorDetails details) {
  if (isInDebugMode) {
    // In development mode, simply print to console.
    FlutterError.dumpErrorToConsole(details);
  } else {
    // In production mode, report to the application zone to report to
    // Sentry.
    Zone.current.handleUncaughtError(details.exception, details.stack);
  }
};
```

## 完整样例

查看 [Crashy](https://github.com/flutter/crashy) 示例应用，体验完整流程。