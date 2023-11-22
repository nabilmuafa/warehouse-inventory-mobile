import "package:flutter/material.dart";
import "package:warehouse_inventory_mobile/models/item.dart";

class ItemDetailPage extends StatelessWidget {
  final Item item;

  const ItemDetailPage(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Item Detail")),
        body: SingleChildScrollView(
            child: Container(
                padding: const EdgeInsets.all(10.0),
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      item.fields.name,
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                        fontSize: 32.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Jumlah: ${item.fields.amount}",
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          item.fields.description,
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                            fontSize: 18.0,
                          ),
                        )),
                  ],
                ))));
  }
}
