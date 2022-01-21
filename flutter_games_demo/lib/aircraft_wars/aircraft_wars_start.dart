import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_games_demo/public_widget/suspend_menu.dart';

import 'aircraft_wars_game.dart';
import 'information.dart';
import 'main_menu.dart';

class AircraftWarsStart extends StatelessWidget {
  ///飞机大战
  const AircraftWarsStart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GameWidget(
        game: AircraftWarsGame(),
        //游戏加载中的时候显示的组件
        loadingBuilder: (context) {
          return Container();
        },
        //游戏最上层的组件 比如菜单
        overlayBuilderMap: {
          MainMenu.id: (_, AircraftWarsGame gameRef) => MainMenu(gameRef),
          Information.id: (_, AircraftWarsGame gameRef) => Information(gameRef),
          SuspendMenu.id: (_, FlameGame gameRef) => SuspendMenu(gameRef),
        },
        //初始叠加最上层的组件
        initialActiveOverlays: const [MainMenu.id], 
        //异常
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