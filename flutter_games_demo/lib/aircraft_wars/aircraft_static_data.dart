
import 'package:flame/game.dart';

import 'enemy_data.dart';

class AircraftConfig{
  
  /// * 玩家初始血量
  // ignore: constant_identifier_names
  static const int HERO_LIVES = 3;

  /// * 玩家飞机初始子弹个数(最大为1 - 3)
  // ignore: constant_identifier_names
  static const int NUMBER_OF_BULLETS = 1;

  /// * 子弹奖励失效时间(秒)
  // ignore: constant_identifier_names
  static const double BULLET_REWARD_FAILURE = 30;

  /// * 子弹奖励和血量奖励随机范围最小(秒)
  // ignore: constant_identifier_names
  static const int BULLET_REWARD_MIN = 20;
  /// * 子弹奖励和血量奖励随机范围最大(秒)
  // ignore: constant_identifier_names
  static const int BULLET_REWARD_MAX = 60;

  /// * 玩家子弹发射间隔
  // ignore: constant_identifier_names
  static const double BULLET_FIRINNG_INTERVAL = 0.2;

  /// * 子弹移动速度
  // ignore: constant_identifier_names
  static const int BULLET_SPEED = 600;

  /// * 敌人血量
  // ignore: constant_identifier_names
  static const Map<EnemyName, int> ENEMY_LIVES = {
    EnemyName.redEnemy: 3,
    EnemyName.yellowEnemy: 6,
    EnemyName.whiteEnemy: 6,
    EnemyName.doubleHeadedBoss: 1000,
  };
  /// * 敌人数组
  // ignore: non_constant_identifier_names
  static List<EnemyData> ENEMY_DATA_LIST = [
    EnemyData(
      image: 'aircraft_wars/enemy0.png',
      size: Vector2(100, 100),
      speedy: 100,
      attackFrame: Vector2(0.5, 0.3),
      name: EnemyName.redEnemy,
    ),
    EnemyData(
      image: 'aircraft_wars/enemy1.png',
      size: Vector2(70, 70),
      speedy: 60,
      attackFrame: Vector2(1, 0.6),
      name: EnemyName.yellowEnemy,
    ),
    EnemyData(
      image: 'aircraft_wars/enemy2.png',
      size: Vector2(70, 70),
      speedy: 40,
      attackFrame: Vector2(1, 0.6),
      name: EnemyName.whiteEnemy,
    ),
  ];

  ///BOSS数组
  // ignore: non_constant_identifier_names
  static List<EnemyData> BOSS_DATA_LIST = [
    EnemyData(
      image: 'aircraft_wars/boss0.png', 
      speedy: 20, 
      size: Vector2(350, 200), 
      attackFrame: Vector2(0.98, 0.4), 
      name: EnemyName.doubleHeadedBoss,
    ),
  ];


}