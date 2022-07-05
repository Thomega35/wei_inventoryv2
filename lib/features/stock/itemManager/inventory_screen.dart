import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wei_inventoryv2/features/stock/itemManager/item_widget.dart';
import 'package:wei_inventoryv2/features/stock/stock_controller.dart';

class InventoryScreen extends ConsumerWidget {
  const InventoryScreen({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 60,
              child : Text(
                ref.watch(stockControllerProvider).inventories[index].title,
                style: Theme.of(context).textTheme.headline1,
              ),
            ), //Title of the inventory
            Row( // Row to create the buttons to rename and remove inventory
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ClipOval(
                  child: Material(
                    color: ref.watch(stockControllerProvider).inventories[index].mainColor,
                    child: InkWell(
                      splashColor: ref.watch(stockControllerProvider).inventories[index].secondColor,
                      onTap: () {ref.read(stockControllerProvider.notifier).renameAndRequestInventory(context,index);},
                      child: const SizedBox(
                        width: 40,
                        height: 40,
                        child : Icon(Icons.edit, color: Colors.black),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                  height: 60,
                ),
                ClipOval(
                  child: Material(
                    color: ref.watch(stockControllerProvider).inventories[index].secondColor,
                    child: InkWell(
                      splashColor: ref.watch(stockControllerProvider).inventories[index].mainColor,
                      onTap: () {ref.read(stockControllerProvider.notifier).removeInventory(context, index);},
                      child: const SizedBox(
                        width: 40,
                        height: 40,
                        child : Icon(Icons.delete, color: Colors.black),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                child: GridView.builder(
                  itemBuilder: (context, itemIndex) => ItemWidget(
                    inventoryIndex : index,
                    itemIndex : itemIndex,
                  ),
                  itemCount: ref.watch(stockControllerProvider).inventories[index].products.length,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    childAspectRatio: 5/4,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {ref.watch(stockControllerProvider.notifier).addInventoryMember(context, index);},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}