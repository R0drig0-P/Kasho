import 'package:flutter/material.dart';
import 'data/app_database.dart';
import 'screens/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final db = AppDatabase();
  runApp(MyApp(db: db));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.db});
  final AppDatabase db;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kasho',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.teal),
      home: HomeScreen(db: db),
    );
  }
}
