import 'package:flutter/material.dart';
import 'package:flutter_firestore_crud/presentation/pages/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Firestore CRUD',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: HomePage(),
    );
  }
}
