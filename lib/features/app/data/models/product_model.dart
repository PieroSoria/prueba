import 'dart:convert';

import 'package:prueba/features/app/domain/entities/product_entity.dart';

ProductModel parseProductJson(dynamic json) =>
    ProductModel.fromJson(json as Map<String, dynamic>);

List<ProductModel> parseProductJsonList(dynamic jsonList) =>
    (jsonList as List).map((e) => ProductModel.fromJson(e)).toList();

String productModelToJsonE(ProductModel data) => json.encode(data.toJson());
Map<String, dynamic> productModelToJson(ProductEntity data) =>
    ProductModel.fromEntity(data).toJson();

class ProductModel extends ProductEntity {
  const ProductModel({
    required super.id,
    required super.title,
    required super.name,
    required super.description,
    required super.category,
    required super.price,
    required super.discountPercentage,
    required super.rating,
    required super.stock,
    required super.brand,
    required super.sku,
    required super.weight,
    required super.warrantyInformation,
    required super.shippingInformation,
    required super.availabilityStatus,
    required super.returnPolicy,
    required super.minimumOrderQuantity,
    required super.thumbnail,
  });

  ProductModel copyWith({
    int? id,
    String? title,
    String? name,
    String? description,
    String? category,
    double? price,
    double? discountPercentage,
    double? rating,
    int? stock,
    String? brand,
    String? sku,
    int? weight,
    String? warrantyInformation,
    String? shippingInformation,
    String? availabilityStatus,
    String? returnPolicy,
    int? minimumOrderQuantity,
    String? thumbnail,
  }) => ProductModel(
    id: id ?? this.id,
    title: title ?? this.title,
    name: name ?? this.name,
    description: description ?? this.description,
    category: category ?? this.category,
    price: price ?? this.price,
    discountPercentage: discountPercentage ?? this.discountPercentage,
    rating: rating ?? this.rating,
    stock: stock ?? this.stock,
    brand: brand ?? this.brand,
    sku: sku ?? this.sku,
    weight: weight ?? this.weight,
    warrantyInformation: warrantyInformation ?? this.warrantyInformation,
    shippingInformation: shippingInformation ?? this.shippingInformation,
    availabilityStatus: availabilityStatus ?? this.availabilityStatus,
    returnPolicy: returnPolicy ?? this.returnPolicy,
    minimumOrderQuantity: minimumOrderQuantity ?? this.minimumOrderQuantity,
    thumbnail: thumbnail ?? this.thumbnail,
  );

  factory ProductModel.fromEntity(ProductEntity entity) => ProductModel(
    id: entity.id,
    title: entity.title,
    name: entity.name,
    description: entity.description,
    category: entity.category,
    price: entity.price,
    discountPercentage: entity.discountPercentage,
    rating: entity.rating,
    stock: entity.stock,
    brand: entity.brand,
    sku: entity.sku,
    weight: entity.weight,
    warrantyInformation: entity.warrantyInformation,
    shippingInformation: entity.shippingInformation,
    availabilityStatus: entity.availabilityStatus,
    returnPolicy: entity.returnPolicy,
    minimumOrderQuantity: entity.minimumOrderQuantity,
    thumbnail: entity.thumbnail,
  );

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    id: json["id"],
    title: json["title"],
    name: json['name'],
    description: json["description"],
    category: json["category"],
    price: json["price"]?.toDouble(),
    discountPercentage: json["discountPercentage"]?.toDouble(),
    rating: json["rating"]?.toDouble(),
    stock: json["stock"],
    brand: json["brand"],
    sku: json["sku"],
    weight: json["weight"],
    warrantyInformation: json["warrantyInformation"],
    shippingInformation: json["shippingInformation"],
    availabilityStatus: json["availabilityStatus"],
    returnPolicy: json["returnPolicy"],
    minimumOrderQuantity: json["minimumOrderQuantity"],
    thumbnail: json["thumbnail"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "name": name,
    "description": description,
    "category": category,
    "price": price,
    "discountPercentage": discountPercentage,
    "rating": rating,
    "stock": stock,
    "brand": brand,
    "sku": sku,
    "weight": weight,
    "warrantyInformation": warrantyInformation,
    "shippingInformation": shippingInformation,
    "availabilityStatus": availabilityStatus,
    "returnPolicy": returnPolicy,
    "minimumOrderQuantity": minimumOrderQuantity,
    "thumbnail": thumbnail,
  };
}
