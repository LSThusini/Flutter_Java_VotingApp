import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_client/candidates_list.dart';
import 'package:flutter_client/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const CandidatesList(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: const Color.fromARGB(255, 6, 94, 165),
      ),
    );
  }
}

class SocketClient extends StatefulWidget {
  const SocketClient({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SocketClientState createState() => _SocketClientState();
}

class _SocketClientState extends State<SocketClient> {
  @override
  void initState() {
    super.initState();
    connectToServer();
  }

  void connectToServer() {
    Socket.connect('10.0.2.2', 9876).then((socket) {
      print('Connected to server');

      socket.writeln('Hello from Flutter');

      socket.listen((List<int> data) {
        print('Server: ${String.fromCharCodes(data)}');
      }, onDone: () {
        print('Server disconnected');
        socket.destroy();
      }, onError: (error) {
        print('Error: $error');
        socket.destroy();
      });
    }).catchError((error) {
      print('Error: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Text('Socket Client');
  }

  @override
  void dispose() {
    super.dispose();
  }
}
