import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wei_inventoryv2/features/stock/stock_controller.dart';
import 'package:wei_inventoryv2/features/stock/inventoryManager/inventory_widget.dart';
import 'package:wei_inventoryv2/core/widget/change_name_popup.dart';
class StockScreen extends ConsumerWidget {
  const StockScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 80,
            ), // Box to create padding on the top of the screen
            SizedBox(
              height: 60,
              child: Text(
                'Stock',
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                child : ListView.separated(
                  itemCount: ref.watch(stockControllerProvider).inventories.length,
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 10,
                  ),
                  itemBuilder: (context, index) => InventoryWidget(
                    index: index,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ChangeNamePopup().show(context, "Entrez le nom de l'inventaire", "", ref.watch(stockControllerProvider.notifier).addInventory);
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
