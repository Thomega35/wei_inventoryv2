import 'package:flutter/material.dart';
import 'package:wei_inventoryv2/core/tools.dart';
import 'package:wei_inventoryv2/features/stock/itemManager/item.dart';

@immutable
class Inventory{
  final String title;
  final MaterialColor mainColor;
  final MaterialColor secondColor;
  final List<Item>? products;
  final List<MaterialColor>? productsColors;

  const Inventory({
    required this.title,
    required this.mainColor,
    required this.secondColor,
    this.products,
    this.productsColors,
  });

  Inventory.initial(String name):
      title = name,
      mainColor = Tools.randomMaterialColor(),
      secondColor = Tools.randomMaterialColor(),
      products = [],
      productsColors = [];

  @override
  String toString() => 'Inventory{title: $title, mainColor: $mainColor, secondColor: $secondColor, products: $products, productsColors: $productsColors}';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Inventory &&
          title == other.title &&
          mainColor == other.mainColor &&
          secondColor == other.secondColor &&
          products == other.products &&
          productsColors == other.productsColors;

  @override
  int get hashCode =>
      title.hashCode ^
      mainColor.hashCode ^
      secondColor.hashCode ^
      products.hashCode ^
      productsColors.hashCode;
}