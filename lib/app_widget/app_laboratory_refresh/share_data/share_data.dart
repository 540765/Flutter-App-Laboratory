import 'package:flutter/widgets.dart';
import 'package:laboratory/app_widget/app_laboratory_refresh/notifier/footer_notifier/footer_notifier.dart';
import 'package:laboratory/app_widget/app_laboratory_refresh/notifier/header_notifier/header_notifier.dart';

///需要共享出去的数据
class LaboratoryRefreshData {
  /// Header status data and responsive
  final HeaderNotifier headerNotifier;

  /// Footer status data and responsive
  final FooterNotifier footerNotifier;

  ///用户正在滑动
  final ValueNotifier<bool> userOffsetNotifier;
  const LaboratoryRefreshData({
    required this.userOffsetNotifier,
    required this.headerNotifier,
    required this.footerNotifier,
  });
}

///实现共享widget
class InheritedLaboratoryRefresh extends InheritedWidget {
  const InheritedLaboratoryRefresh({
    Key? key,
    required this.data,
    required Widget child,
  }) : super(
          key: key,
          child: child,
        );

  final LaboratoryRefreshData data;

  static LaboratoryRefreshData of(BuildContext context) {
    final InheritedLaboratoryRefresh? result = context
        .dependOnInheritedWidgetOfExactType<InheritedLaboratoryRefresh>();
    assert(result != null, 'No LaboratoryRefresh found in context');
    return result!.data;
  }

  @override
  bool updateShouldNotify(InheritedLaboratoryRefresh oldWidget) {
    return data != oldWidget.data;
  }
}
