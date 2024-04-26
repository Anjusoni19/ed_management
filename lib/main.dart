import 'package:camera/camera.dart';
import 'package:ed_management/Colors.dart';
import 'package:ed_management/screens/SplashScreen.dart';
import 'package:flutter/material.dart';

import 'screens/Login Screen.dart';

late List<CameraDescription> _cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  _cameras = await availableCameras();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: appPrimary,
        cardColor: Colors.white,
        // focusColor: appPrimary,
        disabledColor: Colors.black,
        // useMaterial3: true,
      ),
      home:  AppSplashScreen(),
    );
  }
}

