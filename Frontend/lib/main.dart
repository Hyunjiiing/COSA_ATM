import 'package:cosa_atm/pages/loading_page.dart';
import 'package:cosa_atm/pages/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyDlV-E88CZRz2E6wxHA0EDmWmpelaYR5xs",
          appId: "1:532845807429:android:36b20b8eb2363e4db9602c",
          messagingSenderId: "532845807429",
          projectId: "cosa-atm-80a90"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.yellow,
      ),
      home: loading_page(),
    );
  }
}
