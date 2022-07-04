import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wei_inventoryv2/features/stock/stock_state.dart';
import 'package:wei_inventoryv2/features/stock/inventoryManager/inventory.dart';
import 'package:wei_inventoryv2/core/widget/change_name_popup.dart';
import 'package:wei_inventoryv2/core/widget/delete_popup.dart';

final stockControllerProvider =
    StateNotifierProvider.autoDispose<StockController, StockState>(
  (ref) => StockController(
    const StockState(inventories: []),
  ),
);

class StockController extends StateNotifier<StockState> {
  StockController(StockState state,) : super(state);

  void addInventory(String name) {
    state = state.copyWith(
      inventories: [
        ...state.inventories,
        Inventory.initial(name),
      ],
    );
  }

  addAndRequestInventory(context) {
    ChangeNamePopup()
        .show(context, "Entrez le nom de l'inventaire", "", addInventory);
  }

  removeInventory(int index, context) {
    DeletePopup()
        .show(context, "Êtes-vous sûr de vouloir supprimer l'inventaire ?", () {
      final newInventories = state.inventories.toList();
      newInventories.removeAt(index);
      state = state.copyWith(inventories: newInventories);
    });
    Navigator.of(context).pop(context);
  }
}