import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:elbya3/core/view_model/shop_cubit.dart';
import 'package:elbya3/core/view_model/shop_states.dart';
import 'package:elbya3/helper/progress_dialog.dart';
import 'package:elbya3/model/products_details_model.dart';
import 'package:elbya3/view/component/component.dart';
import 'package:elbya3/view/component/custom_text%20copy.dart';
import 'package:elbya3/view/component/default_bottom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants.dart';
import '../../size_config.dart';

class ProductDetailsScreen extends StatelessWidget {

   ProgressDialog progressDialog;
  @override
  Widget build(BuildContext context) {

      progressDialog = ProgressDialog(context, ProgressDialogType.Normal);
    progressDialog.setMessage('Please Wait...');
    return Scaffold(
      appBar: AppBar(
          //  title: Text("Product"),
          ),
      body: BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {
           if (state is ShopAddAndRemoveCartSuccess) {
                progressDialog.hide();
              }
              if (state is ShopAddAndRemoveCartError) {
                progressDialog.hide();
              }
        },
        builder: (context, state) {
          var cubit = ShopCubit.get(context);
          return ConditionalBuilder(
            condition: state is! ShopProductsDeatisLoading &&
                cubit.detailsModel != null,
            builder: (context) => Column(
              children: [
                carouselSlider(cubit.detailsModel.data, context),
                Utils.getSizedBox(height: getProportionateScreenHeight(20)),
                buildContantDetails(cubit.detailsModel.data, context)
              ],
            ),
            fallback: (context) => const Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }

  Expanded buildContantDetails(Data model, context) {
    return Expanded(
        child: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: model.name,
              size: 20,
              color: Colors.black,
            ),
            Utils.getSizedBox(height: getProportionateScreenHeight(20)),
            CustomText(
              text: "Details",
              size: 18,
              color: KPrimaryColor,
            ),
            Utils.getSizedBox(height: getProportionateScreenHeight(5)),
            CustomText(
              text: model.description,
              size: 16,
              height: 2.5,
            ),
            Padding(
              padding: EdgeInsets.all(getProportionateScreenHeight(20)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      CustomText(
                        text: "Price ",
                        size: 18,
                      ),
                      CustomText(
                        text: '\$' + model.price.toString(),
                        color: KPrimaryColor,
                        size: 18,
                      ),
                    ],
                  ),
                 ShopCubit.get(context).inCart[model.id]
                      ?  Container():DefaultButton(
                          width: SizeConfig.screenWidth / 2.6,
                          text: "Add To Cart",
                          press: () {
                             progressDialog.show();
                            ShopCubit.get(context)
                                .addOrRemoveCartsDataFromApi(id: model.id);
                          },
                        )
                      ,
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }

  //this to build item slider
  carouselSlider(Data model, context) {
    return Stack(alignment: Alignment.bottomRight, children: [
      CarouselSlider(
          items: model.images
              .map((e) => Image(
                    image: NetworkImage(e),
                    fit: BoxFit.cover,
                  ))
              .toList(),
          options: CarouselOptions(
            height: SizeConfig.screenHeight / 3.5,
            aspectRatio: 16 / 9,
            viewportFraction: 1.0,
            initialPage: 0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 2),
            autoPlayAnimationDuration: Duration(milliseconds: 1000),
            autoPlayCurve: Curves.fastOutSlowIn,
            enlargeCenterPage: true,
            scrollDirection: Axis.horizontal,
          )),
      Padding(
        padding: const EdgeInsets.only(right: 20),
        child: IconButton(
          color: KPrimaryColor,
          onPressed: () {
            ShopCubit.get(context)
                .addOrRemoveFavoriteCategoriesFromApi(model.id);
          },
          icon: Icon(
            ShopCubit.get(context).favorite[model.id]
                ? Icons.favorite
                : Icons.favorite_border,
            size: getProportionateScreenHeight(50),
          ),
        ),
      ),
    ]);
  }
}
