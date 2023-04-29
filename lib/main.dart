import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:sketch/screen/dashbord_screen/dashbord.dart';
import 'package:sketch/screen/on_board/on_board_screen.dart';
import 'package:sketch/services/pref_service.dart';
import 'package:sketch/utils/pref_key.dart';

import 'screen/auth/create_account/what_intrested/what_intrested_screen.dart';

Future<void> main() async {
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
      home: (PrefService.getBool(PrefKeys.login) == true)
          ? DashBoardScreen()
          : (PrefService.getBool(PrefKeys.isOnlyRegister) == true)
              ? WhatIntrestedScreen()
              : OnBoardScreen(),
    );
  }
}

// class DropdownScreen extends StatefulWidget {
//   @override
//   _DropdownScreenState createState() => _DropdownScreenState();
// }
//
// class _DropdownScreenState extends State<DropdownScreen> {
//   String? _selectedItem;
//
//   // Add a global key to track the position of the field
//   final GlobalKey _fieldKey = GlobalKey();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Dropdown Demo'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // Wrap the field with a gesture detector and assign the global key
//             GestureDetector(
//               onTap: () => _showDropdown(context),
//               child: Container(
//                 key: _fieldKey,
//                 width: 200,
//                 height: 50,
//                 decoration: BoxDecoration(
//                   border: Border.all(
//                     color: Colors.grey,
//                   ),
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 16),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         _selectedItem ?? 'Select an item',
//                         style: TextStyle(
//                           color: _selectedItem == null ? Colors.grey : Colors.black,
//                         ),
//                       ),
//                       Icon(Icons.arrow_drop_down),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   // Define a method to show the dropdown dialog
//   void _showDropdown(BuildContext context) {
//     final RenderBox field = _fieldKey.currentContext!.findRenderObject() as RenderBox;
//     final fieldOffset = field.localToGlobal(Offset.zero);
//
//     showMenu<String>(
//       context: context,
//       position: RelativeRect.fromLTRB(
//         fieldOffset.dx + field.size.width/2,
//         fieldOffset.dy + field.size.height,
//         fieldOffset.dx + field.size.width,
//         fieldOffset.dy + field.size.height * 2,
//       ),
//       items: [
//         PopupMenuItem<String>(
//           child: Text('Item 1'),
//           value: 'item1',
//         ),
//         PopupMenuItem<String>(
//           child: Text('Item 2'),
//           value: 'item2',
//         ),
//         PopupMenuItem<String>(
//           child: Text('Item 3'),
//           value: 'item3',
//         ),
//       ],
//     ).then((selectedValue) {
//       if (selectedValue != null) {
//         setState(() {
//           _selectedItem = selectedValue;
//         });
//       }
//     });
//   }
// }
