import 'package:flame/flame.dart';
import 'package:flame_splash_screen/flame_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SplashScreen extends StatefulWidget {
  final bool landscape;
  final String startImg;
  final Widget child;
  ///启动画面
  const SplashScreen({Key? key, required this.startImg, required this.child, this.landscape = true}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    if(!widget.landscape) Flame.device.setLandscape();
    Flame.device.fullScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlameSplashScreen(
        theme: FlameSplashTheme(
          backgroundDecoration: const BoxDecoration(
            color: Colors.black,
          ),
          logoBuilder: (context) {
            return Image.asset("assets/images/${widget.startImg}");
          },
        ),
        onFinish: (context) async{
          await Navigator.pushReplacement(context, FadeRoute(page: widget.child));
          if(!widget.landscape) await Flame.device.setPortrait();
          SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
        },
      ),
    );
  }
}



class FadeRoute extends PageRouteBuilder {
  final Widget page;
  ///页面渐变过度
  FadeRoute({required this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
}
