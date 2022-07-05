import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wei_inventoryv2/features/stock/stock_state.dart';
import 'package:wei_inventoryv2/features/stock/inventoryManager/inventory.dart';
import 'package:wei_inventoryv2/core/widget/delete_popup.dart';
import 'package:wei_inventoryv2/core/tools.dart';
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
    state = state.copyWith(
      inventories: [
        ...state.inventories,
        Inventory.initial(name),
      ],
    );
  }

  renameInventory(int index, String name) {
    final newInventories = state.inventories;
    newInventories[index] = newInventories[index].copyWith(title: name);
    state = state.copyWith(inventories: newInventories);
  }

  removeInventory(int index) {
    final newInventories = state.inventories;
    newInventories.removeAt(index);
    state = state.copyWith(inventories: newInventories);
  }

  addItem(int index, String name) {
    final newInventories = state.inventories;
    newInventories[index] = newInventories[index].copyWith(
      products: [
        ...newInventories[index].products,
        Item(name : name, quantity : 1)
      ],
      productsColors: [
        ...newInventories[index].productsColors,
        Tools.randomMaterialColor()
      ],
    );
    state = state.copyWith(inventories: newInventories);
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

  editName(int inventoryIndex, int itemIndex, String newName){
    final newInventories = state.inventories;
    newInventories[inventoryIndex].products[itemIndex] = newInventories[inventoryIndex].products[itemIndex].rename(newName);
    state = state.copyWith(inventories: newInventories);
  }
}