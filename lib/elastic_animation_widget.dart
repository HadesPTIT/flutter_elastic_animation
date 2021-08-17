import 'package:flutter/material.dart';

enum TweenLevel { SMALL, MEDIUM, LARGE, CUSTOM }

class ElasticAnimationWidget extends StatefulWidget {
  final Widget _child;
  final Duration _duration;
  final bool _repeat;
  final bool _reverse;
  final TweenLevel _tweenLevel;
  final double _begin;
  final double _end;

  ElasticAnimationWidget._(
    this._child,
    this._duration,
    this._repeat,
    this._reverse,
    this._tweenLevel,
    this._begin,
    this._end,
  );

  factory ElasticAnimationWidget({
    @required Widget child,
    Duration duration,
    bool repeat,
    bool reverse,
    TweenLevel tweenLevel,
    double begin,
    double end,
  }) {
    return ElasticAnimationWidget._(
      child,
      duration ?? Duration(milliseconds: 500),
      repeat ?? false,
      reverse ?? false,
      tweenLevel ?? TweenLevel.MEDIUM,
      begin ?? 0.0,
      end ?? 1.0,
    );
  }

  @override
  _ElasticAnimationWidgetState createState() => _ElasticAnimationWidgetState();
}

class _ElasticAnimationWidgetState extends State<ElasticAnimationWidget>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  Tween<double> _tween;

  @override
  void initState() {
    super.initState();
    _tween = _init();
    _controller = AnimationController(duration: widget._duration, vsync: this);
    if (widget._repeat) {
      _controller.repeat(reverse: widget._reverse);
    } else {
      _controller.forward();
    }
  }

  Tween<double> _init() {
    switch (widget._tweenLevel) {
      case TweenLevel.SMALL:
        return Tween<double>(begin: 0.75, end: 1.0);
      case TweenLevel.MEDIUM:
        return Tween<double>(begin: 0.5, end: 1.25);
      case TweenLevel.LARGE:
        return Tween<double>(begin: 0.25, end: 1.5);
      case TweenLevel.CUSTOM:
        return Tween<double>(begin: widget._begin, end: widget._end);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Align(
            child: ScaleTransition(
              scale: _tween.animate(
                CurvedAnimation(
                  parent: _controller,
                  curve: Curves.elasticOut,
                ),
              ),
              child: widget._child,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}
