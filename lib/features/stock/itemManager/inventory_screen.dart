import 'package:flutter/material.dart';
import 'package:wei_inventoryv2/core/widget/change_name_popup.dart';
import 'package:wei_inventoryv2/core/widget/delete_popup.dart';
import 'package:wei_inventoryv2/features/stock/itemManager/item_widget.dart';
import 'package:wei_inventoryv2/features/stock/itemManager/item.dart';
import 'package:wei_inventoryv2/core/tools.dart';

class InventoryScreen extends StatefulWidget {
  final MaterialColor mainColor;
  final MaterialColor secondColor;
  final String title;
  final VoidCallback removeInventory;
  final List<Item> products = [];
  final List<MaterialColor> productsColors = [];
  InventoryScreen({
    Key? keyI,
    required this.mainColor,
    required this.secondColor,
    required this.title,
    required this.removeInventory
  }) : super(key: keyI);
  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {

  late String name;

  @override
  initState() {
    super.initState();
    name = widget.title;
  }
  addItem(String newName){
    setState(() {
      widget.products.add(Item(name : newName, quantity : 1));
      widget.productsColors.add(Tools.randomMaterialColor());
    });
  }
  add(int index) {
    setState(() {
      widget.products[index] = widget.products[index].add();
    });
  }
  remove(int index) {
    setState(() {if (widget.products[index].quantity - 1 <= 0) {
      confirmationDeletion(index);
    } else {
      widget.products[index] = widget.products[index].remove();
    }});
  }
  renameProduct(String newName, int index) {
    setState(() {
      widget.products[index] = widget.products[index].rename(newName);
    });
  }
  renameInventory(String newName) {
    setState(() {
      name = newName;
    });
  }
  editInventoryMemberName(int index) {
    ChangeNamePopup().show(context, "Entrez le nom du produit", widget.products[index].name, (newName) {
      renameProduct(newName, index);
    });
  }
  addInventoryMember() {
    ChangeNamePopup().show(context, "Entrez le nom du produit", "", addItem);
  }
  confirmationDeletion(int index){
    DeletePopup().show(context, "Voulez-vous vraiment retirer ce produit de l'inventaire?", () {
      setState(() {
        widget.products.removeAt(index);
        widget.productsColors.removeAt(index);
      });
    });
  }
  renameAndRequestInventory() {
    ChangeNamePopup()
        .show(context, "Entrez le nom de l'inventaire", "", renameInventory);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 60,
              child : Text(
                name,
                style: Theme.of(context).textTheme.headline1,
              ),
            ), //Title of the inventory
            Row( // Row to create the buttons to rename and remove inventory
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ClipOval(
                  child: Material(
                    color: widget.mainColor,
                    child: InkWell(
                      splashColor: widget.secondColor,
                      onTap: renameAndRequestInventory,
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
                    color: widget.secondColor,
                    child: InkWell(
                      splashColor: widget.mainColor,
                      onTap: widget.removeInventory,
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
                  itemBuilder: (context, index) => ItemWidget(
                    ivm: widget.products[index],
                    myColor: widget.productsColors[index],
                    add: () => add(index),
                    remove: () => remove(index),
                    edit: () => editInventoryMemberName(index),
                  ),
                  itemCount: widget.products.length,
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
        onPressed: addInventoryMember,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}