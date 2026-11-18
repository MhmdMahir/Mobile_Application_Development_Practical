
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:practical_5/model_class/cart_provider.dart';
import 'package:practical_5/model_class/item.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        centerTitle: true,
      ),
      body: const CartListWidget(),
    );
  }
}

class CartListWidget extends StatelessWidget {
  const CartListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, cart, child) {
        if (cart.itemList.isEmpty) {
          return const Center(
            child: Text(
              'Cart is Empty',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.all(8.0),
          itemCount: cart.itemList.length,
          separatorBuilder: (context, index) =>
          const Divider(),
          itemBuilder: (context, index) {
            return CartItem(
              item: cart.itemList[index],
            );
          },
        );
      },
    );
  }
}

class CartItem extends StatelessWidget {
  final Item item;

  const CartItem({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        item.toString(),
        style: const TextStyle(
          fontSize: 16,
        ),
      ),
      trailing: TextButton(
        onPressed: () {
          Provider.of<CartProvider>(
            context,
            listen: false,
          ).remove(item);
        },
        child: const Text(
          'Remove',
          style: TextStyle(
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}
