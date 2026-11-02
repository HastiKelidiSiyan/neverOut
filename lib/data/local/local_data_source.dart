import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:never_out/database/database.dart' as db;
import 'package:never_out/models/app_failure.dart';
import 'package:never_out/models/product_model.dart';
import 'package:sqlite3/sqlite3.dart' show SqlExtendedError;

class LocalDataSource {
  final db.AppDatabase _database;

  LocalDataSource(this._database);

  Future<List<ProductModel>> getProducts() async {
    final List<db.Product> dbProducts;
    try {
      dbProducts = await _database.select(_database.products).get();
    } catch (error, stackTrace) {
      debugPrint(error.toString());
      debugPrint(stackTrace.toString());
      throw const LocalDatabaseFetchFailure();
    }
    return dbProducts.map((p) => ProductModel.toProductModel(p)).toList();
  }

  Future<void> addProduct(ProductModel product) async {
    try {
      await _database
          .into(_database.products)
          .insert(_toInsertCompanion(product));
    } catch (error, stackTrace) {
      debugPrint(error.toString());
      debugPrint(stackTrace.toString());

      final cause = error is DriftWrappedException ? error.cause : error;
      if (cause is SqliteException &&
          cause.extendedResultCode ==
              SqlExtendedError.SQLITE_CONSTRAINT_UNIQUE) {
        throw const DuplicateProductFailure();
      }
      throw const LocalDatabaseSaveFailure();
    }
  }

  Future<List<ProductModel>> getPendingProducts() async {
    final List<db.Product> dbProducts;
    try {
      final query = _database.select(_database.products)
        ..where(
          (product) => product.syncStatus.equals(SyncStatus.synced.name).not(),
        );

      dbProducts = await query.get();
    } catch (error, stackTrace) {
      debugPrint(error.toString());
      debugPrint(stackTrace.toString());
      throw const LocalDatabaseFetchFailure();
    }
    return dbProducts.map((p) => ProductModel.toProductModel(p)).toList();
  }

  Future<void> updateProductSyncStatus(
    ProductModel product,
    SyncStatus syncStatus,
  ) async {
    final databaseId = product.databaseId!;

    try {
      await (_database.update(
        _database.products,
      )..where((row) => row.databaseId.equals(databaseId))).write(
        db.ProductsCompanion(
          syncStatus: Value(syncStatus.name),
        ),
      );
    } catch (error, stackTrace) {
      debugPrint(error.toString());
      debugPrint(stackTrace.toString());
      throw const LocalDatabaseSaveFailure();
    }
  }

  Future<void> updateProductServerId(ProductModel product) async {
    final databaseId = product.databaseId!;

    try {
      await (_database.update(
        _database.products,
      )..where((row) => row.databaseId.equals(databaseId))).write(
        db.ProductsCompanion(
          serverId: Value(product.serverId),
        ),
      );
    } catch (error, stackTrace) {
      debugPrint(error.toString());
      debugPrint(stackTrace.toString());
      throw const LocalDatabaseSaveFailure();
    }
  }

  Future<void> updateProduct(ProductModel product) async {
    final databaseId = product.databaseId!;

    try {
      await (_database.update(_database.products)
            ..where((row) => row.databaseId.equals(databaseId)))
          .write(_toUpdateCompanion(product));
    } catch (error, stackTrace) {
      debugPrint(error.toString());
      debugPrint(stackTrace.toString());
      
      final cause = error is DriftWrappedException ? error.cause : error;
      if (cause is SqliteException &&
          cause.extendedResultCode ==
              SqlExtendedError.SQLITE_CONSTRAINT_UNIQUE) {
        throw const DuplicateProductFailure();
      }
      throw const LocalDatabaseSaveFailure();
    }
  }

  Future<void> deleteProduct(ProductModel product) async {
    final databaseId = product.databaseId!;

    try {
      await (_database.delete(
        _database.products,
      )..where((row) => row.databaseId.equals(databaseId))).go();
    } catch (error, stackTrace) {
      debugPrint(error.toString());
      debugPrint(stackTrace.toString());
      throw const LocalDatabaseDeleteFailure();
    }
  }

  db.ProductsCompanion _toInsertCompanion(ProductModel product) {
    return db.ProductsCompanion.insert(
      databaseId: product.databaseId == null
          ? const Value.absent()
          : Value(product.databaseId!),
      serverId: product.serverId == null
          ? const Value.absent()
          : Value(product.serverId),
      name: product.name,
      updatedAt: Value(product.updatedAt),
      quantity: product.quantity,
      unitType: product.unitType.name,
      syncStatus: product.syncStatus.name,
      iconCodePoint: product.iconData.codePoint,
    );
  }

  db.ProductsCompanion _toUpdateCompanion(ProductModel product) {
    return db.ProductsCompanion(
      serverId: product.serverId == null
          ? const Value.absent()
          : Value(product.serverId),
      name: Value(product.name),
      updatedAt: Value(product.updatedAt),
      quantity: Value(product.quantity),
      unitType: Value(product.unitType.name),
      syncStatus: Value(product.syncStatus.name),
      iconCodePoint: Value(product.iconData.codePoint),
    );
  }
}
