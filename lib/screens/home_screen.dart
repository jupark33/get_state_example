import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_state_example/screens/wish_list_screen.dart';
import 'package:get_state_example/state/products.dart';

class HomeScreen extends StatelessWidget {

  final Products _p = Get.put(Products());

  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('State Example'),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          InkWell(
            child: Container(
              width: 300,
              height: 80,
              color: Colors.red,
              alignment: Alignment.center,
              // Use Obx(()=> to update Text() whenever _wishList.items.length is changed
              child: Obx(() => Text(
                'Wish List: ${_p.wishListItems.length}',
                style: const TextStyle(fontSize: 28, color: Colors.white),
              ))
            ),
            onTap: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => WishListScreen())),
          ),

          const SizedBox(
            height: 20,
          ),

          Expanded(
              child: ListView.builder(
                itemCount: _p.items.length,
                itemBuilder: (context, index) {
                  final product = _p.items[index];
                  return Card(
                    key: ValueKey(product.id),
                    margin: EdgeInsets.all(5),
                    color: Colors.amberAccent,
                    child: ListTile(
                      title: Text(product.name),
                      subtitle: Text("\$${product.price.toStringAsFixed(2)}"),
                      // Use Obx(()=> to update icon color when product.inWishList change
                      trailing: Obx(() => IconButton(
                        onPressed: () {
                          if (product.inWishList.value == false) {
                            _p.addItem(product.id);
                          } else {
                            _p.removeItem(product.id);
                          }
                        },
                        icon: Icon(
                          Icons.favorite,
                          color: product.inWishList.value == false
                            ? Colors.white
                            : Colors.red,
                        )
                      )),

                    )
                  );
                }
              ),
          )
        ]
      )

    );
  }
}
