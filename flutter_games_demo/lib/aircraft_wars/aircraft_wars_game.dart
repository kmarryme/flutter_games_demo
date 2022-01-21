import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter_games_demo/public_components/mask_layer.dart';

import 'aircraft_static_data.dart';
import 'aircraft_wars_background.dart';
import 'bullet.dart';
import 'bullet_upgrade.dart';
import 'enemy_manager.dart';
import 'hero.dart';
import 'hp_reward.dart';
import 'player_data.dart';

class AircraftWarsGame extends FlameGame with HasTappables, HasDraggables, HasCollidables{
  ///飞机血量、分数
  late PlayerData playerData = PlayerData();
  ///渐变遮罩层
  final MaskLayer _maskLayer = MaskLayer();
  ///背景精灵
  final AircraftWarsBackground _background = AircraftWarsBackground();
  ///玩家飞机精灵
  late Hero _hero;
  ///子弹精灵
  late Bullet _bullet;
  ///子弹Timer
  Timer? bulletTime;
  ///子弹升级奖励出现Timer
  Timer? bulletUpTime;
  ///飞机吃完奖励后的计时30秒
  Timer? bulletUpgradeTimer;
  ///随机数
  final Random _random = Random();
  ///子弹升级奖励精灵
  late BulletUpgrade _bulletUpgrade;
  ///敌人管理类
  late EnemyManager _enemyManager;
  ///血量奖励
  late HpReward _hpReward;
  ///血量奖励出现Timer
  Timer? hpUpTime;

  @override
  Future<void>? onLoad() async{
    //加载所有图片
    await images.loadAll([
      'aircraft_wars/boom.png',
      'aircraft_wars/clickBack.png',
      'aircraft_wars/blood_upgrade.png',
      'aircraft_wars/blood.png',
      'aircraft_wars/boss0.png',
      'aircraft_wars/bullet_upgrade.png',
      'aircraft_wars/bullet0.png',
      'aircraft_wars/bullet1.png',
      'aircraft_wars/bullet2.png',
      'aircraft_wars/enemy0.png',
      'aircraft_wars/enemy1.png',
      'aircraft_wars/enemy2.png',
      'aircraft_wars/hero.png',
      'aircraft_wars/warning.gif',
    ]);
    //初始化分数和血量
    playerData.currentScore = 0;
    playerData.lives = AircraftConfig.HERO_LIVES;
    //添加背景精灵
    await add(_background);
    //初始化玩家飞机精灵
    _hero = Hero(images.fromCache('aircraft_wars/hero.png'), playerData);
    await add(_maskLayer);
    return super.onLoad();
  }

  @override
  void update(double dt) {
    bulletTime?.update(dt);
    bulletUpTime?.update(dt);
    bulletUpgradeTimer?.update(dt);
    hpUpTime?.update(dt);
    super.update(dt);
  }

  ///开始游戏
  Future<void> startGamePlay() async{
    print("---------------开始游戏---------------");
    // 创建一个敌人管理者。
    _enemyManager = EnemyManager(playerData);
    //添加玩家飞机精灵
    await add(_hero);
    playerData.bulletNum = AircraftConfig.NUMBER_OF_BULLETS;
    playerData.lives = AircraftConfig.HERO_LIVES;
    playerData.currentScore = 0;
    _hero.position = Vector2((_hero.screenSize.x - 80) / 2, _hero.screenSize.y / 2 + 120);
    fireBullets();
    getRandom();
    getRandomHp();
    add(_enemyManager);
  }

  ///玩家飞机开始发射子弹
  void fireBullets(){
    bulletTime = Timer(
      AircraftConfig.BULLET_FIRINNG_INTERVAL,
      repeat: true,
      onTick: () async{
        _bullet = Bullet(_hero.position, playerData.bulletNum);
        await add(_bullet);
      }
    );
    bulletTime?.start();
  }

  ///随机一个时间（20-60秒）后出现子弹奖励
  void getRandom(){
    bulletUpTime?.stop();
    int next(int min, int max) => min + _random.nextInt(max - min);
    int c = next(AircraftConfig.BULLET_REWARD_MIN, AircraftConfig.BULLET_REWARD_MAX);
    double bulletUpInterval = c.toDouble();
    print("---------------$bulletUpInterval 秒后出现子弹奖励");
    bulletUpTime = Timer(
      bulletUpInterval,
      onTick: () async{
        print("---------------子弹奖励出现");
        getRandom();
        _bulletUpgrade = BulletUpgrade(playerData.bulletNum, (int bullet){
          playerData.bulletNum = bullet;
          print("---------------玩家吃到子弹奖励，30秒后失效，当前子弹个数:${playerData.bulletNum}");
          bulletUpgradeTiming();
        });
        await add(_bulletUpgrade);
      }
    );
    bulletUpTime?.start();
  }

  ///吃完子弹奖励后开始计时，子弹奖励30秒后失效
  void bulletUpgradeTiming(){
    bulletUpgradeTimer?.stop();
    bulletUpgradeTimer = Timer(
      AircraftConfig.BULLET_REWARD_FAILURE,
      onTick: (){
        print("---------------子弹奖励失效");
        playerData.bulletNum = 1;
      }
    );
    bulletUpgradeTimer?.start();
  }

  ///随机一个时间（20-60秒）后出现血量奖励
  void getRandomHp(){
    hpUpTime?.stop();
    int next(int min, int max) => min + _random.nextInt(max - min);
    int c = next(AircraftConfig.BULLET_REWARD_MIN, AircraftConfig.BULLET_REWARD_MAX);
    double hpUpInterval = c.toDouble();
    print("---------------$hpUpInterval 秒后出现血量奖励");
    hpUpTime = Timer(
      hpUpInterval,
      onTick: () async{
        print("---------------血量奖励出现");
        getRandomHp();
        _hpReward = HpReward(playerData.lives, (int value){
          playerData.lives = value;
          print("---------------玩家吃到血量奖励，当前血量:${playerData.lives}");
        });
        await add(_hpReward);
      }
    );
    hpUpTime?.start();
  }

  ///游戏结束
  void gameOver(){
    _enemyManager.removeAllEnemies();
    hpUpTime?.stop();
    bulletUpTime?.stop();
    bulletTime?.stop();
    bulletUpgradeTimer?.stop();
  }

  // @override
  // bool get debugMode => true;
}