import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const PawsAndPalsApp()); // Titik eksekusi utama aplikasi mobile
}

class PawsAndPalsApp extends StatelessWidget {
  const PawsAndPalsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Membangun Akar Widget Tree Aplikasi (Materi 4)
    return MaterialApp(
      title: 'Paws & Pals App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.deepOrange,
      ),
      home: const HomeScreen(), // Mengarahkan Halaman Awal Aplikasi
    );
  }
}