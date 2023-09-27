import 'package:laboratory/app_widget/app_laboratory_refresh/indicator/indicator.dart';

abstract class Footer extends Indicator {
  Footer({required double triggerOffset})
      : super(
          triggerOffset: triggerOffset,
        );
}
