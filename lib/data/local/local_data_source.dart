import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:never_out/database/database.dart' as db;
import 'package:never_out/models/app_failure.dart';
import 'package:never_out/models/product_model.dart';

class LocalDataSource {
  LocalDataSource(this._database);

  final db.AppDatabase _database;

  Future<List<ProductModel>> getProducts() async {
    final List<db.Product> products;
    try {
      products = await _database.select(_database.products).get();
    } on DriftWrappedException catch (error, stackTrace) {
      debugPrint(error.toString());
      debugPrint(stackTrace.toString());
      throw const LocalDatabaseFetchFailure();
    }
    return products.map(_toProductModel).toList();
  }

  Future<void> addProduct(ProductModel product) async {
    try {
      await _database
          .into(_database.products)
          .insert(_toInsertCompanion(product));
    } catch (error, stackTrace) {
      debugPrint(error.toString());
      debugPrint(stackTrace.toString());
      if (_isUniqueNameConstraint(error)) {
        throw const DuplicateProductFailure();
      }
      throw const LocalDatabaseSaveFailure();
    }
  }

  Future<List<ProductModel>> getPendingProducts() async {
    final List<db.Product> products;
    try {
      final query = _database.select(_database.products)
        ..where(
          (product) => product.syncStatus.equals(SyncStatus.synced.name).not(),
        );

      products = await query.get();
    } catch (error, stackTrace) {
      debugPrint(error.toString());
      debugPrint(stackTrace.toString());
      throw const LocalDatabaseFetchFailure();
    }
    return products.map(_toProductModel).toList();
  }

  Future<void> updateProductSyncStatus(
    ProductModel product,
    SyncStatus syncStatus,
  ) async {
    final databaseId = _requireDatabaseId(product);

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
    final databaseId = _requireDatabaseId(product);

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
    final databaseId = _requireDatabaseId(product);

    try {
      await (_database.update(_database.products)
            ..where((row) => row.databaseId.equals(databaseId)))
          .write(_toUpdateCompanion(product));
    } catch (error, stackTrace) {
      debugPrint(error.toString());
      debugPrint(stackTrace.toString());
      throw const LocalDatabaseSaveFailure();
    }
  }

  Future<void> deleteProduct(ProductModel product) async {
    final databaseId = _requireDatabaseId(product);

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

  ProductModel _toProductModel(db.Product product) {
    return ProductModel(
      databaseId: product.databaseId,
      serverId: product.serverId,
      name: product.name,
      quantity: product.quantity,
      unitType: UnitType.values.byName(product.unitType),
      updatedAt: product.updatedAt,
      syncStatus: SyncStatus.values.byName(product.syncStatus),
      iconData: FaIconData(
        IconData(
          product.iconCodePoint,
          fontFamily: "FontAwesomeSolid",
          fontPackage: "font_awesome_flutter",
        ),
      ),
    );
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

  int _requireDatabaseId(ProductModel product) {
    final databaseId = product.databaseId;

    if (databaseId == null) {
      throw Exception('A local product database id is required');
    }

    return databaseId;
  }

  bool _isUniqueNameConstraint(Object error) {
    final message = error.toString().toLowerCase();
    return message.contains('unique') && message.contains('name');
  }
}
