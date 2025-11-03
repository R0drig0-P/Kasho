import 'package:flutter/material.dart';
import '../data/app_database.dart';

class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({super.key, required this.db});
  final AppDatabase db;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Transactions')),
      body: StreamBuilder(
        stream: db.watchLatest(),
        builder: (context, snapshot) {
          final items = snapshot.data ?? [];
          if (items.isEmpty) {
            return const Center(child: Text('No Transactions'));
          }
          return ListView.separated(
            itemCount: items.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (context, i) {
              final t = items[i];
              final isExpense = t.type == TransactionType.expense;
              return ListTile(
                leading: CircleAvatar(child: Text(isExpense ? '−' : '+')),
                title: Text(t.note ?? '(No Description)'),
                subtitle: Text('${t.date.toLocal()}'),
                trailing: Text(
                  (isExpense ? '-' : '+') + t.amount.toStringAsFixed(2),
                  style: TextStyle(
                    color: isExpense ? Colors.red : Colors.green,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
