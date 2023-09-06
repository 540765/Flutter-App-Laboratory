import 'package:flutter/material.dart';
import 'package:laboratory/app_init/app_life/app_life_laboratory.dart';
import 'package:laboratory/app_init/report_error/report_error_laboratory.dart';
import 'package:laboratory/app_router/router/router.dart';

class AppInitLaboratory {
  static void init() {
    ReportErrorLaboratory.run(
      () {
        runApp(
          AppLifeLaboratory(
            child: MaterialApp.router(
              /// 网格
              debugShowMaterialGrid: false,
              /// Debug标志
              debugShowCheckedModeBanner: false,
              /// 打开性能监控，覆盖在屏幕最上面
              showPerformanceOverlay: false,
              /// 语义视图（无障碍）
              showSemanticsDebugger: false,
              title: 'Laboratory',
              theme: ThemeData(
                primarySwatch: Colors.blue,
                useMaterial3: true,
              ),
              routerConfig: router,
            ),
          ),
        );
      },
    );
  }
}
