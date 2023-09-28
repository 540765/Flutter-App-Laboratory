
import 'package:flutter/material.dart';
import 'package:laboratory/app_widget/app_laboratory_refresh/indicator/indicator_state.dart';
import 'package:laboratory/app_widget/app_laboratory_refresh/share_data/share_enum.dart';

class ClassicIndicator extends StatefulWidget {
  /// Indicator properties and state.
  final IndicatorState state;

  ///指示器的位置
  final MainAxisAlignment mainAxisAlignment;

  const ClassicIndicator({
    Key? key,
    required this.state,
    required this.mainAxisAlignment,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ClassicIndicatorState();
}

class _ClassicIndicatorState extends State<ClassicIndicator>
    with TickerProviderStateMixin<ClassicIndicator> {
  /// Icon [AnimatedSwitcher] 的key，会频繁改变.
  late GlobalKey _iconAnimatedSwitcherKey;

  /// 最近的刷新时间.
  late DateTime _updateTime;

  /// Icon animation controller.
  late AnimationController _iconAnimationController;

  @override
  void initState() {
    super.initState();

    ///初始化动画
    _iconAnimatedSwitcherKey = GlobalKey();
    _updateTime = DateTime.now();
    _iconAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _iconAnimationController.addListener(() => setState(() {}));
  }

  @override
  void didUpdateWidget(covariant ClassicIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    // 更新时间
    _updateTime = DateTime.now();
  }

  @override
  void dispose() {
    _iconAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.state.axis == Axis.vertical
          ? double.infinity
          : widget.state.offset,
      height: widget.state.axis == Axis.horizontal
          ? double.infinity
          : widget.state.offset,
      child: widget.state.axis == Axis.vertical
          ? _buildVertical()
          : _buildHorizontal(),
    );
  }

  ///渲染图标
  Widget _buildIcon() {
    Widget icon;
    final iconTheme = Theme.of(context).iconTheme;
    ValueKey iconKey;
    iconKey = const ValueKey('file');
    icon = const SizedBox(
      child: Icon(
        Icons.inbox_outlined,
      ),
    );
    return AnimatedSwitcher(
      key: _iconAnimatedSwitcherKey,
      duration: const Duration(milliseconds: 200),
      reverseDuration: const Duration(milliseconds: 200),
      transitionBuilder: (child, animation) {
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: animation,
            child: child,
          ),
        );
      },
      child: IconTheme(
        key: iconKey,
        data: iconTheme,
        child: icon,
      ),
    );
  }

  ///根据状态改变文字
  String get _currentText {
    switch (widget.state.mode) {
      case IndicatorMode.inactive:
        return '下拉加载更多';
      case IndicatorMode.drag:
        return 'widget.dragText';
      case IndicatorMode.armed:
        return 'widget.armedText';
      case IndicatorMode.ready:
        return 'widget.readyText';
      case IndicatorMode.processing:
        return 'widget.processingText';
      case IndicatorMode.processed:
      default:
        return '没有更多数据了';
    }
  }

  /// Message text.
  String get _messageText {
    String fillChar = _updateTime.minute < 10 ? "0" : "";
    return "${_updateTime.hour}:$fillChar${_updateTime.minute}";
  }

  ///横向滚动渲染
  Widget _buildHorizontal() {
    return Container();
  }

  ///纵向滚动渲染
  Widget _buildVertical() {
    final children = <Widget>[];
    if (widget.mainAxisAlignment == MainAxisAlignment.end) {
      children.add(
        Positioned(
          left: 0,
          right: 0,
          top: widget.mainAxisAlignment == MainAxisAlignment.end ? 0 : null,
          child: Center(
            child: _buildVerticalBody(),
          ),
        ),
      );
    }
    if (widget.mainAxisAlignment == MainAxisAlignment.start) {
      children.add(
        Positioned(
          left: 0,
          right: 0,
          bottom:
              widget.mainAxisAlignment == MainAxisAlignment.start ? 0 : null,
          child: Center(
            child: _buildVerticalBody(),
          ),
        ),
      );
    }
    return Stack(
      clipBehavior: Clip.hardEdge,
      children: children,
    );
  }

  ///纵向滚动渲染的body，主要信息，上面为定位信息
  Widget _buildVerticalBody() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color.fromARGB(31, 255, 1, 1),
          width: 5,
        ),
      ),
      alignment: Alignment.center,
      height: widget.state.indicator.triggerOffset,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            child: _buildIcon(),
          ),
          Container(
            alignment: Alignment.center,
            child: Column(
              children: [
                Text(
                  _currentText,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    _messageText,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
