import 'package:flutter/widgets.dart';
import 'package:laboratory/app_responsive/app_responsive_laboratory.dart';
import 'package:laboratory/app_responsive/utils/responsive_layout_config.dart';

class AppScreenInitLaboratory extends StatelessWidget {
  const AppScreenInitLaboratory({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    AppResponsiveLaboratory.init(
      context,
      const ResponsiveLayoutConfig(),
      false,
    );
    debugPrint(AppResponsiveLaboratory().scaleText.toString());
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(
        textScaleFactor: AppResponsiveLaboratory().scaleText * 1,
      ),
      child: child,
    );
  }
}
