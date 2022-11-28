// ignore_for_file: no_logic_in_create_state

import 'package:flutter/material.dart';
import 'package:my_app/models/cart.dart';
import 'package:my_app/pages/homeDetailPage.dart';
import 'package:my_app/utils/cartServices.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../models/catalog.dart';
import '../themes.dart';
import 'catalog_image.dart';

class CatalogList extends StatelessWidget {
  const CatalogList({super.key, required this.items, required this.cart});
  final List<Item> items;
  final List<Item> cart;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: items.length,
      itemBuilder: (context, index) {
        final catalog = items[index];
        return InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HomeDetailPage(catalog: catalog)));
            },
            child: CatalogItem(
              catalog,
              isInCart:
                  cart.where((element) => element.id == catalog.id).isNotEmpty,
            ));
      },
    );
  }
}

class CatalogItem extends StatelessWidget {
  final Item catalog;
  final bool isInCart;

  const CatalogItem(this.catalog, {super.key, required this.isInCart});

  @override
  Widget build(BuildContext context) {
    return VxBox(
        child: Row(
      children: [
        Hero(
            tag: Key(catalog.id.toString()),
            child: CatalogImage(catalog.image)),
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            catalog.name.text.lg.bold.make(),
            catalog.desc.text.textStyle(context.captionStyle).make(),
            10.heightBox,
            ButtonBar(
              buttonPadding: EdgeInsets.all(0),
              alignment: MainAxisAlignment.spaceBetween,
              children: [
                "\$${catalog.price}".text.xl.bold.make(),
                _AddToCart(
                  catalog: catalog,
                  isInCart: isInCart,
                )
              ],
            ).pOnly(right: 8.0)
          ],
        ))
      ],
    )).color(context.cardColor).square(150).roundedLg.make().py16();
  }
}

class _AddToCart extends StatefulWidget {
  final Item catalog;
  final bool isInCart;

  const _AddToCart({Key? key, required this.catalog, required this.isInCart})
      : super(key: key);

  @override
  State<_AddToCart> createState() => _AddToCartState(isInCart);
}

class _AddToCartState extends State<_AddToCart> {
  bool isAdded;
  _AddToCartState(this.isAdded);
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (isAdded) {
          return;
        }
        isAdded = isAdded.toggle();
        CartServices().addToCart(widget.catalog);
        setState(() {});
      },
      style: ButtonStyle(
          // backgroundColor:
          //     MaterialStateProperty.all(MyTheme.darkBluishColor),
          shape: MaterialStateProperty.all(const StadiumBorder())),
      child: isAdded ? const Icon(Icons.done) : "Add to cart".text.make(),
    );
  }
}
