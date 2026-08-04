import 'dart:async';
import 'dart:io';

import 'package:flutter/rendering.dart';
import 'package:never_out/models/app_failure.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:never_out/models/product_model.dart';

class BackendService {
  final SupabaseClient _supabaseClient = Supabase.instance.client;
  final String _tableName = 'products';

  Future<void> addProduct(ProductModel product) async {
    try {
      await _supabaseClient.from(_tableName).insert(product.toJson());
    } on TimeoutException {
      throw const TimeoutFailure();
    } on SocketException {
      throw const NetworkFailure();
    } catch (e, stackTrace) {
      debugPrint(e.toString());
      debugPrint(stackTrace.toString());
      throw const UnknownFailure();
    }
  }

  Future<List<ProductModel>> fetchProducts() async {
    try {
      final response = await _supabaseClient
          .from(_tableName)
          .select('*')
          .timeout(
            Duration(seconds: 30),
          );
      final List<ProductModel> products = (response as List<dynamic>)
          .map((json) => ProductModel.fromJson(json))
          .toList();
      return products;
    } on TimeoutException {
      throw const TimeoutFailure();
    } on SocketException {
      throw const NetworkFailure();
    } catch (e, stackTrace) {
      debugPrint(e.toString());
      debugPrint(stackTrace.toString());
      throw const UnknownFailure();
    }
  }

  Future<void> updateProduct(ProductModel product) async {
    try {
      final serverId = product.serverId;

      if (serverId == null) {
        throw Exception('Product server id has not been synced yet');
      }

      await _supabaseClient
          .from(_tableName)
          .update(product.toJson())
          .eq('server_id', serverId);
    } on TimeoutException {
      throw const TimeoutFailure();
    } on SocketException {
      throw const NetworkFailure();
    } catch (e, stackTrace) {
      debugPrint(e.toString());
      debugPrint(stackTrace.toString());
      throw const UnknownFailure();
    }
  }

  Future<void> deleteProduct(ProductModel product) async {
    try {
      final serverId = product.serverId;

      if (serverId == null) {
        throw Exception('Product server id has not been synced yet');
      }

      await _supabaseClient.from(_tableName).delete().eq('server_id', serverId);
    } on TimeoutException {
      throw const TimeoutFailure();
    } on SocketException {
      throw const NetworkFailure();
    } catch (e, stackTrace) {
      debugPrint(e.toString());
      debugPrint(stackTrace.toString());
      throw const UnknownFailure();
    }
  }

  Future<ProductModel> getProduct(ProductModel product) async {
    try {
      final data = await _supabaseClient
          .from(_tableName)
          .select()
          .eq('database_id', product.databaseId!)
          .single();

      return ProductModel.fromJson(data);
    } on TimeoutException {
      throw const TimeoutFailure();
    } on SocketException {
      throw const NetworkFailure();
    } catch (e, stackTrace) {
      debugPrint(e.toString());
      debugPrint(stackTrace.toString());
      throw const UnknownFailure();
    }
  }

  Future<ProductModel?> findProduct(ProductModel product) async {
    try {
      final data = await _supabaseClient
          .from(_tableName)
          .select()
          .eq('database_id', product.databaseId!)
          .limit(1);

      if (data.isEmpty) {
        return null;
      }

      return ProductModel.fromJson(data.first);
    } on TimeoutException {
      throw const TimeoutFailure();
    } on SocketException {
      throw const NetworkFailure();
    } catch (e, stackTrace) {
      debugPrint(e.toString());
      debugPrint(stackTrace.toString());
      throw const UnknownFailure();
    }
  }
}
