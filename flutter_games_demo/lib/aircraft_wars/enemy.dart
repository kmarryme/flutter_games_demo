import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/geometry.dart';

import 'aircraft_static_data.dart';
import 'aircraft_wars_game.dart';
import 'boom_component_test.dart';
import 'bullet.dart';
import 'enemy_data.dart';
import 'player_data.dart';

class Enemy extends SpriteComponent with HasHitboxes, Collidable, HasGameRef<AircraftWarsGame> {
  // 创建此敌人所需的数据。
  final EnemyData enemyData;
  final PlayerData playerData;
  Enemy(this.enemyData, this.playerData);
  late Vector2 screenSize;
  final Random _random = Random();
  int lives = 0;

  @override
  Future<void>? onLoad() {
    lives = AircraftConfig.ENEMY_LIVES[enemyData.name]??0;
    sprite = Sprite(gameRef.images.fromCache(enemyData.image));
    size = enemyData.size;
    position = Vector2(_random.nextDouble() * (screenSize.x - enemyData.size.x), -enemyData.size.y);
    return super.onLoad();
  }


  @override
  void onMount() {
    // 为这个敌人添加一个攻击框。
    final shape = HitboxRectangle(relation: enemyData.attackFrame);
    addHitbox(shape);
    super.onMount();
  }

  @override
  void update(double dt) {
    if(lives != 0){
      position.y += (enemyData.speedy + playerData.currentScore) * dt;
    }
    
    //移除敌人
    //如果敌人已经越过屏幕的低端。
    if (position.y > screenSize.y + enemyData.size.y) {
      removeFromParent();
      if(playerData.currentScore > 0){
        playerData.currentScore --;
      }
    }
    super.update(dt);
  }

  @override
  void onGameResize(Vector2 gameSize) {
    screenSize = gameSize;
    super.onGameResize(gameSize);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) async{
    if(other is Bullet){
      if(other.position.x <= x + width && other.position.x + 50 >= x && other.position.y <= y + height){
        lives = lives - playerData.bulletNum;
        if(lives <= 0){
          playerData.currentScore ++;
          gameRef.add(BoomComponentTest(position + (size / 2) + Vector2(0, 10)));
          removeFromParent();
          
        }
      }
    }
    super.onCollision(intersectionPoints, other);
  }
}
