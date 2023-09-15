import 'package:laboratory/app_responsive/utils/app_responsive_builder.dart';

///屏幕类型
enum DeviceScreenType { mobile, tablet, desktop, watch }

///
typedef FontSizeResolver = double Function(num fontSize, AppResponsiveBuilder instance);

