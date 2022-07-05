import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wei_inventoryv2/features/stock/stock_state.dart';
import 'package:wei_inventoryv2/features/stock/inventoryManager/inventory.dart';
import 'package:wei_inventoryv2/core/widget/change_name_popup.dart';
import 'package:wei_inventoryv2/core/widget/delete_popup.dart';

import '../../core/tools.dart';
import 'itemManager/item.dart';

final stockControllerProvider =
    StateNotifierProvider.autoDispose<StockController, StockState>(
  (ref) => StockController(
    const StockState(inventories: []),
  ),
);

class StockController extends StateNotifier<StockState> {
  StockController(StockState state,) : super(state);

  void addInventory(String name) {

  }

  addAndRequestInventory(context) {
    ChangeNamePopup()
        .show(context, "Entrez le nom de l'inventaire", "", (name) {
      state = state.copyWith(
        inventories: [
          ...state.inventories,
          Inventory.initial(name),
        ],
      );
    });
  }

  renameAndRequestInventory(context, int index) {
    ChangeNamePopup()
        .show(context, "Entrez le nom de l'inventaire", state.inventories[index].title, (newName) {
      final newInventories = state.inventories;
      newInventories[index] = newInventories[index].copyWith(title: newName);
      state = state.copyWith(inventories: newInventories);
    });
  }

  removeInventory(context, int index) {
    DeletePopup()
        .show(context, "Êtes-vous sûr de vouloir supprimer l'inventaire ?", () {
      final newInventories = state.inventories;
      newInventories.removeAt(index);
      state = state.copyWith(inventories: newInventories);
      Navigator.of(context).pop(context);
    });
  }

  addInventoryMember(context,int index) {
    ChangeNamePopup().show(context, "Entrez le nom du produit", "", (newName){
      final newInventories = state.inventories;
      newInventories[index] = newInventories[index].copyWith(
        products: [
          ...newInventories[index].products,
          Item(name : newName, quantity : 1)
        ],
        productsColors: [
          ...newInventories[index].productsColors,
          Tools.randomMaterialColor()
        ],
      );
      state = state.copyWith(inventories: newInventories);
    });
  }

  remove(context, int inventoryIndex, int itemIndex){
    final newInventories = state.inventories;
    int? quantity = newInventories[inventoryIndex].products[itemIndex].quantity;
    if (quantity- 1 <= 0) {
      DeletePopup().show(context, "Voulez-vous vraiment retirer ce produit de l'inventaire?", () {
        newInventories[inventoryIndex].products.removeAt(itemIndex);
        newInventories[inventoryIndex].productsColors.removeAt(itemIndex);
        state = state.copyWith(inventories: newInventories);
      });
    } else {
      newInventories[inventoryIndex].products[itemIndex] = newInventories[inventoryIndex].products.toList()[itemIndex].remove();
      state = state.copyWith(inventories: newInventories);
    }
  }

  add(int inventoryIndex, int itemIndex){
    final newInventories = state.inventories;
    newInventories[inventoryIndex].products[itemIndex] = newInventories[inventoryIndex].products[itemIndex].add();
    state = state.copyWith(inventories: newInventories);
  }

  editItemName(context, int inventoryIndex, int itemIndex) {
    ChangeNamePopup().show(context, "Entrez le nom du produit",
      state.inventories[inventoryIndex].products[itemIndex].name, (newName) {
        final newInventories = state.inventories;
        newInventories[inventoryIndex].products[itemIndex] = newInventories[inventoryIndex].products[itemIndex].rename(newName);
        state = state.copyWith(inventories: newInventories);
      });
  }
}