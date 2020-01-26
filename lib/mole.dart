


import 'package:flutter/material.dart';
import 'package:flutter_split_ball/mole_particle.dart';
import 'package:simple_animations/simple_animations.dart';

class Mole extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createStatew
    return MoleState();
  }

}

class MoleState extends State<Mole> {

  final List<MoleParticle> particles = [];
  bool _moleIsVisible = false;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: 100,
      height: 100,
      child: _buildMole(),
    );
  }

  Rendering _buildMole(){
    return Rendering(
      onTick: (time)=>_manageParticleLiftCycle(time),
      builder: (ctx,time){
        return Stack(
          //子widget 超出父widget 的处理方式
          overflow: Overflow.visible,
          children: <Widget>[
            if(_moleIsVisible)
              GestureDetector(onTap: ()=>_hitMole,child: _mole(),),
            //根据time构建不同状态的 ball
            ...particles.map((it)=>it.buildWidget(time))
          ],
        );
      },
    );
  }

  Widget _mole(){
    return Container(
      decoration: BoxDecoration(
        color: Colors.brown,borderRadius: BorderRadius.circular(50)
      ),
    );
  }
  _hitMole(Duration time){
    _setMoleVisible(false);
    Iterable.generate(50).forEach((i)=>particles.add(MoleParticle(time)));
  }

  _manageParticleLiftCycle(Duration time){
    //移除执行完毕的小球
    particles.removeWhere((particle){
      return particle.progress.progress(time) == 1;
    });
  }


  _setMoleVisible(bool visible){
    _moleIsVisible = visible;
  }

}




















