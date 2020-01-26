


import 'dart:math';

import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

class MoleParticle{
  Animatable tween;
  AnimationProgress progress;

  MoleParticle(Duration time){
    final random = Random();
    final x = (100 + 200) * random.nextDouble() * (random.nextBool() ? 1 : -1); //方向
    final y = (100 + 200) * random.nextDouble() * (random.nextBool() ? 1 : -1);

    //横竖运动方向和缩小
    tween = MultiTrackTween([
      Track("x").add(Duration(seconds: 1), Tween(begin: 0.0,end: x)),
      Track("y").add(Duration(seconds: 1), Tween(begin: 0.0,end: y)),
      Track("scale").add(Duration(seconds: 1), Tween(begin: 1.0,end: 0.0))
    ]);

    progress = AnimationProgress(startTime: time,duration: Duration(milliseconds: 600));



  }

  buildWidget(Duration time){
    //progress.progress(time) 用于跟踪动画进度
    //根据执行时间返回一个 map<string,_TweenData> 给animation
    //根据string  取到对应的 _TweenData(动画进度所对应的动画值)
    final animation = tween.transform(progress.progress(time));
    return Positioned(
      left: animation["x"],
      top: animation['y'],
      child: Transform.scale(scale: animation['scale']
        ,child: Container(width: 100,height: 100,decoration:
            BoxDecoration(
              color: Colors.brown,borderRadius: BorderRadius.circular(50)
            ),),),
    );
  }



}















