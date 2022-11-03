import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../themes.dart';

class CatalogImage extends StatelessWidget {
  final String image;
  const CatalogImage(@required this.image, {super.key});

  @override
  Widget build(BuildContext context) {
    return Image.network(image)
        .box
        .rounded
        .color(context.canvasColor)
        .make()
        .p8()
        .w40(context);
  }
}
