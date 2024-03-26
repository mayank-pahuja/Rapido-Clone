import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:rapido/screens/about_screen.dart';
import 'package:rapido/screens/history_screen.dart';
import 'package:rapido/screens/splash_screen.dart';
import 'package:rapido/screens/visit_profile_screen.dart';
import 'package:rapido/wrapper.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
            apiKey: "AIzaSyDjMB0YuZP3SiJRxpsxy1pBGyBW-OxuNXk",
            appId: "1:179713960522:android:391199b92da9ce114fd4b3",
            messagingSenderId: "179713960522",
            projectId: "rapido-clone-78a08",
            storageBucket: "rapido-clone-78a08.appspot.com",
          ),
        )
      : await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Rapido Clone',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 255, 255, 255)),
        useMaterial3: true,
        fontFamily: 'cv',
      ),
      routes: {
        '/about': (context) => AboutScreen(),
        '/visit_profile': (context) => VisitProfileScreen(),
        '/history': (context) => HistoryScreen(),
      },
      home: FutureBuilder(
        // Replace the 3 second delay with your initialization code:
        future: Future.delayed(Duration(seconds: 4)),
        builder: (context, AsyncSnapshot snapshot) {
          // Show splash screen while waiting for app resources to load:
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SplashScreen();
          } else {
            // Loading is done, return the app:
            return Wrapper();
          }
        },
      ),
    );
  }
}
