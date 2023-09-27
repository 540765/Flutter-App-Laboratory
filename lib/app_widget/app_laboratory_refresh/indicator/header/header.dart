import 'package:laboratory/app_widget/app_laboratory_refresh/indicator/indicator.dart';

abstract class Header extends Indicator {
  Header({required double triggerOffset})
      : super(
          triggerOffset: triggerOffset,
        );
}
