import 'package:flutter/material.dart';
import 'package:wei_inventoryv2/features/stock/inventoryManager/inventory.dart';

@immutable
class StockState {
  final List<Inventory> inventories;
  const StockState({
    required this.inventories,
  });

  StockState copyWith({
    List<Inventory>? inventories,
  }) {
    return StockState(
      inventories: inventories ?? this.inventories,
    );
  }

  @override
  String toString() => 'StockState{inventories: $inventories}';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StockState &&
          inventories == other.inventories;

  @override
  int get hashCode => inventories.hashCode;

}