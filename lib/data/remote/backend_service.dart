import 'dart:async';
import 'dart:io';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:never_out/models/product_model.dart';

class BackendService {
  final SupabaseClient _supabaseClient = Supabase.instance.client;
  final String _tableName = 'products';

  Future<void> addProduct(ProductModel product) async {
    try {
      await _supabaseClient.from(_tableName).insert(product.toJson());
    } catch (e) {
      throw Exception('Error adding product to Supabase: $e');
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
      throw Exception('Request timed out, high network latency');
    } on SocketException {
      throw Exception('Network issue, Check internet connection or host');
    } catch (e) {
      throw Exception('Error: $e');
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
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteProduct(ProductModel product) async {
    try {
      final serverId = product.serverId;

      if (serverId == null) {
        throw Exception('Product server id has not been synced yet');
      }

      await _supabaseClient.from(_tableName).delete().eq('server_id', serverId);
    } catch (e) {
      rethrow;
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
    } catch (e) {
      rethrow;
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
    } catch (e) {
      rethrow;
    }
  }
}
