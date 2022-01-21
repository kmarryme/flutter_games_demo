import 'package:flame/extensions.dart';

enum EnemyName{
  redEnemy,
  yellowEnemy,
  whiteEnemy,
  doubleHeadedBoss,
}

///敌人类
class EnemyData{
  ///图片
  final String image;
  ///y移动速度
  final double speedy;
  ///大小
  final Vector2 size;
  ///攻击框
  final Vector2 attackFrame;
  ///名字
  final EnemyName name;
  
  EnemyData({
    required this.image,
    required this.speedy,
    required this.size,
    required this.attackFrame,
    required this.name,
  });
}

