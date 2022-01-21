import 'dart:ui';

import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'back_button_widget.dart';

class SuspendMenu extends StatelessWidget {
  // 为该覆盖标识的唯一属性。
  static const id = 'SuspendMenu';

  final FlameGame gameRef;

  const SuspendMenu(this.gameRef, {Key? key}) : super(key: key);

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
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      gameRef.overlays.remove(SuspendMenu.id);
                      gameRef.resumeEngine();
                    },
                    child: const Text(
                      '继续游戏',
                      style: TextStyle(
                        fontSize: 25,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
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
