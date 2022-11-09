import 'package:flutter/material.dart';
import 'package:my_app/pages/homeDetailPage.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../models/catalog.dart';
import '../themes.dart';
import 'catalog_image.dart';

class CatalogList extends StatelessWidget {
  const CatalogList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: CatalogModel.items.length,
      itemBuilder: (context, index) {
        final catalog = CatalogModel.getByPosition(index);
        return InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HomeDetailPage(catalog: catalog)));
            },
            child: CatalogItem(catalog));
      },
    );
  }
}

class CatalogItem extends StatelessWidget {
  final Item catalog;

  const CatalogItem(this.catalog, {super.key});

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
                ElevatedButton(
                  onPressed: () {},
                  child: "Add to cart".text.make(),
                  style: ButtonStyle(
                      // backgroundColor:
                      //     MaterialStateProperty.all(MyTheme.darkBluishColor),
                      shape: MaterialStateProperty.all(const StadiumBorder())),
                )
              ],
            ).pOnly(right: 8.0)
          ],
        ))
      ],
    )).color(context.cardColor).square(150).roundedLg.make().py16();
  }
}
