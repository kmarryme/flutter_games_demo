import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/geometry.dart';

import 'aircraft_static_data.dart';
import 'aircraft_wars_game.dart';
import 'boss.dart';
import 'enemy.dart';

class Bullet extends BulletEmber{
  Bullet(Vector2 heroPos, int bulletNum) : super(heroPos, bulletNum);

}

class BulletEmber<T extends FlameGame> extends SpriteComponent with HasHitboxes, Collidable, HasGameRef<AircraftWarsGame> {
  late final int bulletNum;
  BulletEmber(Vector2 heroPos, this.bulletNum) : super(position: heroPos - Vector2(-17, 45));

  @override
  Future<void>? onLoad() async{
    
    if(bulletNum == 1){
      addHitbox(HitboxRectangle(relation: Vector2(0.3, 0.7)));
      sprite = Sprite(gameRef.images.fromCache('aircraft_wars/bullet0.png'));
    }else if(bulletNum == 2){
      addHitbox(HitboxRectangle(relation: Vector2(0.6, 0.7)));
      sprite = Sprite(gameRef.images.fromCache('aircraft_wars/bullet1.png'));
    }else{
      addHitbox(HitboxRectangle(relation: Vector2(0.9, 0.7)));
      sprite = Sprite(gameRef.images.fromCache('aircraft_wars/bullet2.png'));
    }
    size = Vector2(50, 50);
    return super.onLoad();
  }

  @override
  void update(double dt) {
    position.y -= dt * AircraftConfig.BULLET_SPEED;
    if(position.y + 50 < 0){
      removeFromParent();
    }
    super.update(dt);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    if(other is Enemy || other is Boss){
      double enemyWidth = 50;
      if(other is Enemy){
        enemyWidth = 70;
      }else{
        enemyWidth = 350 * 0.98;
      }
      if(other.position.y + other.height > y && other.position.x <= x + width && other.position.x + enemyWidth >= x){
        removeFromParent();
      }
    }
    super.onCollision(intersectionPoints, other);
  }
}