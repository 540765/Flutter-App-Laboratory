// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'unit_test/main_unit_test.dart' as unit_test;
import 'widget_test/main_widget_test.dart' as widget_test;

void main() {
  ///这里可以运行所有的测试套件---不怎么写了
  ///要分开测试到每个目录的文件下都会有一个整合当前模块的测试套件
  group('全局main测试套件', () {
    unit_test.main();
    widget_test.main();
  });
}
