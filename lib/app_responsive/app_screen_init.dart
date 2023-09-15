import 'dart:async';
import 'dart:collection';
import 'package:flutter/widgets.dart';
import 'package:laboratory/app_responsive/export_app_responsive.dart';

class AppScreenInit extends StatefulWidget {
  const AppScreenInit({
    super.key,
    required this.builder,
    required this.responsiveLayoutConfig,
    this.responsiveWidgets,
    this.ensureScreenSize,
  });
  ///build方法
  final Widget Function(BuildContext context) builder;

  ///屏幕配置信息
  final ResponsiveLayoutConfig responsiveLayoutConfig;

  ///可以传入需要构建的widhets
  final Iterable<String>? responsiveWidgets;

  ///窗口是否已经初始化，默认可以不传
  final bool? ensureScreenSize;

  @override
  State<StatefulWidget> createState() => _AppScreenInitState();
}

class _AppScreenInitState extends State<AppScreenInit>
    with WidgetsBindingObserver {
  final _canMarkedToBuild = HashSet<String>();
  MediaQueryData? _mediaQueryData;
  final _binding = WidgetsBinding.instance;
  final _screenSizeCompleter = Completer<void>();

  ///方法-确保窗口已经初始化
  Future<void> _validateSize() async {
    if (widget.ensureScreenSize ?? false) {
      return AppResponsive.ensureScreenSize();
    }
  }

  ///获取新的屏幕信息
  MediaQueryData? _newData() {
    MediaQueryData? mq = MediaQuery.maybeOf(context);
    mq ??= MediaQueryData.fromView(View.of(context));
    return mq;
  }

  ///重新验证MediaQueryData并更新小部件树
  void _revalidate([void Function()? callback]) {
    debugPrint('revalidate 更新widget树'); 
    final oldData = _mediaQueryData;
    final newData = _newData();

    if (newData == null) return;

    if (oldData == null) {
      setState(() {
        _mediaQueryData = newData;
        _updateTree(context as Element);
        callback?.call();
      });
    }
  }

  ///刷新需要更新的小部件
  void _updateTree(Element el) {
    _markNeedsBuildIfAllowed(el);
    el.visitChildren(_updateTree);
  }

  ///标记需要刷新的部件
  void _markNeedsBuildIfAllowed(Element el) {
    final widgetName = el.widget.runtimeType.toString();
    final allowed = widget is SU ||
        _canMarkedToBuild.contains(widgetName) ||
        !(widgetName.startsWith('_'));
    if (allowed) el.markNeedsBuild();
  }

  @override
  void initState() {
    if (widget.responsiveWidgets != null) {
      _canMarkedToBuild.addAll(widget.responsiveWidgets!);
    }

    _validateSize().then(_screenSizeCompleter.complete);
    super.initState();
    _binding.addObserver(this);
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    _revalidate();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _revalidate();
  }

  @override
  Widget build(BuildContext context) {
    final mq = _mediaQueryData;
    if (mq == null) return const SizedBox.shrink();
    return FutureBuilder<void>(
      future: _screenSizeCompleter.future,
      builder: (c, snapshot) {
        AppResponsive.configure(
          mq,
          widget.responsiveLayoutConfig,
          true,
        );
        if (snapshot.connectionState == ConnectionState.done) {
          return widget.builder(context);
        }
        return const SizedBox.shrink();
      },
    );
  }
}
