import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key}) : super(key: key);

  final List<WarehouseItem> items = [
    WarehouseItem("Lihat Item", Icons.format_list_bulleted_rounded, Colors.lightBlue),
    WarehouseItem("Tambah Item", Icons.format_list_bulleted_add, Colors.indigo),
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
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(
            title: const Text("Warehouse Inventory"),
        ),
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

class ItemCard extends StatelessWidget{
    final WarehouseItem item;

    const ItemCard(this.item, {super.key});

    @override
    Widget build(BuildContext context){
        return Material(
            color: item.color,
            child: InkWell(
                onTap: () {
                    ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(SnackBar(
                        content: Text("Kamu telah menekan tombol ${item.name}")));
                },
                child: Container(
                    padding: const EdgeInsets.all(8),
                    child: Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                                Icon(
                                    item.icon,
                                    color: Colors.white,
                                    size: 30.0
                                ),
                                const Padding(padding: EdgeInsets.all(3)),
                                Text(
                                    item.name,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(color: Colors.white),
                                ),
                            ],
                        ),
                    ),
                ),
            ),
        );
    }
}

class WarehouseItem {
  final String name;
  final IconData icon;
  final Color color;

  WarehouseItem(this.name, this.icon, this.color);
}