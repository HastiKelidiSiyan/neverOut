import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:never_out/providers/theme_provider.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: settingSBody(),
    );
  }

  Widget settingSBody() {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: SwitchListTile(
        title: Text("Theme:"),
        value: ref.watch(themeProvider),
        onChanged: (isDark) {
          ref.read(themeProvider.notifier).toggleTheme();
        },
      ),
    );
  }
}
