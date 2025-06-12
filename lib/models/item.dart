import 'package:recycle_app/core/enumz/item_type.dart';

class Item{
  final String? location;
  final int? quantity;
  final ItemType? itemType;

  Item({this.location, this.quantity, this.itemType});

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      location : json['location'] as String?,
      quantity: json['quantity'] as int?,
      itemType: json['itemType'] as ItemType?,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'location': location,
      'quantity': quantity,
      'itemType': itemType,
    };
  }
}