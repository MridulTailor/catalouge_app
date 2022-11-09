import 'package:my_app/models/catalog.dart';

class CartModel {
  late CatalogModel _catalog;
  //collection of ids - store ids of each item
  final List<int> _itemIds = [];
  CatalogModel get catalog => _catalog;
  set catalog(CatalogModel newCatalog) {
    assert(newCatalog != null);
    _catalog = newCatalog;
  }

  List<Item> get items => _itemIds.map((e) => _catalog.getById(e)).toList();

  //get total price
  num get totalPrice =>
      items.fold(0, (total, current) => total += current.price);

  //Add Item
  void add(Item item) {
    _itemIds.add(item.id);
  }

  void remove(Item item) {
    _itemIds.remove(item.id);
  }
}
