import 'package:flutter/material.dart';
import 'package:wei_inventoryv2/theme/custom_theme.dart';
import 'package:wei_inventoryv2/features/stock/inventoryManager/stock_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Thomas\' Inventory',
      theme: CustomTheme.lightTheme(context),
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => const StockScreen(),
      },
    );
  }
}