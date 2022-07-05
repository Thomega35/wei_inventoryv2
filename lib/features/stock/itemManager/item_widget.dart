import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wei_inventoryv2/features/stock/stock_controller.dart';
import 'package:wei_inventoryv2/core/widget/change_name_popup.dart';
class ItemWidget extends ConsumerWidget {

  const ItemWidget({
    Key? key,
    required this.itemIndex,
    required this.inventoryIndex,
  }) : super(key: key);

  final int itemIndex;
  final int inventoryIndex;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DecoratedBox(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(width: 5.0, color: ref.watch(stockControllerProvider).inventories[inventoryIndex].productsColors[itemIndex]),
          ),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(ref.watch(stockControllerProvider).inventories[inventoryIndex].products[itemIndex].name,
                style: Theme.of(context).textTheme.subtitle1,
                textAlign: TextAlign.center),
            Text(
              "Quantité : ${ref.watch(stockControllerProvider).inventories[inventoryIndex].products[itemIndex].quantity}",
              style: Theme.of(context).textTheme.headline2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment
                  .spaceEvenly, // use whichever suits your need
              children: [
                ClipOval(
                  child: Material(
                    color: Colors.white,
                    child: InkWell(
                      splashColor: ref.watch(stockControllerProvider).inventories[inventoryIndex].productsColors[itemIndex],
                      onTap: () {ref.read(stockControllerProvider.notifier).remove(context, inventoryIndex, itemIndex);},
                      child: const SizedBox(
                        width: 40,
                        height: 40,
                        child: Icon(Icons.remove, color: Colors.black),
                      ),
                    ),
                  ),
                ),
                ClipOval(
                  child: Material(
                    color: Colors.white,
                    child: InkWell(
                      splashColor: ref.watch(stockControllerProvider).inventories[inventoryIndex].productsColors[itemIndex],
                      onTap: () => ref.read(stockControllerProvider.notifier).add(inventoryIndex, itemIndex),
                      child: const SizedBox(
                        width: 40,
                        height: 40,
                        child: Icon(Icons.add, color: Colors.black),
                      ),
                    ),
                  ),
                ),
                ClipOval(
                  child: Material(
                    color: Colors.white,
                    child: InkWell(
                      splashColor: ref.watch(stockControllerProvider).inventories[inventoryIndex].productsColors[itemIndex],
                      onTap: () {
                        ChangeNamePopup().show(context, "Entrez le nom du produit",
                            ref.watch(stockControllerProvider).inventories[inventoryIndex].products[itemIndex].name, (newName) {
                              ref.read(stockControllerProvider.notifier).editName(inventoryIndex, itemIndex, newName);
                            });
                        },
                      child: const SizedBox(
                        width: 40,
                        height: 40,
                        child: Icon(Icons.edit, color: Colors.black),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
