import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'app_database.g.dart';

class Categories extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get icon => text().nullable()();
  TextColumn get color => text().nullable()();
}

class Accounts extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get type => text().withDefault(const Constant('wallet'))();
}

enum TransactionType { expense, income }

class Transactions extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get date => dateTime()();
  RealColumn get amount => real()();
  TextColumn get type => textEnum<TransactionType>()();
  IntColumn get categoryId => integer().references(Categories, #id)();
  IntColumn get accountId => integer().references(Accounts, #id)();
  TextColumn get note => text().nullable()();
  TextColumn get rawDescription => text().nullable()();
  DateTimeColumn get createdAt =>
      dateTime().clientDefault(() => DateTime.now())();
}

@DriftDatabase(tables: [Categories, Accounts, Transactions])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(openConnection());

  @override
  int get schemaVersion => 1;

  // minimum CRUD helpers
  Future<int> insertTransaction(TransactionsCompanion entry) =>
      into(transactions).insert(entry);
  Stream<List<Transaction>> watchLatest() =>
      (select(transactions)
            ..orderBy([(t) => OrderingTerm.desc(t.date)])
            ..limit(50))
          .watch();

  Future<List<Category>> getAllCategories() => select(categories).get();
  Future<int> insertCategory(CategoriesCompanion c) =>
      into(categories).insert(c);

  Stream<MonthlyKPIs> watchMonthlyKPIs({DateTime? month}) {
    final now = DateTime.now();
    final start = DateTime((month ?? now).year, (month ?? now).month, 1);
    final end = DateTime(start.year, start.month + 1, 1);

    final q = customSelect(
      '''
      SELECT
      SUM(CASE WHEN type = 'expense' THEN amount ELSE 0 END) AS expenses,
      SUM(CASE WHEN type = 'income'  THEN amount ELSE 0 END) AS incomes
    FROM transactions
    WHERE date >= ? AND date < ?
    ''',
      variables: [Variable<DateTime>(start), Variable<DateTime>(end)],
      readsFrom: {transactions},
    ).watch();

    return q.map((rows) {
      final r = rows.isNotEmpty ? rows.first : null;
      final exp = (r?.data['expenses'] as num?)?.toDouble() ?? 0.0;
      final inc = (r?.data['incomes'] as num?)?.toDouble() ?? 0.0;
      return MonthlyKPIs(expenses: exp, incomes: inc);
    });
  }
}

class MonthlyKPIs {
  final double expenses;
  final double incomes;
  const MonthlyKPIs({required this.expenses, required this.incomes});
  double get balance => incomes - expenses;
}

LazyDatabase openConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, 'money_manager.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
