import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:sketch/screen/dashbord_screen/dashbord.dart';
import 'package:sketch/screen/on_board/on_board_screen.dart';
import 'package:sketch/services/pref_service.dart';
import 'package:sketch/utils/pref_key.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await PrefService.init();
  await Firebase.initializeApp();
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
      home:(PrefService.getBool(PrefKeys.login) == true) ? DashBoardScreen() : OnBoardScreen() ,
    );
  }
}
