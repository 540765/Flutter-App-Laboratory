import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:laboratory/app_init/app_life/app_life_laboratory.dart';

void main() {
  group("[AppLife Test]", () {
    testWidgets("app生命周期监听：paused", (WidgetTester tester) async {
      ///待测试widget
      const widget = AppLifeLaboratory(
        child: Text('paused'),
      );

      // 在测试中构建你的应用程序界面
      await tester.pumpWidget(
        const MaterialApp(
          home: Directionality(
            textDirection: TextDirection.ltr,
            child: widget,
          ),
        ),
      );
      // 等待一段时间以确保后台回调被执行
      TestWidgetsFlutterBinding.ensureInitialized();

      // 模拟应用程序进入后台
      TestWidgetsFlutterBinding.ensureInitialized().scheduleFrameCallback((_) {
        // 通过调用 `handleAppLifecycleStateChanged` 方法模拟应用程序进入后台
        WidgetsBinding.instance
            .handleAppLifecycleStateChanged(AppLifecycleState.paused);
      });
      await tester.pump(const Duration(seconds: 1));
      AppLifeLaboratoryState appLifeLaboratoryState =
          tester.state<AppLifeLaboratoryState>(find.byWidget(widget));
      // 断言应用程序进入后台后，widget的状态是否正确
      expect(find.text('paused'), findsOneWidget);
      expect(appLifeLaboratoryState.stateName, 'pause');
    });
  });
}
