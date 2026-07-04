import 'package:flutter/material.dart';
import 'package:never_out/app/my_app.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://xzlrthumnkfdiwxkryqv.supabase.co',
    publishableKey: 'sb_publishable_FGm_ldXKL26m9wkjqMf4Ag_NLTWc-_B',
  );

  runApp(
    ProviderScope(
      child: const MyApp(),
    ),
  );
}
