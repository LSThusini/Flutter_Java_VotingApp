import 'package:flutter/material.dart';
import 'package:flutter_client/candidates_list.dart';
import 'package:flutter_client/connection/handler.dart';
import 'package:flutter_client/login_page.dart';
import 'package:flutter_client/results_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const LoginPage(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: const Color.fromARGB(255, 6, 94, 165),
      ),
    );
  }
}
