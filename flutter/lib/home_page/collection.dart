import 'package:flutter/material.dart';
import 'home_page.dart';

class collection extends StatelessWidget {
  const collection({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'EgyTour',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: const HomePage(),
    );
  }
}