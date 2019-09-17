import 'package:flutter/material.dart';
import 'MySelfTheme.dart' as theme;//全局主题和局部主题
import 'PackageFonts.dart' as fonts;//依赖包字体使用
import 'TabPage.dart' as tabs;//tabs使用
import 'MySelfFonts.dart' as mfonts;//自定义资源字体使用
import 'DrawerPage.dart' as drawer;//抽屉Drawer使用
import 'SnackbarsPage.dart' as snackbar;//snackbar使用
import 'OrientationPage.dart' as orientation;//根据屏幕方向更新界面


void main() => runApp(orientation.MyApp());

