import 'package:flutter/material.dart';
import 'package:flutter_games_demo/public_widget/suspend_menu.dart';
import 'package:provider/provider.dart';

import 'aircraft_static_data.dart';
import 'aircraft_wars_game.dart';
import 'player_data.dart';

class Information extends StatelessWidget {
  static const id = 'Information';

  final AircraftWarsGame gameRef;
  const Information(this.gameRef, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: gameRef.playerData,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Selector<PlayerData, int>(
              builder: (_, score, __){
                return Text("分数: $score");
              }, 
              selector: (_, playerData) => playerData.currentScore,
            ),
            IconButton(
              onPressed: (){
                gameRef.pauseEngine();
                gameRef.overlays.add(SuspendMenu.id);
              }, 
              icon: const Icon(Icons.pause),
            ),
            Selector<PlayerData, int>(
              builder: (_, lives, __){
                return Row(
                  children: List.generate(AircraftConfig.HERO_LIVES, (index) {
                    if(index < lives){
                      return const Icon(Icons.favorite, color: Colors.red);
                    }else{
                      return const Icon(Icons.favorite_border,color: Colors.red);
                    }
                  }),
                );
              }, 
              selector: (_, playerData) => playerData.lives,
            ),
          ],
        ),
      ),
    );
  }
}