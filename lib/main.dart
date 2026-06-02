import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:never_out/app/my_app.dart';
import 'package:never_out/data/local/database_service.dart';
import 'package:never_out/data/remote/backend_service.dart';
import 'package:never_out/providers/products_provider.dart';
import 'package:never_out/repositories/product_repository.dart';
import 'package:never_out/services/sync_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://xzlrthumnkfdiwxkryqv.supabase.co',
    anonKey: 'sb_publishable_FGm_ldXKL26m9wkjqMf4Ag_NLTWc-_B',
  );
  
  final syncService = SyncService(
    connectivity: Connectivity(),
    databaseService: DatabaseService(),
    backendService: BackendService(),
  );

  syncService.startListening();

  final productRepository = ProductRepository();
  final productsProvider = ProductsProvider(productRepository);

  unawaited(productsProvider.loadProducts());

  runApp(
    ProductsProviderScope(
      provider: productsProvider,
      child: const MyApp(),
    ),
  );
}
