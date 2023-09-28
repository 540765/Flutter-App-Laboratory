enum IndicatorMode {
  ///默认状态，任务完成后返回此状态
  inactive,

  ///滚动了但是没有达到滚动阀值
  drag,

  ///滚动并且达到了滚动阀值但是用户还没放开手指
  armed,

  ///用户放开了手指，即将刷新
  ready,

  ///刷新任务进行中
  processing,

  ///刷新任务已结束
  processed,

  ///整个过程已经完成
  ///此状态稍后返回inactive
  done,
}

/// 指定指示器的位置
enum IndicatorPosition {
  ///顶部
  above,

  ///底部
  behind,
}

/// 任务完成后返回的状态。
enum IndicatorResult {
  /// 在任务未触发之前没有状态。
  none,

  /// 任务成功。
  success,

  /// 任务失败
  fail,

  /// 没有更多了
  noMore,
}
