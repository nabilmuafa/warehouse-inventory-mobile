import 'package:flutter/material.dart';
import 'package:warehouse_inventory_mobile/widgets/item_card.dart';
import 'package:warehouse_inventory_mobile/widgets/left_drawer.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key}) : super(key: key);

  final List<WarehouseItem> items = [
    WarehouseItem(
        "Items List", Icons.format_list_bulleted_rounded, Colors.lightBlue),
    WarehouseItem("Add Item", Icons.format_list_bulleted_add, Colors.indigo),
    WarehouseItem("Logout", Icons.logout_rounded, Colors.pink.shade300),
  ];

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Warehouse Inventory"),
      ),
      drawer: const LeftDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Text(
                  "Warehouse Inventory",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              GridView.count(
                primary: true,
                // padding
                padding: const EdgeInsets.all(20),
                // gap
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                // count
                crossAxisCount: 3,
                shrinkWrap: true,
                children: items.map((WarehouseItem item) {
                  return ItemCard(item);
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
