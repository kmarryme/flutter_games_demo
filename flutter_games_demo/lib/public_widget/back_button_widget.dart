import 'package:flutter/material.dart';

import '../main.dart';
import 'splash_screen.dart';

class BackButtonWidget extends StatelessWidget {
  const BackButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushReplacement(context, FadeRoute(page: const MainPage()));
      },
      child: const Text(
        '返回游戏列表',
        style: TextStyle(
          fontSize: 25,
        ),
      ),
    );
  }
}