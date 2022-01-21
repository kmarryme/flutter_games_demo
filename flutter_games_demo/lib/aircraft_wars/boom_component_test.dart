import 'package:flame/components.dart';
import 'package:flame/image_composition.dart';
import 'package:flame/sprite.dart';

class BoomComponentTest extends SpriteAnimationComponent with HasGameRef{
  BoomComponentTest(Vector2 pos) : super(position: pos - Vector2(61, 104));

  @override
  Future<void>? onLoad() {
    final Image spriteImage = gameRef.images.fromCache('aircraft_wars/boom.png');
    final SpriteSheet spritesheet = SpriteSheet.fromColumnsAndRows(
      image: spriteImage,
      columns: 8,
      rows: 8,
    );
    final sprites = List<Sprite>.generate(64, spritesheet.getSpriteById);
    animation = SpriteAnimation.spriteList(sprites, stepTime: 0.04, loop: false);
    size = Vector2(128, 128);
    removeOnFinish = true;
    return super.onLoad();
  }

}
