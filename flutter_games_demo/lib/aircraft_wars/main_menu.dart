import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_games_demo/public_widget/back_button_widget.dart';

import 'aircraft_wars_game.dart';
import 'information.dart';

class MainMenu extends StatelessWidget {
  // 为该覆盖标识的唯一属性。
  static const id = 'MainMenu';

  // Reference to parent game.
  final AircraftWarsGame gameRef;

  const MainMenu(this.gameRef, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          color: Colors.black.withAlpha(100),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 100),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    '飞机大战',
                    style: TextStyle(
                      fontSize: 50,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      gameRef.startGamePlay();
                      gameRef.overlays.remove(MainMenu.id);
                      gameRef.overlays.add(Information.id);
                    },
                    child: const Text(
                      '开始',
                      style: TextStyle(
                        fontSize: 25,
                      ),
                    ),
                  ),
                  const BackButtonWidget(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
