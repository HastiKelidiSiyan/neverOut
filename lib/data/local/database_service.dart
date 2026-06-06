import 'package:never_out/models/product.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static final DatabaseService _databaseService = DatabaseService._internal();

  factory DatabaseService() => _databaseService;

  DatabaseService._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    var path = await getDatabasesPath();
    return openDatabase(
      join(path, 'products_database.db'),
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE products (server_id INTEGER, database_id TEXT PRIMARY KEY, name TEXT UNIQUE, updated_at TEXT, quantity INTEGER, unit_type TEXT, sync_status TEXT)',
        );
      },
      version: 1,
    );
  }

  Future<List<Product>> products() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('products');
    return List.generate(
      maps.length,
      (index) {
        return Product.fromMap(maps[index]);
      },
    );
  }

  Future<void> addProduct(Product product) async {
    final db = await database;
    try {
      await db.insert(
        "products",
        product.toMap(),
        conflictAlgorithm: ConflictAlgorithm.fail,
      );
    } on DatabaseException {
      throw Exception('A Product with such name already exists');
    } catch (ee) {
      print('salam');
    }
  }

  Future<List<Product>> getPendingProducts() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'products',
      where: 'sync_status != ?',
      whereArgs: ['synced'],
    );

    return List.generate(
      maps.length,
      (index) {
        return Product.fromMap(maps[index]);
      },
    );
  }

  Future<void> updateProductSyncStatus(Product product) async {
    final db = await database;
    await db.update(
      'products',
      {
        'sync_status': 'synced',
      },
      where: 'database_id = ?',
      whereArgs: [product.databaseId],
    );
  }

  Future<void> updateProductServerId(Product product) async {
    final db = await database;
    await db.update(
      'products',
      {
        'server_id': product.serverId,
      },
      where: 'database_id = ?',
      whereArgs: [product.databaseId],
    );
  }

  Future<void> updateProduct(Product product) async {
    final db = await database;
    final productMap = product.toMap();

    if (product.serverId == null) {
      productMap.remove('server_id');
    }

    await db.update(
      'products',
      productMap,
      where: 'database_id = ?',
      whereArgs: [product.databaseId],
    );
  }

  Future<void> deleteProduct(Product product) async {
    final db = await database;
    await db.delete(
      'products',
      where: 'database_id = ?',
      whereArgs: [product.databaseId],
    );
  }
}
