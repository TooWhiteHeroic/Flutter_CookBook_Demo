import 'package:flutter/material.dart';
import 'HorizontalListView.dart' as hlv;//水平滑动列表
import 'GridListView.dart' as glv;//网格列表
import 'OtherListView.dart' as olv;//不同数据类型的列表
import 'AppBarListView.dart' as alv;//头部带有appbar的列表
import 'BasicListView.dart' as blv;//基础列表
import 'LongListView.dart' as llv;//长列表

void main() => runApp(olv.MyApp(
items: List<olv.ListItem>.generate(1000,//创建项目的 List
(i) =>
i % 6 == 0
? olv.HeadingItem("Heading $i")
: olv.MessageItem("Sender $i", "Message body $i"),
)
)
);

