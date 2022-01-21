import 'package:flame/components.dart';
import 'package:flutter/painting.dart';

///加载结束时的渐变遮罩
class MaskLayer extends PositionComponent{
  late Vector2 screenSize;
  double opacity = 1;

  @override
  void render(Canvas canvas){
    Rect rect = Rect.fromLTWH(0, 0, screenSize.x, screenSize.y);
    Paint paint = Paint();
    paint.color = const Color(0xff000000).withOpacity(opacity);
    canvas.drawRect(rect, paint);
  }

  @override
  void update(double dt) {
    opacity -= dt;
    if(opacity <= dt){
      removeFromParent();
    }
    super.update(dt);
  }

  @override
  void onGameResize(Vector2 canvasSize) {
    screenSize = canvasSize;
    super.onGameResize(canvasSize);
  }
}