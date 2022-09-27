import 'package:flutter/material.dart';
import 'TodoScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
      const MaterialApp(
        debugShowCheckedModeBanner: false,
         home:TodoScreen()
      )
  );
}

