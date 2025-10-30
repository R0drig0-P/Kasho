import 'package:flutter/material.dart';
import '../data/app_database.dart';
import 'new_transaction_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.db});
  final AppDatabase db;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Kasho')),
      body: StreamBuilder(
        stream: db.watchLatest(),
        builder: (context, snapshot) {
          final items = snapshot.data ?? [];
          if (items.isEmpty) {
            return const Center(child: Text('No transactions yet'));
          }
          return ListView.separated(
            itemCount: items.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final t = items[index];
              final isExpense = t.type == TransactionType.expense;
              return ListTile(
                title: Text(t.note ?? t.rawDescription ?? '(sem descrição)'),
                subtitle: Text('${t.date.toLocal()}'),
                trailing: Text(
                  (isExpense ? '-' : '+') + t.amount.toStringAsFixed(2),
                  style: TextStyle(
                    color: isExpense ? Colors.red : Colors.green,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => NewTransactionScreen(db: db)),
          );
        },
      ),
    );
  }
}
