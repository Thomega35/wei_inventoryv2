import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'ChangeNamePopUp.dart';
import 'InventoryPage.dart';
import 'package:wei_inventoryv2/theme/custom_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Thomas Inventory',
      theme: CustomTheme.lightTheme(context),
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => const MyHomePage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  static MaterialColor randomMaterialColor() {
    return Colors.primaries[Random().nextInt(Colors.primaries.length)];
  }

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<InventoryPage> inventories = [];

  addInventory(String newName) {
    setState(() {
      inventories.add(InventoryPage(
        mainColor: MyHomePage.randomMaterialColor(),
        secondColor: MyHomePage.randomMaterialColor(),
        title: newName,
        removeInventory: () => removeInventory(inventories.length-1),
      ));
    });
  }
  addAndRequestInventory() {
    ChangeNamePopUp()
        .show(context, "Entrez le nom de l'inventaire", "", addInventory);
  }
  removeInventory(int index) {
    setState(() {
      inventories.removeAt(index);
    });
    Navigator.of(context).pop(context);
  }
  @override
  Widget build(BuildContext context) {
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
            ), //Title of the App
            Expanded(
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                child: ListView.separated(
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 10,
                  ),
                  itemBuilder: (context, index) => SizedBox(
                    height: 75,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        border: Border(
                          left: BorderSide(
                              width: 5.0, color: inventories[index].mainColor),
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
                              inventories[index].mainColor),
                        ),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => inventories[index]));
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
                                inventories[index].title,
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
                  ),
                  itemCount: inventories.length,
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addAndRequestInventory,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
