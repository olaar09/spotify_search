import 'package:emoodie/src/presentation/screens/home/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const SpotifyEmoodieApp());
}

class SpotifyEmoodieApp extends StatelessWidget {
  const SpotifyEmoodieApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SpotifyEmoodieHome(),
    );
  }
}
