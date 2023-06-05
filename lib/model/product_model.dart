// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../helper/hexColor_extension.dart';

class ProductModel {
  String? name;
  String? description;
  String? size;
  String? price;
  String? productId;
  String? category;
  List<String?>? images;
  Color? color;
  ProductModel({
    this.name,
    this.description,
    this.size,
    this.price,
    this.productId,
    this.category,
    this.images,
    this.color,
  });

  ProductModel copyWith({
    String? name,
    String? description,
    String? size,
    String? price,
    String? productId,
    String? category,
    List<String?>? images,
    Color? color,
  }) {
    return ProductModel(
      name: name ?? this.name,
      description: description ?? this.description,
      size: size ?? this.size,
      price: price ?? this.price,
      productId: productId ?? this.productId,
      category: category ?? this.category,
      images: images ?? this.images,
      color: color ?? this.color,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'name': name,
      'description': description,
      'size': size,
      'price': price,
      'productId': productId,
      'category': category,
      'images': images!.map((x) => x).toList(),
      'color': color?.value,
    };
  }

  factory ProductModel.fromJson(Map<String, dynamic> map) {
    return ProductModel(
      name: map['name'] != null ? map['name'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      size: map['size'] != null ? map['size'] as String : null,
      price: map['price'] != null ? map['price'] as String : null,
      productId: map['productId'] != null ? map['productId'] as String : null,
      category: map['category'] != null ? map['category'] as String : null,
      images: map['images'] != null
          ? List<String?>.from(
              (map['images'] as List<dynamic>).map<String>((x) => x),
            )
          : null,
      color: HexColor.fromHex(map['color']),
    );
  }

  @override
  String toString() {
    return 'ProductModel(name: $name, description: $description, size: $size, price: $price, productId: $productId, category: $category, images: $images, color: $color)';
  }

  @override
  bool operator ==(covariant ProductModel other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.description == description &&
        other.size == size &&
        other.price == price &&
        other.productId == productId &&
        other.category == category &&
        listEquals(other.images, images) &&
        other.color == color;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        description.hashCode ^
        size.hashCode ^
        price.hashCode ^
        productId.hashCode ^
        category.hashCode ^
        images.hashCode ^
        color.hashCode;
  }
}
















/**
  ProductModel({
    required this.name 
    required this.image 
    required this.description 
    required this.size 
    required this.price 
    required this.productId 
    required this.category 
    required this.color 
  });

  ProductModel.fromJson(Map<dynamic  dynamic> map) {
    name = map['name'];
    image = map['image'];
    description = map['description'];
    size = map['size'];
    price = map['price'];
    productId = map['productId'];
    category = map['category'];
    color = HexColor.fromHex(map['color']);
  }

  toJson() {
    return {
      'name': name 
      'image': image 
      'description': description 
      'size': size 
      'color': color.toString?  () 
      'price': price 
      'productId': productId 
      'category': category 
    };
  } */
