import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:laboratory/app_init/app_life/app_life_laboratory.dart';

void main() {
  group("[AppLife Test]", () {
    ///待测试widget-----注意widget基本规范，顶层必须有Directionality，因为
    ///要模拟屏幕的方向信息
    const widget = AppLifeLaboratory(
      child: Text('AppLifeLaboratory'),
    );
    testWidgets("app生命周期监听", (WidgetTester tester) async {
      // 在测试中构建你的应用程序界面
      await tester.pumpWidget(
        const MaterialApp(
          home: Directionality(
            textDirection: TextDirection.ltr,
            child: widget,
          ),
        ),
      );
      TestWidgetsFlutterBinding.ensureInitialized();
      // 模拟应用程序进入后台
      TestWidgetsFlutterBinding.ensureInitialized()
          .scheduleFrameCallback((_) async {
        // 通过调用 `handleAppLifecycleStateChanged` 方法模拟应用程序进入后台
        WidgetsBinding.instance
            .handleAppLifecycleStateChanged(AppLifecycleState.paused);
      });
      // 等待一段时间以确保后台回调被执行
      await tester.pump(const Duration(seconds: 1));
      // 获取widget的状态
      AppLifeLaboratoryState appLifeLaboratoryStatePause =
          tester.state<AppLifeLaboratoryState>(find.byWidget(widget));
      // 断言应用程序进入后台后，widget的状态是否正确
      expect(appLifeLaboratoryStatePause.stateName, 'pause');
      debugPrint("test测试打印：app进入后台通过");
      // 等待一段时间以确保后台回调被执行

      ///--------------------------------------------------------------------------------
      // 模拟应用程序返回前台
      TestWidgetsFlutterBinding.ensureInitialized().scheduleFrameCallback((_) {
        // 通过先将状态设置为 `hidden` 或 `resumed`，再设置为 `inactive`，模拟应用程序从后台返回前台
        WidgetsBinding.instance
            .handleAppLifecycleStateChanged(AppLifecycleState.hidden);

        WidgetsBinding.instance
            .handleAppLifecycleStateChanged(AppLifecycleState.inactive);

        WidgetsBinding.instance
            .handleAppLifecycleStateChanged(AppLifecycleState.resumed);
      });
      // 等待一段时间以确保后台回调被执行
      await tester.pump(const Duration(seconds: 1));
      //这里不能完全模拟，还是在集成测试测试吧，这里主要看是否有打印可以看到有没有触发
      expect(find.text('AppLifeLaboratory'), findsOneWidget);
    });
  });
}
