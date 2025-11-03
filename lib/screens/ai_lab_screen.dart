import 'package:flutter/material.dart';
import '../data/app_database.dart';

class AILabScreen extends StatelessWidget {
  const AILabScreen({super.key, required this.db});
  final AppDatabase db;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AI Lab')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          ListTile(
            leading: Icon(Icons.category_outlined),
            title: Text('Automatic Categorization'),
            subtitle: Text('Train Rules + lightweight on-device model'),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.receipt_long_outlined),
            title: Text('Receipts OCR (Photo)'),
            subtitle: Text('Extract value, date and seller'),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.chat_bubble_outline),
            title: Text('Questions About Spending'),
            subtitle: Text('"What did i spent more on this month?"'),
          ),
        ],
      ),
    );
  }
}
