import 'package:flutter/material.dart';
import 'package:never_out/providers/products_provider.dart';
import 'package:never_out/screens/products.dart';
import 'package:never_out/screens/ran_out.dart';
import 'package:never_out/theme/app_colors.dart';

class Tabs extends StatefulWidget {
  const Tabs({
    super.key,
  });

  @override
  State<Tabs> createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  int selectedPageIndex = 0;

  void _selectScreen(index) {
    setState(() {
      selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appColors = theme.extension<AppThemeColors>()!;
    final productsProvider = ProductsProviderScope.watch(context);

    var activePage = 'RanOut';
    Widget activeScreen = const RanOutScreen();

    if (selectedPageIndex == 1) {
      activeScreen = const ProductsScreen();
      activePage = 'Products';
    }

    Color appBarColor() {
      if (activePage == 'RanOut') {
        return appColors.ranOutAppBarBackground;
      }
      return appColors.appBarBackground;
    }

    void sync() async {
      await productsProvider.syncProducts();
    }

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: productsProvider.isSyncing ? null : sync,
            icon: Icon(Icons.sync),
          ),
        ],
        title: Text(
          activePage,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: appBarColor(),
      ),
      body: activeScreen,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: appBarColor(),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.warning), label: 'Ran Out'),
          BottomNavigationBarItem(icon: Icon(Icons.inbox), label: 'Normal'),
        ],
        onTap: (index) {
          _selectScreen(index);
        },
        currentIndex: selectedPageIndex,
      ),
    );
  }
}
