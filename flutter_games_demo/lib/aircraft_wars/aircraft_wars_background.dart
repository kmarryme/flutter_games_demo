import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/rendering.dart';

class AircraftWarsBackground extends AircraftWarsBackgroundEmber{


}

class AircraftWarsBackgroundEmber<T extends FlameGame> extends ParallaxComponent {

  @override
  Future<void> onLoad() async {
    parallax = await gameRef.loadParallax(
      [ParallaxImageData('aircraft_wars/clickBack.png')],
      baseVelocity: Vector2(0, -10),
      velocityMultiplierDelta: Vector2(0, 5),
      fill: LayerFill.width,
      repeat: ImageRepeat.repeatY,
    );
    await super.onLoad();
  }

}