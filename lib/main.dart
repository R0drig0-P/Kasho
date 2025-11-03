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
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.teal),
      home: RootShell(db: db),
    );
  }
}

class RootShell extends StatefulWidget {
  const RootShell({super.key, required this.db});
  final AppDatabase db;

  @override
  State<RootShell> createState() => RootShellState();
}

class RootShellState extends State<RootShell> {
  int index = 0; // 0: Home, 1: Transactions, 2: Kasho AI

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: index,
        children: [
          HomeScreen(db: widget.db),
          TransactionsScreen(db: widget.db),
          AILabScreen(db: widget.db),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              tooltip: 'Início',
              isSelected: index == 0,
              icon: const Icon(Icons.home_outlined),
              onPressed: () => setState(() => index = 0),
            ),
            const SizedBox(width: 48), // espaço para o FAB central
            IconButton(
              tooltip: 'IA',
              isSelected: index == 2,
              icon: const Icon(Icons.auto_awesome_outlined),
              onPressed: () => setState(() => index = 2),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton.large(
        tooltip: 'Adicionar',
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
