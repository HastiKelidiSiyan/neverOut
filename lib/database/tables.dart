import 'package:drift/drift.dart';

class Products extends Table {
  IntColumn get databaseId => integer().autoIncrement()();
  IntColumn get serverId => integer().nullable()();
  TextColumn get name => text().unique()();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
  IntColumn get quantity => integer()();
  TextColumn get unitType => text()();
  TextColumn get syncStatus => text()();
  IntColumn get iconCodePoint => integer()();
}
