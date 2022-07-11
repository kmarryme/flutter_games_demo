import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_games_demo/public_widget/back_button_widget.dart';

import 'skipping_rope_game.dart';

class MainMenu extends StatelessWidget {
  static const id = 'SkippingRopeMainMenu';

  final SkippingRopeGame gameRef;

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
                    '跳绳',
                    style: TextStyle(
                      fontSize: 50,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      // gameRef.startGamePlay();
                      // gameRef.overlays.remove(MainMenu.id);
                    },
                    child: const Text(
                      '开始',
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
