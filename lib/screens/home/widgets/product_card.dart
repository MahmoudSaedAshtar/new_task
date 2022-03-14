import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:task/common/constants/app_text_styles.dart';
import 'package:task/common/helpers/app_dimensions.dart';
import 'package:task/common/localization/app_localization.dart';
import 'package:task/screens/home/helper/product_helper.dart';
import 'package:task/screens/home/models/product.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({required this.productModel});

  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: (){

      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                child: AspectRatio(
                  aspectRatio: 1.6,
                  child: CachedNetworkImage(
                    imageUrl: productModel.image,
                    fit: BoxFit.fitWidth,
                    placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
              ),
            ),
                  Text(
                    productModel.title,
                    style: AppTextStyles.madium_black,overflow: TextOverflow.ellipsis,maxLines: 2,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    productModel.price.toString(),
                    style: AppTextStyles.madium_red,
                  ),

            Padding(
               padding: EdgeInsets.symmetric(vertical: AppDimensions.convertToH(5)),
              child: InkWell(
                onTap: (){
                  if(!productModel.isAddedToCart) {
                    ProductHelper().addToCart(
                        product: productModel, quantity: 1);
                  }
                },
                child: Text(
                 productModel.isAddedToCart? AppLocalizations.of(context: context)
                     ?.translate(key: "added_to_cart")??"": AppLocalizations.of(context: context)
                     ?.translate(key: "add_to_cart")??"",
                  style: AppTextStyles.madium_blue,
                ),
              ),
            ),

                ],

        ),
      ),
    );
  }
}
