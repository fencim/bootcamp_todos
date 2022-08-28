import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'home_feature/home_page.dart';

void main() async {
  /// Make sure to initialize the Flutter binding
  /// instance when using native plugins or components
  /// like camera, GPS, bluetooth.
  WidgetsFlutterBinding.ensureInitialized();

  /// Make sure to initialize Hive DB
  /// so that we can use later for opening
  /// and closing boxes.
  await Hive.initFlutter();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

      /// This is the first page loaded
      /// in your Flutter app.
      home: const HomePage(),
    );
  }
}
