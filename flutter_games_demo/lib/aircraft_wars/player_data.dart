
import 'package:flutter/foundation.dart';

import 'aircraft_static_data.dart';

///飞机血量、分数
class PlayerData extends ChangeNotifier {

  int _lives = AircraftConfig.HERO_LIVES;
  int get lives => _lives;
  set lives(int value) {
    if (value <= AircraftConfig.HERO_LIVES && value >= 0) {
      _lives = value;
      notifyListeners();
    }
  }

  int _currentScore = 0;
  int get currentScore => _currentScore;
  set currentScore(int value) {
    _currentScore = value;

    notifyListeners();
  }

  int _bulletNum = 1;
  int get bulletNum => _bulletNum;
  set bulletNum(int value){
    _bulletNum = value;
    notifyListeners();
  }
}
