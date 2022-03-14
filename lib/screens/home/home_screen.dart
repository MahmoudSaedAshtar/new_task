import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task/common/helpers/app_dimensions.dart';
import 'package:task/main.dart';
import 'package:task/screens/home/helper/product_helper.dart';
import 'package:task/screens/home/models/product.dart';
import 'package:task/screens/home/providers/product_provider.dart';
import 'package:task/screens/home/widgets/product_card.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController controller = ScrollController();
  late ProductHelper _productHelper;

  @override
  void initState() {
    _productHelper = new ProductHelper();
    _productHelper.getAllProducts();
    controller.addListener(_scrollListener);
    super.initState();
  }

  void _scrollListener() {
    if (controller.offset >= controller.position.maxScrollExtent &&
        !controller.position.outOfRange) {
      _productHelper.count = _productHelper.count + 5;
      _productHelper.getAllProducts();
    }
  }
  @override
  Widget build(BuildContext context) {
    return
          Consumer<ProductProvider>(
              builder: (context, value, child) {
                return
                  RefreshIndicator(
                    onRefresh: () async {
                      _productHelper.count = _productHelper.count + 5;
                      _productHelper.getAllProducts();
                }
                ,child:
                  GridView.builder(
                    controller: controller,
                    itemCount: value.productList.length,
                    padding:  EdgeInsets.all(AppDimensions.convertToH(16)),
                    itemBuilder: (BuildContext context, int index) {
                      return ProductCard(
                        productModel: value.productList[index],);
                    },
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.7,
                      crossAxisSpacing: 10,
                    ),
                  ));
              });
  }
}
