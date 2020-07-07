import 'dart:math';
import 'dart:ui';
import 'package:flame/components/animation_component.dart';
import 'package:flame/flame.dart';
import 'package:flutter/cupertino.dart';
import 'package:flame/animation.dart' as anim;

class VirusComponent extends AnimationComponent {
  double componentSize;
  double speed;
  Size screenSize;
  double maxY;
  bool remove = false;
  bool isDead = false;
  Rect virusRect;
  anim.Animation animation;

  VirusComponent(this.animation, this.speed, this.componentSize) : super(componentSize, componentSize, animation);
  
  @override
  void update(double time) {
    this.animation.update(time);
    this.y += time * speed;
    if(y >= maxY)
    {
      remove = true;
      destroy();
    }
  }
  @override
  bool destroy() {
    return remove;
  }
  @override
  void resize(Size size) {
    this.x = randomPosition(size);
    this.y = 0;
    this.maxY = size.height;
  }
  double randomPosition(Size size){
    var positionX = (Random().nextDouble() * size.width);
    return positionX >= size.width - componentSize ? randomPosition(size) : positionX;
  }
  void onTapDown(){
    print("touched!!");
    isDead = true;
    Flame.audio.play('splash.mp3');
  }
}