import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wei_inventoryv2/features/stock/stock_controller.dart';
import 'package:wei_inventoryv2/features/stock/itemManager/inventory_screen.dart';

class InventoryWidget extends ConsumerWidget {
  const InventoryWidget({
    Key? key,
    required this.index
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: 75,
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(
              width: 5.0,
              color: ref.watch(stockControllerProvider).inventories[index].mainColor,
            ),
          ),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 7,
              offset: const Offset(
                  0, 3), // changes position of shadow
            ),
          ],
        ),
        child: TextButton(
          style: ButtonStyle(
            //Col: Colors.transparent,
            overlayColor: MaterialStateProperty.all(
              ref.watch(stockControllerProvider).inventories[index].mainColor,
            ),
          ),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => InventoryScreen(
              index: index,
            )));
          },
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(
                20, 0, 20, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "#${index + 1}",
                  style: Theme.of(context).textTheme.headline2,
                ),
                const SizedBox(
                  width: 20,
                ),
                Text(
                  ref.watch(stockControllerProvider).inventories[index].title,
                  style: Theme.of(context).textTheme.headline2,
                ),
                const Spacer(
                  flex: 1,
                ),
                Icon(
                  Icons.arrow_forward_ios_sharp,
                  size: Theme.of(context)
                      .textTheme
                      .headline2
                      ?.fontSize,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}