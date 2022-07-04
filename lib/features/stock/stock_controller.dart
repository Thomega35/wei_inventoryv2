import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wei_inventoryv2/features/stock/stock_state.dart';

final stockControllerProvider =
    StateNotifierProvider<StockController, StockState>(
  (ref) => StockController(
    const StockState(inventories: []),
  ),
);

class StockController extends StateNotifier<StockState> {
  StockController(
    StockState state,
  ) : super(state);


}
