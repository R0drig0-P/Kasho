import 'package:flutter/material.dart';
import 'package:drift/drift.dart' show Value;
import '../data/app_database.dart';

class NewTransactionScreen extends StatefulWidget {
  const NewTransactionScreen({super.key, required this.db});
  final AppDatabase db;

  @override
  State<NewTransactionScreen> createState() => _NewTransactionScreenState();
}

class _NewTransactionScreenState extends State<NewTransactionScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amountCtrl = TextEditingController();
  final _noteCtrl = TextEditingController();
  final DateTime _date = DateTime.now();
  TransactionType _type = TransactionType.expense;
  int? _categoryId;
  int? _accountId;

  @override
  void dispose() {
    _amountCtrl.dispose();
    _noteCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(40),
          child: Container(
            height: 40,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  FilterChip(
                    label: const Text('Manual'),
                    selected: true,
                    onSelected: (_) {},
                  ),
                  const SizedBox(width: 8),
                  FilterChip(
                    label: const Text('Photo (AI)'),
                    onSelected: (_) {
                      /* TLDR: OCR */
                    },
                  ),
                  const SizedBox(width: 8),
                  FilterChip(
                    label: const Text('Import CSV'),
                    onSelected: (_) {
                      /* TLDR */
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _amountCtrl,
                decoration: const InputDecoration(labelText: 'Value (€)'),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (v) => (v == null || double.tryParse(v) == null)
                    ? 'Enter a value'
                    : null,
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<TransactionType>(
                value: _type,
                items: const [
                  DropdownMenuItem(
                    value: TransactionType.expense,
                    child: Text('Expense'),
                  ),
                  DropdownMenuItem(
                    value: TransactionType.income,
                    child: Text('Income'),
                  ),
                ],
                onChanged: (v) =>
                    setState(() => _type = v ?? TransactionType.expense),
                decoration: const InputDecoration(labelText: 'Type'),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _noteCtrl,
                decoration: const InputDecoration(labelText: 'Description'),
              ),
              const Spacer(),
              ElevatedButton.icon(
                icon: const Icon(Icons.save),
                label: const Text('Save'),
                onPressed: () async {
                  if (!_formKey.currentState!.validate()) return;
                  final amount = double.parse(_amountCtrl.text);
                  _categoryId ??= await widget.db.insertCategory(
                    CategoriesCompanion.insert(name: 'General'),
                  );
                  _accountId ??= 1;

                  await widget.db.insertTransaction(
                    TransactionsCompanion.insert(
                      date: _date,
                      amount: amount,
                      type: _type,
                      categoryId: _categoryId!,
                      accountId: _accountId!,
                      note: Value(
                        _noteCtrl.text.isEmpty ? null : _noteCtrl.text,
                      ),
                    ),
                  );

                  if (context.mounted) Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
