import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_games_demo/public_widget/suspend_menu.dart';

import 'main_menu.dart';
import 'skipping_rope_game.dart';

class SkippingRopeStart extends StatelessWidget {
  const SkippingRopeStart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GameWidget(
        game: SkippingRopeGame(),
        loadingBuilder: (context) {
          return Container();
        },
        overlayBuilderMap: {
          MainMenu.id: (_, SkippingRopeGame gameRef) => MainMenu(gameRef),
          SuspendMenu.id: (_, FlameGame gameRef) => SuspendMenu(gameRef),
        },
        initialActiveOverlays: const [MainMenu.id], 
        errorBuilder: (context, error) {
          debugPrint(error.toString());
          return const Text("页面崩溃了");
        },
        //显示在游戏背景
        backgroundBuilder: (context) {
          return Container(
            color: Colors.black,
          );
        },
        // 此gameWidget的初始光标 可以在运行时使用[Game.mouseCursor]更改鼠标光标
        // mouseCursor: SystemMouseCursors.move,
      ),
    );
  }
}