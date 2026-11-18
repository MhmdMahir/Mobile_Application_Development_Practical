import 'package:flutter/material.dart';
import 'package:practical_5/model_class/cart_provider.dart';
import 'package:practical_5/model_class/item.dart';
import 'package:provider/provider.dart';
import 'package:practical_5/cart.dart';

final List<Item> catalog = [
  Item(1, 'Shoes'),
  Item(2, 'Hats'),
  Item(3, 'Shits'),
  Item(4, 'Tie'),
  Item(5, 'Pants'),
  Item(6, 'Jeans'),
  Item(7, 'shorts'),
  Item(8, 'Underwear'),
  Item(9, 'hoodies'),
  Item(10, 'jumpers'),
  Item(11, 'sleepwear'),
  Item(12, 'accessories'),

];


void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context)=> CartProvider(),
      child: const MyApp(),
    ),
  );
}

class CartItem extends StatelessWidget{
  final int index;
  const CartItem({super.key, required this.index});
  
  @override
  Widget build(BuildContext context){
    var item = catalog[index];
    return Row(
      children: [
        Text('$item'),
        const Expanded(child: SizedBox()),
        Consumer<CartProvider>(builder: (context, cart, child){
          return TextButton(onPressed: (){
            cart.add(item);
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$item added to cart')));
          }, child: Text('Add'));
        })
      ],
    );
  }
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Catalog'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(widget.title),
        actions: [
          IconButton(
              icon: Icon(Icons.shopping_cart),
            onPressed: (){
                Navigator.push(
                  context, MaterialPageRoute(
                    builder: (BuildContext context) => const CartPage(),

                )
                );
            },
          ),
        ],
      ),
      body: Center(

        child: ListView.separated(
            itemBuilder: (BuildContext context, int index){
              return CartItem(index: index);
            }, //what we want to build
            separatorBuilder: (BuildContext context, int index)=> Divider(),
            itemCount: catalog.length,),
        ),
      );
  }
}
