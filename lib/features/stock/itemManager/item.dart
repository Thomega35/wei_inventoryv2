import 'package:flutter/material.dart';

@immutable
class Item {
  final String name;
  final int quantity;

  const Item({
    required this.name,
    required this.quantity,
  });

  const Item.initial():
      name = '',
      quantity = 0;

  @override
  String toString() => 'Item{name: $name, quantity: $quantity}';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Item &&
          name == other.name &&
          quantity == other.quantity;

  @override
  int get hashCode =>
      name.hashCode ^
      quantity.hashCode;

  Item add() {
    return Item(name : name, quantity : quantity + 1);
  }
  Item remove() {
    return Item(name : name, quantity : quantity - 1);
  }
  Item rename(String newName) {
    return Item(name : newName, quantity : quantity);
  }
}