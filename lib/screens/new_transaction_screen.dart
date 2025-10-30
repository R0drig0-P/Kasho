import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import '../data/app_database.dart';

class NewTransactionScreen extends StatefulWidget {
  const NewTransactionScreen({super.key, required this.db});
  final AppDatabase db;

  @override
  State<NewTransactionScreen> createState() => NewTransactionScreenState();
}

class NewTransactionScreenState extends State<NewTransactionScreen> {
  final formKey = GlobalKey<FormState>();
  final amountCtrl = TextEditingController();
  final noteCtrl = TextEditingController();
  DateTime date = DateTime.now();
  TransactionType type = TransactionType.expense;
  int? categoryId;
  int? accountId;

  @override
  void dispose() {
    amountCtrl.dispose();
    noteCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nova Transação')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: amountCtrl,
                decoration: const InputDecoration(labelText: 'Valor (€)'),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (v) => (v == null || double.tryParse(v) == null)
                    ? 'Introduz um valor'
                    : null,
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<TransactionType>(
                initialValue: type,
                items: const [
                  DropdownMenuItem(
                    value: TransactionType.expense,
                    child: Text('Despesa'),
                  ),
                  DropdownMenuItem(
                    value: TransactionType.income,
                    child: Text('Receita'),
                  ),
                ],
                onChanged: (v) =>
                    setState(() => type = v ?? TransactionType.expense),
                decoration: const InputDecoration(labelText: 'Tipo'),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: noteCtrl,
                decoration: const InputDecoration(labelText: 'Nota/Descrição'),
              ),
              const Spacer(),
              ElevatedButton.icon(
                icon: const Icon(Icons.save),
                label: const Text('Guardar'),
                onPressed: () async {
                  if (!formKey.currentState!.validate()) return;
                  final amount = double.parse(amountCtrl.text);

                  // fallback simples para categorias/contas enquanto não há UI
                  categoryId ??= await widget.db.insertCategory(
                    CategoriesCompanion.insert(name: 'Geral'),
                  );
                  accountId ??= 1; // em breve criamos ecrã de contas

                  await widget.db.insertTransaction(
                    TransactionsCompanion.insert(
                      date: date,
                      amount: amount,
                      type: type,
                      categoryId: categoryId!,
                      accountId: accountId!,
                      note: Value(noteCtrl.text.isEmpty ? null : noteCtrl.text),
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
