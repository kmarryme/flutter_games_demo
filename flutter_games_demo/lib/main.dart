import 'package:flutter/material.dart';

import 'aircraft_wars/aircraft_wars_start.dart';
import 'public_widget/splash_screen.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MainPage(), 
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          to('飞机大战', 'aircraft_wars/enemy0.png', const AircraftWarsStart()),
        ],
      ),
    );
  }

  Padding to(String name, String startImg, Widget child, {bool landscape = true}){
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 100,
        vertical: 20,
      ),
      child: ElevatedButton(
        onPressed: () async{
          await Navigator.pushReplacement(context, FadeRoute(page: SplashScreen(startImg: startImg, child: child)));
        }, 
        child: Text(name),
      ),
    );
  }
}

