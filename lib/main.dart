import 'package:flutter/material.dart';
import 'package:game_3_x_and_o/consts/consts.dart';
import 'package:game_3_x_and_o/screens/xo_game/xo_dashboard.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tic Tac Toe',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Consts.primaryColor,
        shadowColor: Consts.shadowColor,
        splashColor: Consts.splashColor,
      ),
      home: XODashboardScreen(),
    );
  }
}
