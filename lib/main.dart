import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'ui/home.dart';
import 'config/colors.dart';

void main() async {
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyB_XUbU8WzK8taWroT3O7YqoMayS9vcr60",
          authDomain: "portfolio-e237d.firebaseapp.com",
          projectId: "portfolio-e237d",
          storageBucket: "portfolio-e237d.firebasestorage.app",
          messagingSenderId: "1083143175534",
          appId: "1:1083143175534:web:a006ad7f9720216713957f",
          measurementId: "G-VS86LWXC9W"));
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
//https://portfolio-e237d.web.app
