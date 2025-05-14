import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'ui/home.dart';
import 'config/colors.dart';

void main() async {
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyC1k1xW4nVoHzjUaBGwrS3PqQTmM5mQrSA",
          authDomain: "portfolio-fce59.firebaseapp.com",
          projectId: "portfolio-fce59",
          storageBucket: "portfolio-fce59.firebasestorage.app",
          messagingSenderId: "1056417460393",
          appId: "1:1056417460393:web:d2848d1554d2538893b9b8",
          measurementId: "G-DMP2D06HK0"));
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
