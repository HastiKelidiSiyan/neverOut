import 'dart:async';
import 'dart:io';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:never_out/models/product.dart';

class BackendService {
  final SupabaseClient _supabaseClient = Supabase.instance.client;
  final String _tableName = 'products';

  Future<void> addProduct(Product product) async {
    try {
      await _supabaseClient.from(_tableName).insert(product.toJson());
    } catch (e) {
      throw Exception('Error adding product to Supabase: $e');
    }
  }

  Future<List<Product>> fetchProducts() async {
    try {
      final response = await _supabaseClient
          .from(_tableName)
          .select('*')
          .timeout(
            Duration(seconds: 30),
          );
      final List<Product> products = (response as List<dynamic>)
          .map((json) => Product.fromJson(json))
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

  Future<void> updateProduct(Product product) async {
    try {
      await _supabaseClient
          .from(_tableName)
          .update(product.toJson())
          .eq('server_id', product.serverId!);
      print('Product updated in Supabase successfully!');
    } catch (e) {
      print('Error updating product in Supabase: $e');
      rethrow;
    }
  }

  Future<void> deleteProduct(Product product) async {
    try {
      await _supabaseClient
          .from(_tableName)
          .delete()
          .eq('server_id', product.serverId!);
      print('Product deleted from Supabase successfully!');
    } catch (e) {
      print('Error deleting product from Supabase: $e');
      rethrow;
    }
  }

  Future<Product> getProduct(Product product) async {
    try {
      final data = await _supabaseClient
          .from(_tableName)
          .select()
          .eq('database_id', product.databaseId!)
          .single();

      return Product.fromJson(data);
    } catch (e) {
      rethrow;
    }
  }
}
