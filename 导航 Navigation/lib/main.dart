import 'package:flutter/material.dart';
import 'ReturnDataNavigation.dart' as rdn ; //从一个页面回传数据
import 'PushDataNavigation.dart' as pdn ; //传递数据到新页面
import 'NavigationNewPage.dart' as nnp ; //导航到一个新页面和返回
import 'NavigationNameRoute.dart' as nnr ; //导航到对应名称的 routes 里
import 'RouteSetArg.dart' as rsa ; //给特定的 route 传参
import 'NavigationAnim.dart' as na ; //跨页面切换的动效 Widget (Hero animations)


void main() => runApp(MyApp());

