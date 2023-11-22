import 'package:flutter/material.dart';
import 'package:warehouse_inventory_mobile/screens/items_form.dart';
import 'package:warehouse_inventory_mobile/screens/list_item.dart';
import 'package:warehouse_inventory_mobile/screens/menu.dart';

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.lightBlue,
              ),
              child: Column(children: [
                Text(
                  'Warehouse Inventory',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Padding(padding: EdgeInsets.all(10)),
                Text("Store your items on this app!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ))
              ])),
          ListTile(
              leading: const Icon(Icons.home_outlined),
              title: const Text("Home"),
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyHomePage(),
                    ));
              }),
          ListTile(
              leading: const Icon(Icons.format_list_bulleted_add),
              title: const Text("Add Items"),
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ItemFormPage(),
                    ));
              }),
          ListTile(
              leading: const Icon(Icons.format_list_bulleted_rounded),
              title: const Text("See Items"),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ItemPage(),
                    ));
              })
        ],
      ),
    );
  }
}
