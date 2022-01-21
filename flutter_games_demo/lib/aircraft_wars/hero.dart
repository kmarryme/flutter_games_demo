import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/geometry.dart';
import 'package:flame/input.dart';

import 'aircraft_wars_game.dart';
import 'boom_component_test.dart';
import 'boss.dart';
import 'enemy.dart';
import 'main_menu.dart';
import 'player_data.dart';

enum HeroAnimationStates{
  idle,
  left,
  right,
}

class Hero extends HeroEmber with Draggable, HasHitboxes, Collidable{
  Hero(Image image, PlayerData playerData) : super(image, playerData);

  Vector2? dragDeltaPosition;
  bool isHit = false;
  // 控制播放命中动画的时间。
  final Timer _hitTimer = Timer(1);

  @override
  Future<void>? onLoad() {
    dragDeltaPosition = position;
    addHitbox(HitboxRectangle(relation: Vector2.all(0.8)));
    
    return super.onLoad();
  }

  @override
  void onMount() {
    _hitTimer.onTick = () {
      isHit = false;
    };
    super.onMount();
  }

  @override
  void update(double dt) {
    _hitTimer.update(dt);
    super.update(dt);
  }

  @override
  bool onDragStart(int pointerId, DragStartInfo info) {
    dragDeltaPosition = info.eventPosition.game - position;
    return false;
  }
  
  @override
  bool onDragUpdate(int pointerId, DragUpdateInfo info) {
    final dragDeltaPosition = this.dragDeltaPosition;
    if (dragDeltaPosition == null) {
      return false;
    }
    Vector2 pos = info.eventPosition.game - dragDeltaPosition;

    if(pos.x > 0 && pos.x < screenSize.x - width){
      if(playerData.lives > 0)position.setFrom(Vector2(info.eventPosition.game.x - dragDeltaPosition.x, y));
    }
    if(pos.y > 0 && pos.y < screenSize.y - height){
      if(playerData.lives > 0)position.setFrom(Vector2(x, info.eventPosition.game.y - dragDeltaPosition.y));
    }
    return super.onDragUpdate(pointerId, info);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) async{
    if((other is Enemy || other is Boss) && (!isHit)){
      isHit = true;
      _hitTimer.start();
      playerData.lives --;
      await add(BoomComponentTest(dragDeltaPosition!));
      if(playerData.lives <= 0){
        gameRef.gameOver();
        await add(BoomComponentTest(dragDeltaPosition! + Vector2(10, 0)));
        await Future.delayed(const Duration(milliseconds: 500));
        await add(BoomComponentTest(dragDeltaPosition! - Vector2(10, 10)));
        await Future.delayed(const Duration(milliseconds: 500));
        await add(BoomComponentTest(dragDeltaPosition! + Vector2(-20, 40)));
        await Future.delayed(const Duration(milliseconds: 500));
        await add(BoomComponentTest(dragDeltaPosition! - Vector2(0, 10)));
        await Future.delayed(const Duration(milliseconds: 2600));
        removeFromParent();
        gameRef.overlays.add(MainMenu.id);
      }
    }
    super.onCollision(intersectionPoints, other);
  }

}

class HeroEmber<T extends FlameGame> extends SpriteAnimationGroupComponent<HeroAnimationStates> with HasGameRef<AircraftWarsGame> {
  final PlayerData playerData;
  HeroEmber(Image image, this.playerData):super.fromFrameData(image, _animationMap);
  

  static final _animationMap = {
    HeroAnimationStates.left: SpriteAnimationData.sequenced(
      amount: 2, 
      stepTime: .1, 
      textureSize: Vector2(58.5, 90),
    ),
    HeroAnimationStates.idle: SpriteAnimationData.sequenced(
      amount: 1, 
      stepTime: .1, 
      textureSize: Vector2(80, 90),
      texturePosition: Vector2(58.5 * 2, 0),
    ),
    HeroAnimationStates.right: SpriteAnimationData.sequenced(
      amount: 2, 
      stepTime: .1, 
      textureSize: Vector2(58.5, 90),
      texturePosition: Vector2((58.5 * 2) + 80, 0),
    ),
  };

  late Vector2 screenSize;


  @override
  Future<void>? onLoad() async{
    current = HeroAnimationStates.idle;
    size = Vector2(80, 90);
    return super.onLoad();
  }

  

  @override
  void onGameResize(Vector2 gameSize) {
    screenSize = gameSize;
    super.onGameResize(gameSize);
  }
}