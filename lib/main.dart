import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:sketch/screen/dashbord_screen/dashbord.dart';
import 'package:sketch/screen/home_screen/home_screen.dart';
import 'package:sketch/screen/on_board/on_board_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: OnBoardScreen(),
    );
  }
}
