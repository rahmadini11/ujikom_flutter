import 'package:flutter/material.dart';
import 'home.dart'; // Ganti dengan path ke file HomeScreen Anda
import 'agenda.dart'; // Ganti dengan path ke file AgendaScreen Anda
import 'info.dart'; // Ganti dengan path ke file InfoScreen Anda
import 'galery.dart'; // Ganti dengan path ke file GaleryScreen Anda

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Galery Sekolah',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/agenda': (context) => AgendaScreen(),
        '/info': (context) => InfoScreen(),
        '/gallery': (context) => GaleryScreen(),
      },
    );
  }
}
