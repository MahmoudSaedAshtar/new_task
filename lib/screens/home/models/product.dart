import 'dart:convert';
AppProductsModel appProductsModelFromJson(String str) => AppProductsModel.fromJson(json.decode(str));


class AppProductsModel {
  AppProductsModel({
    required this.products,
  });

  List<ProductModel> products;

  factory AppProductsModel.fromRawJson(String str) => AppProductsModel.fromJson(json.decode(str));
  factory AppProductsModel.fromJson(List<dynamic> json) => AppProductsModel(
    products: List<ProductModel>.from(json.map((x) => ProductModel.fromJson(x))),
  );
}




class ProductModel {
  ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.category,
    required this.description,
    required this.image,
    this.isAddedToCart:false
  });

  int id;
  String title;
  dynamic price;
  String category;
  String description;
  String image;
  bool isAddedToCart;
  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    id: json["id"],
    title: json["title"],
    price: json["price"],
    category: json["category"],
    description: json["description"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "price": price,
    "category": category,
    "description": description,
    "image": image,
  };
}
