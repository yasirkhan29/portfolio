import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'ui/home.dart';
import 'config/colors.dart';

void main() async {
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyBlK02G7fa2yBOjxNqlKDbIlrY5cInsXGY",
          authDomain: "portfolio-d18b3.firebaseapp.com",
          projectId: "portfolio-d18b3",
          storageBucket: "portfolio-d18b3.firebasestorage.app",
          messagingSenderId: "82498558018",
          appId: "1:82498558018:web:f79037473051e25334f5db",
          measurementId: "G-K35RL9020L"));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Portfolio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        colorScheme:
            ColorScheme.fromSwatch().copyWith(secondary: AppColors.yellow),
      ),
      home: Home(),
    );
  }
}
//https://portfolio-d18b3.web.app