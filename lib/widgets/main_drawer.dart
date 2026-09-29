import 'package:flutter/material.dart';
import 'package:never_out/screens/settings_screen.dart';
import 'package:never_out/ui/app_feedback.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});


  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            padding: EdgeInsetsGeometry.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.primaryContainer,
                  Theme.of(
                    context,
                  ).colorScheme.primaryContainer.withValues(alpha: 0.8),
                ],
                begin: AlignmentGeometry.topLeft,
                end: AlignmentGeometry.bottomRight,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.lightbulb,
                  size: 48,
                  color: Theme.of(context).colorScheme.primary,
                ),
                SizedBox(
                  width: 18,
                ),
                Text(
                  'Never missout!',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 650),
            child: ListTile(
              leading: Icon(
                Icons.settings,
                size: 26,
                color: Theme.of(context).colorScheme.onBackground,
              ),
              title: Text(
                'Settings',
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                  fontSize: 24,
                ),
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => SettingsScreen(),));
              },
            ),
          ),
        ],
      ),
    );
  }
}
