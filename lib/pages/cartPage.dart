import 'package:flutter/material.dart';
import 'package:my_app/models/cart.dart';
import 'package:my_app/models/catalog.dart';
import 'package:my_app/utils/cartServices.dart';
import 'package:my_app/widgets/themes.dart';
import 'package:velocity_x/velocity_x.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: "Cart".text.make(),
      ),
      body: Column(
        children: [
          _CartList().p32().expand(),
          Divider(),
          _CartTotal(),
        ],
      ),
    );
  }
}

class _CartList extends StatefulWidget {
  _CartList({super.key});

  @override
  State<_CartList> createState() => _CartListState();
}

class _CartListState extends State<_CartList> {
  List<Item>? items;

  getCartList() async {
    List<Item> items = await CartServices().getCartItems();

    setState(() {
      items = items;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Object>(
        future: CartServices().getCartItems(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return "Something went wrong".text.makeCentered();
          }
          if (snapshot.connectionState == ConnectionState.done) {
            final List<Item> items = snapshot.data as List<Item>;

            return ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) => ListTile(
                      title: items[index].name.text.make(),
                      leading: Icon(Icons.done),
                      trailing: IconButton(
                        icon: Icon(Icons.remove_circle_outline),
                        onPressed: () {},
                      ),
                    ));
          }
          return CircularProgressIndicator().centered();
        });
  }
}

class _CartTotal extends StatelessWidget {
  const _CartTotal({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Row(
        children: [
          "999".text.xl5.make(),
          30.widthBox,
          ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: "Buying not supported yet".text.make(),
              ));
            },
            style:
                ButtonStyle(shape: MaterialStateProperty.all(StadiumBorder())),
            child: "Buy".text.white.make(),
          ).w32(context)
        ],
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      ).p32(),
    );
  }
}
