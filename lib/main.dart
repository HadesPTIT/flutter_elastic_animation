import 'package:flutter/material.dart';
import 'package:flutter_elastic_animation/elastic_animation_widget.dart';

void main() {
  runApp(
    MaterialApp(
      home: ElasticAnimationWidget(
        child: SizedBox(
          height: 100,
          width: 100,
          child: CircleAvatar(
            backgroundImage: AssetImage('images/im_disk.png'),
            radius: 50,
          ),
        ),
        duration: Duration(milliseconds: 1000),
        tweenLevel: TweenLevel.MEDIUM,
        repeat: true,
        reverse: true,
      ),
    ),
  );
}
