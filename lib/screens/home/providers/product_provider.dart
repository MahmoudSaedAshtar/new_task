import 'package:flutter/cupertino.dart';
import 'package:task/screens/home/models/product.dart';

class ProductProvider with ChangeNotifier{
  List<ProductModel> _productList = [];
  List<ProductModel> _cartItems = [];

  List<ProductModel> get productList => _productList;
  set productList(List<ProductModel> productList) {
    _productList = productList;
    notifyListeners();
  }

  List<ProductModel> get cartItems => _cartItems;
  set cartItems(List<ProductModel> cartItems) {
    _cartItems = cartItems;
    notifyListeners();
  }

  addToCartList(ProductModel productModel){
    _cartItems.add(productModel);
    notifyListeners();
  }
}