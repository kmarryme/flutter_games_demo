
import 'dart:math';

import 'package:decimal/decimal.dart';
import 'package:flame/components.dart';

import 'aircraft_static_data.dart';
import 'aircraft_wars_game.dart';
import 'boss.dart';
import 'enemy.dart';
import 'enemy_data.dart';
import 'player_data.dart';
import 'warning.dart';


//这个职业负责在特定的时间随机产生敌人
//时间间隔取决于球员当前得分。
class EnemyManager extends PositionComponent with HasGameRef<AircraftWarsGame> {
  final PlayerData playerData;

  // 随机选择敌人类型所需的随机生成器。
  final Random _random = Random();

  // 决定何时繁殖下一个敌人的计时器。
  late Timer _timer;

  Decimal enemyShowTime = Decimal.parse('2');

  Decimal score1 = Decimal.zero;

  int playerCrrentScore = 0;

  late List<EnemyData> _data;

  late Boss _boss;

  final Warning _warning = Warning();

  final Timer _warningTimer = Timer(0.4, repeat: true, autoStart: true);

  EnemyManager(this.playerData) {
    _data = AircraftConfig.ENEMY_DATA_LIST;
     _timer = Timer(enemyShowTime.toDouble(), repeat: true);
    _timer.onTick = spawnRandomEnemy;
  }

  /// 此方法负责生成一个随机的敌人。
  Future<void> spawnRandomEnemy() async{
    if(enemyShowTime <= Decimal.parse('0.2')){
      //这里已经到了生成敌人时间间隔的极限 这里生成boss
       _timer.stop();
      _warningTimer.onTick = (){
        if(_warning.isMounted){
          _warning.removeFromParent();
        }else{
          gameRef.add(_warning);
        }
      };
      await Future.delayed(const Duration(seconds: 5));
      _warningTimer.stop();
      _warning.removeFromParent();
      _boss = Boss(AircraftConfig.BOSS_DATA_LIST[0], playerData);
      gameRef.add(_boss);
    }else{
      /// 在[_data]内生成一个随机索引并获取一个[EnemyData]。
      final randomIndex = _random.nextInt(_data.length);
      final enemyData = _data.elementAt(randomIndex);
      final enemy = Enemy(enemyData, playerData);

      //由于视口的大小，我们可以
      //使用textureSize作为组件的大小。
      enemy.size = enemyData.size;
      gameRef.add(enemy);
      if(playerData.currentScore != playerCrrentScore){
        Decimal decimal = (Decimal.parse((playerData.currentScore).toString()) * Decimal.parse('0.01'));
        Decimal score = Decimal.parse(decimal.toDouble().toStringAsFixed(1));
        if(score != score1){
          _timer.stop();
          enemyShowTime = enemyShowTime - Decimal.parse('0.2');
          _timer = Timer(enemyShowTime.toDouble(), repeat: true);
          _timer.onTick = spawnRandomEnemy;
          _timer.start();
        }
        score1 = score;
      }
      
      playerCrrentScore = playerData.currentScore;
      
    }
    
    
  }

  @override
  void onMount() {
    shouldRemove = false;
    _timer.start();
    super.onMount();
  }

  @override
  void update(double dt) {
    _timer.update(dt);
    _warningTimer.update(dt);
    super.update(dt);
  }

  void removeAllEnemies() {
    if(isMounted){
      final enemies = gameRef.children.whereType<Enemy>();
      for (Enemy element in enemies) {
        element.removeFromParent();
      }

      final enemiesBoss = gameRef.children.whereType<Boss>();
      for (Boss element in enemiesBoss) { 
        enemyShowTime = Decimal.parse("2");
        playerCrrentScore = 0;
        score1 = Decimal.zero;
        element.removeFromParent();
      }
    }
    _warningTimer.start();
    _timer.stop();
    removeFromParent();
  }
}
