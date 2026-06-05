import 'package:uuid/uuid.dart';

enum UnitType { kilogram, liter, piece, box }

enum SyncStatus {
  synced,
  pendingCreate,
  pendingUpdate,
  pendingDelete,
}

final uuid = Uuid();

class Product {
  Product({
    this.serverId,
    String? databaseId,
    required this.name,
    required this.quantity,
    required this.unitType,
    DateTime? updatedAt,
    required this.syncStatus,
  }) : updatedAt = updatedAt ?? DateTime.now(),
       databaseId = databaseId ?? uuid.v4();

  int? serverId;
  final String? databaseId;
  final String name;
  final int quantity;
  final UnitType unitType;
  DateTime? updatedAt;
  final SyncStatus syncStatus;

  bool get isLow => quantity <= 1;

  Map<String, dynamic> toMap() => {
    'server_id': serverId,
    'database_id': databaseId,
    'name': name,
    'quantity': quantity,
    'unit_type': unitType.name,
    'updated_at': updatedAt!.toUtc().toIso8601String(),
    'sync_status': syncStatus.name
  };

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      serverId: map['server_id'],
      databaseId: map['database_id'].toString(),
      name: map['name'].toString(),
      quantity: map['quantity'].toInt(),
      unitType: UnitType.values.firstWhere(
        (e) => e.name == map['unit_type'],
      ),
      updatedAt: DateTime.parse(
        map['updated_at'],
      ),
      syncStatus: SyncStatus.values.firstWhere(
        (status) => status.name == map['sync_status'],
      ),
    );
  }

  Map<String, dynamic> toJson() => {
    'database_id': databaseId,
    'name': name,
    'quantity': quantity,
    'unit_type': unitType.name,
    'updated_at': updatedAt!.toUtc().toIso8601String(),
  };

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      serverId: json['server_id'],
      databaseId: json['database_id'].toString(),
      name: json['name'].toString(),
      quantity: json['quantity'].toInt(),
      unitType: UnitType.values.firstWhere(
        (e) => e.name == json['unit_type'],
      ),
      updatedAt: DateTime.parse(
        json['updated_at'],
      ),
      syncStatus: SyncStatus.synced,
    );
  }
}
