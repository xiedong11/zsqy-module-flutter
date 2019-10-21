import 'dart:async';

import 'package:flutter/material.dart';

class MarqueeText extends StatefulWidget {
  Widget child; // 轮播的内容
  Duration duration; // 轮播时间
  double stepOffset; // 偏移量
  double paddingLeft; // 内容之间的间距

  MarqueeText({this.child, this.paddingLeft, this.duration, this.stepOffset});

  _MarqueeTextState createState() => _MarqueeTextState();
}

class _MarqueeTextState extends State<MarqueeText> {
  ScrollController _controller; // 执行动画的controller
  Timer _timer; // 定时器timer
  double _offset = 0.0; // 执行动画的偏移量

  @override
  void initState() {
    super.initState();

    _controller = ScrollController(initialScrollOffset: _offset);
    _timer = Timer.periodic(widget.duration, (timer) {
      double newOffset = _controller.offset + widget.stepOffset;
      if (newOffset != _offset) {
        _offset = newOffset;
        _controller.animateTo(_offset,
            duration: widget.duration, curve: Curves.linear); // 线性曲线动画
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _controller.dispose();
    super.dispose();
  }

  Widget _child() {
    return new Row(children: _children());
  }

  // 子视图
  List<Widget> _children() {
    List<Widget> items = [];
    for (var i = 0; i <= 2; i++) {
      Container item = new Container(
        margin: new EdgeInsets.only(right: i != 0 ? 0.0 : widget.paddingLeft),
        child: i != 0 ? null : widget.child,
      );
      items.add(item);
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal, // 横向滚动
      controller: _controller, // 滚动的controller
      itemBuilder: (context, index) {
        return _child();
      },
    );
  }
}
