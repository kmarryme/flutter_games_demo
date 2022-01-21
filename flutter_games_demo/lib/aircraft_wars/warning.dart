import 'package:flame/components.dart';

import 'aircraft_wars_game.dart';

class Warning extends SpriteComponent with HasGameRef<AircraftWarsGame>{
  late Vector2 screenSize;

  @override
  Future<void>? onLoad() {
    sprite = Sprite(gameRef.images.fromCache('aircraft_wars/warning.gif'));
    size = Vector2(screenSize.x, 80);
    position = Vector2(0, (screenSize.y - 200) / 2);
    return super.onLoad();
  }

  @override
  void onGameResize(Vector2 gameSize) {
    screenSize = gameSize;
    super.onGameResize(gameSize);
  }

}