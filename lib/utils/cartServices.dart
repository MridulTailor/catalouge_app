import 'dart:convert';

import 'package:my_app/models/catalog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartServices {
  Future<List<Item>> getCartItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? cartItems = prefs.getStringList("cartItems");
    List<Item> items = [];
    if (cartItems != null) {
      items = cartItems.map((e) => Item.fromMap(jsonDecode(e))).toList();
    }
    return items;
  }

  Future<void> addToCart(Item item) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? cartItems = prefs.getStringList("cartItems");
    cartItems ??= [];
    cartItems.add(jsonEncode(item.toMap()));
    prefs.setStringList("cartItems", cartItems);
  }

  Future<void> removeFromCart(Item item) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? cartItems = prefs.getStringList("cartItems");
    cartItems ??= [];
    cartItems.remove(jsonEncode(item.toMap()));
    prefs.setStringList("cartItems", cartItems);
  }

  Future<void> clearCart() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("cartItems");
  }
}
