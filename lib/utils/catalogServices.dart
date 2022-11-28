import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_app/models/catalog.dart';

class CatalogServices {
  Future<CatalogModel> getCatalog() async {
    final response = await http.get(Uri.parse(
        "https://gist.githubusercontent.com/MridulTailor/d2d950a94be3ebb1053cc8d1cfc0e373/raw/9f25e56c66c28b12d2cfd411ab413f0f75914eb5/catalog.json"));
    if (response.statusCode == 200) {
      final decodedData = jsonDecode(response.body);
      var productsData = decodedData["products"];
      CatalogModel catalog = CatalogModel();
      catalog.items = List.from(productsData)
          .map<Item>((item) => Item.fromMap(item))
          .toList();
      return catalog;
      ;
    } else {
      throw Exception("Failed to load data");
    }
  }
}
