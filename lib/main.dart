import 'package:flutter/material.dart';
import 'package:kasho/screens/ai_lab_screen.dart';
import 'package:kasho/screens/new_transaction_screen.dart';
import 'package:kasho/screens/transactions_screen.dart';
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
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.teal,
        brightness: Brightness.light,
        textTheme: const TextTheme(
          headlineMedium: TextStyle(
            fontWeight: FontWeight.w800,
            letterSpacing: -0.2,
          ),
          titleMedium: TextStyle(fontWeight: FontWeight.w600),
          bodyMedium: TextStyle(height: 1.2),
        ),
        cardTheme: const CardThemeData(
          elevation: 1,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
        ),
      ),
      home: RootShell(db: db),
    );
  }
}

// App's Shell with Bottom Bar and Central FAB
class RootShell extends StatefulWidget {
  const RootShell({super.key, required this.db});
  final AppDatabase db;

  @override
  State<RootShell> createState() => RootShellState();
}

class RootShellState extends State<RootShell> {
  int index = 0; // 0: Home, 1: Transactions, 2: AI

  late final pages = <Widget>[
    HomeScreen(db: widget.db),
    TransactionsScreen(db: widget.db),
    AILabScreen(db: widget.db),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: index, children: pages),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              tooltip: 'Home',
              isSelected: index == 0,
              icon: const Icon(Icons.home_outlined),
              onPressed: () => setState(() => index = 0),
            ),
            const SizedBox(width: 48), // espaço para o FAB central
            IconButton(
              tooltip: 'Transactions',
              isSelected: index == 1,
              icon: const Icon(Icons.list_alt_outlined),
              onPressed: () => setState(() => index = 1),
            ),
            IconButton(
              tooltip: 'AI',
              isSelected: index == 2,
              icon: const Icon(Icons.auto_awesome_outlined),
              onPressed: () => setState(() => index = 2),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton.large(
        tooltip: 'Add',
        child: const Icon(Icons.add),
        onPressed: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(
              fullscreenDialog: true,
              builder: (_) => NewTransactionScreen(db: widget.db),
            ),
          );
        },
      ),
    );
  }
}
