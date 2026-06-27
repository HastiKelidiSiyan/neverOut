enum UnitType { kilogram, liter, piece, box }

enum SyncStatus { synced, pendingCreate, pendingUpdate, pendingDelete, deleted }

class ProductModel {
  ProductModel({
    this.serverId,
    this.databaseId,
    required this.name,
    required this.quantity,
    required this.unitType,
    DateTime? updatedAt,
    required this.syncStatus,
  }) : updatedAt = updatedAt ?? DateTime.now();

  int? serverId;
  int? databaseId;
  final String name;
  final int quantity;
  final UnitType unitType;
  final DateTime updatedAt;
  final SyncStatus syncStatus;

  bool get isLow => quantity <= 1;

  Map<String, dynamic> toMap() => {
    'server_id': serverId,
    'database_id': databaseId,
    'name': name,
    'quantity': quantity,
    'unit_type': unitType.name,
    'updated_at': updatedAt,
    'sync_status': syncStatus.name,
  };

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      serverId: _optionalInt(map['server_id']),
      databaseId: _optionalInt(map['database_id']),
      name: map['name'].toString(),
      quantity: _requiredInt(map['quantity'], 'quantity'),
      unitType: UnitType.values.byName(map['unit_type'].toString()),
      updatedAt: _dateTime(map['updated_at']),
      syncStatus: SyncStatus.values.byName(map['sync_status'].toString()),
    );
  }

  Map<String, dynamic> toJson() => {
    'database_id': databaseId,
    'name': name,
    'quantity': quantity,
    'unit_type': unitType.name,
    'updated_at': updatedAt.toUtc().toIso8601String(),
  };

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      serverId: _optionalInt(json['server_id']),
      databaseId: _optionalInt(json['database_id']),
      name: json['name'].toString(),
      quantity: _requiredInt(json['quantity'], 'quantity'),
      unitType: UnitType.values.byName(json['unit_type'].toString()),
      updatedAt: _dateTime(json['updated_at']),
      syncStatus: SyncStatus.synced,
    );
  }
}

int? _optionalInt(Object? value) {
  if (value == null) {
    return null;
  }

  if (value is int) {
    return value;
  }

  if (value is num) {
    return value.toInt();
  }

  return int.tryParse(value.toString());
}

int _requiredInt(Object? value, String fieldName) {
  final parsedValue = _optionalInt(value);

  if (parsedValue == null) {
    throw FormatException('Invalid integer value for $fieldName: $value');
  }

  return parsedValue;
}

DateTime _dateTime(Object? value) {
  if (value is DateTime) {
    return value;
  }

  if (value == null) {
    return DateTime.now();
  }

  return DateTime.parse(value.toString());
}
