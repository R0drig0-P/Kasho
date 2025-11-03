import 'package:flutter/material.dart';
import '../data/app_database.dart';
import 'new_transaction_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.db});
  final AppDatabase db;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true,
          title: const Text('Kasho'),
          actions: [
            IconButton(
              tooltip: 'Shortcuts',
              onPressed: () {},
              icon: const Icon(Icons.tune),
            ),
          ],
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Card(
                  elevation: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'This Month',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        _MonthlySummary(db: db),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            FilledButton.tonal(
                              onPressed: () async {
                                await Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        NewTransactionScreen(db: db),
                                  ),
                                );
                              },
                              child: const Text('Add Expense'),
                            ),
                            const SizedBox(width: 8),
                            OutlinedButton(
                              onPressed: () {},
                              child: const Text('See Report'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Fast Aceess',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                _QuickActions(db: db),
                const SizedBox(height: 16),
                const Text(
                  'Recent',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ),
        // Recent Transactions List
        StreamBuilder(
          stream: db.watchLatest(),
          builder: (context, snapshot) {
            final items = snapshot.data ?? [];
            if (items.isEmpty) {
              return const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(24.0),
                  child: Center(child: Text('No transactions yet')),
                ),
              );
            }
            return SliverList.separated(
              itemCount: items.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, i) {
                final t = items[i];
                final isExpense = t.type == TransactionType.expense;
                return ListTile(
                  title: Text(t.note ?? t.rawDescription ?? '(no description)'),
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
      ],
    );
  }
}

class _MonthlySummary extends StatelessWidget {
  const _MonthlySummary({required this.db});
  final AppDatabase db;

  @override
  Widget build(BuildContext context) {
    // Placeholder for now (calculate via query)
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        _KPI(label: 'Expenses', value: '—'),
        _KPI(label: 'Income', value: '—'),
        _KPI(label: 'Balance', value: '—'),
      ],
    );
  }
}

class _KPI extends StatelessWidget {
  const _KPI({required this.label, required this.value});
  final String label;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 2),
        Text(label, style: const TextStyle(color: Colors.grey)),
      ],
    );
  }
}

class _QuickActions extends StatelessWidget {
  const _QuickActions({required this.db});
  final AppDatabase db;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 4,
      shrinkWrap: true,
      children: [
        _QuickBtn(
          icon: Icons.fastfood,
          label: 'Coffee',
          onTap: () async {
            await Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => NewTransactionScreen(db: db)),
            );
          },
        ),
        _QuickBtn(
          icon: Icons.directions_bus,
          label: 'Transp.',
          onTap: () async {
            await Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => NewTransactionScreen(db: db)),
            );
          },
        ),
        _QuickBtn(
          icon: Icons.shopping_cart,
          label: 'Market',
          onTap: () async {
            await Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => NewTransactionScreen(db: db)),
            );
          },
        ),
        _QuickBtn(
          icon: Icons.receipt_long,
          label: 'AI Receipt',
          onTap: () async {
            // TLDR: open OCR screen
          },
        ),
      ],
    );
  }
}

class _QuickBtn extends StatelessWidget {
  const _QuickBtn({
    required this.icon,
    required this.label,
    required this.onTap,
  });
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Icon(icon), const SizedBox(height: 6), Text(label)],
      ),
    );
  }
}
