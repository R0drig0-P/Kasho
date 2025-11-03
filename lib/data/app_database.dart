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
}

LazyDatabase openConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, 'money_manager.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
