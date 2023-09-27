import 'package:flutter/material.dart';
import 'package:laboratory/app_widget/app_laboratory_refresh/indicator/indicator_state.dart';

class ClassicIndicator extends StatefulWidget {
  /// Indicator properties and state.
  final IndicatorState state;

  const ClassicIndicator({
    Key? key,
    required this.state,
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
    final offset =
        widget.state.offset > 0 ? widget.state.offset : -(widget.state.offset);
    return SizedBox(
      width: double.infinity,
      height: offset,
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
    final offset =
        widget.state.offset < 0 ? -(widget.state.offset) : widget.state.offset;
    return Stack(
      clipBehavior: Clip.hardEdge,
      children: [
        Positioned(
          left: 0,
          right: 0,
          // top: offset/2,
          bottom: offset / 2,
          height: widget.state.offset < offset ? offset : null,
          child: Center(
            child: _buildVerticalBody(),
          ),
        ),
      ],
    );
  }

  ///纵向滚动渲染的body，主要信息，上面为定位信息
  Widget _buildVerticalBody() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 1.0,
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
                const Text(
                  '下拉刷新',
                  style: TextStyle(
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
