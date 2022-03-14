import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:task/common/constants/api_codes.dart';
import 'package:task/common/network/model/apiParameters.dart';
import 'package:task/common/network/network_base.dart';
import 'package:task/common/network/network_enum.dart';
import 'package:task/main.dart';
import 'package:task/screens/home/models/product.dart';
import 'package:task/screens/home/providers/product_provider.dart';

class ProductHelper {
  int count = 5;
  getAllProducts() async {
    List<ProductModel> products = [];
    try {
      Response _response = await NetworkLayer().sendAppRequest(
        apiParameters: ApiParameters(
          apiCode: ApiCodes.GET_PRODUCTS,
          formData: {
            "limit":count,
            "sort":"desc"
          },
          silentProgress: false,),
        networkType: NETWORK_REQUEST_TYPE.GET,
      );
      products =
          appProductsModelFromJson(jsonEncode(_response.data))
              .products;
    } on PlatformException catch (error) {
      count = count-5;
    }
    if(products.isNotEmpty) {
      Provider
          .of<ProductProvider>(navigatorKey.currentContext!, listen: false)
          .productList = products;
    }
  }

  addToCart({required ProductModel product,required int quantity}) async {
    Provider
        .of<ProductProvider>(navigatorKey.currentContext!, listen: false).addToCartList(product);
    product.isAddedToCart = true;
    try {
      Response _response = await NetworkLayer().sendAppRequest(
        apiParameters: ApiParameters(
          apiCode: ApiCodes.ADD_TO_CART,
          formData: {
            "userId":5,
            "date":DateTime.now().toString(),
            "products":[{"productId":product.id,"quantity":quantity}]
          },
          silentProgress: true,),
        networkType: NETWORK_REQUEST_TYPE.POST,
      );
    } on PlatformException catch (error) {
    }
  }


  getCartItems() async {
    List<ProductModel> products = [];
    try {
      Response _response = await NetworkLayer().sendAppRequest(
        apiParameters: ApiParameters(
          apiCode: ApiCodes.get_USER_CART,
          silentProgress: false,),
        networkType: NETWORK_REQUEST_TYPE.GET,
      );
      products =
          appProductsModelFromJson(jsonEncode(_response.data))
              .products;
    } on PlatformException catch (error) {

    }
  }
}
