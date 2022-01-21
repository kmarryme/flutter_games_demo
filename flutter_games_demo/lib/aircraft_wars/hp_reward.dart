import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/geometry.dart';

import 'aircraft_static_data.dart';
import 'aircraft_wars_game.dart';
import 'hero.dart';

typedef HpRewardCallBack = void Function(int bullet);

class HpReward extends BulletUpgradeEmber with HasHitboxes, Collidable{
  final HpRewardCallBack callBack;
  final int hp;
  HpReward(this.hp, this.callBack);
  int xDirection = 1;
  int yDirection = 1;
  static const int speed = 120;
  

  @override
  Future<void> onLoad() {
    //为血量奖励精灵添加一个碰撞框
    addHitbox(HitboxRectangle(relation: Vector2(1, 0.6)));
    return super.onLoad();
  }

  @override
  void update(double dt) {
    reeMovement(dt);
    super.update(dt);
  }

  ///自由运动方法
  void reeMovement(double dt){
    if(y >= screenSize.y - 70){
      x += xDirection * speed * dt;
      y += yDirection * speed * dt;
      if(y > screenSize.y){
        removeFromParent();
      }
    }else{
      x += xDirection * speed * dt;

      final rect = toRect();

      if ((x <= 0 && xDirection == -1) || (rect.right >= gameRef.size.x && xDirection == 1)) {
        xDirection = xDirection * -1;
      }

      y += yDirection * speed * dt;

      if ((y <= 0 && yDirection == -1) || (rect.bottom >= gameRef.size.y && yDirection == 1)) {
        yDirection = yDirection * -1;
      }
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    if(other is Hero){
      if(hp == AircraftConfig.HERO_LIVES){
        callBack(AircraftConfig.HERO_LIVES);
      }else{
        callBack(hp + 1);
      }
      removeFromParent();
    }
    super.onCollision(intersectionPoints, other);
  }
}

class BulletUpgradeEmber<T extends FlameGame> extends SpriteComponent with HasGameRef<AircraftWarsGame> {
  late Vector2 screenSize;
  final Random _random = Random();

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    double pos = _random.nextDouble() * screenSize.x;
    position.x = pos;
    position.y = -50;
    
    sprite = Sprite(gameRef.images.fromCache('aircraft_wars/blood_upgrade.png'));
    size = Vector2(70, 70);
  }

  @override
  void onGameResize(Vector2 gameSize) {
    screenSize = gameSize;
    super.onGameResize(gameSize);
  }

}