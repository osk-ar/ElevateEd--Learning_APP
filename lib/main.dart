import 'package:flutter/material.dart';

late final WidgetsBinding engine;

void main() {
  // ElevateEd
  engine = WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
