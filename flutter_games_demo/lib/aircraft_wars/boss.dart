
import 'dart:math';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/geometry.dart';

import 'aircraft_static_data.dart';
import 'aircraft_wars_game.dart';
import 'bullet.dart';
import 'enemy_data.dart';
import 'main_menu.dart';
import 'player_data.dart';

class Boss extends BulletUpgradeEmber with HasHitboxes, Collidable{
  final EnemyData boss;
  final PlayerData playerData;
  Boss(this.boss, this.playerData) : super(boss);
  int xDirection = 1;
  int yDirection = 1;

  
  

  @override
  Future<void> onLoad() {
    lives = AircraftConfig.ENEMY_LIVES[boss.name]??0;
    //为升级奖励精灵添加一个碰撞框
    addHitbox(HitboxRectangle(relation: boss.attackFrame));
    return super.onLoad();
  }

  @override
  void update(double dt) {
    reeMovement(dt);
    super.update(dt);
  }

  ///自由运动方法
  void reeMovement(double dt){
    if(lives <= 0){
      return;
    }
    x += xDirection * boss.speedy * dt;

    final Rect rect = toRect();

    if ((x <= 0 && xDirection == -1) || (rect.right >= gameRef.size.x && xDirection == 1)) {
      xDirection = xDirection * -1;
    }

    y += yDirection * boss.speedy * dt;

    if ((y <= 0 && yDirection == -1) || (rect.bottom >= gameRef.size.y / 2 && yDirection == 1)) {
      yDirection = yDirection * -1;
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) async{
    if(other is Bullet){
      if(other.position.x <= x + width && other.position.x + 50 >= x && other.position.y <= y + height){
        if(lives > 0){
          lives = lives - playerData.bulletNum;
        }
        if(lives <= 0){
          playerData.currentScore += 10;
          removeFromParent();
          gameRef.gameOver();
          gameRef.overlays.add(MainMenu.id);
        }
      }
    }
    super.onCollision(intersectionPoints, other);
  }
}

class BulletUpgradeEmber<T extends FlameGame> extends SpriteComponent with HasGameRef<AircraftWarsGame> {
  final EnemyData boss;
  BulletUpgradeEmber(this.boss);
  late Vector2 screenSize;
  final Random _random = Random();
  int lives = 0;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    double pos = _random.nextDouble() * (screenSize.x - boss.size.x);
    position.x = pos;
    position.y = -boss.size.y;
    sprite = await gameRef.loadSprite(boss.image);
    size = boss.size;
  }

  @override
  void render(Canvas canvas) {
    TextPaint fpsTextPaint = TextPaint();
    fpsTextPaint.render(canvas, "$lives", Vector2(0, 0));
    super.render(canvas);
  }

  @override
  void onGameResize(Vector2 gameSize) {
    screenSize = gameSize;
    super.onGameResize(gameSize);
  }

}