import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:elbya3/constants.dart';
import 'package:elbya3/core/view_model/shop_cubit.dart';
import 'package:elbya3/core/view_model/shop_states.dart';
import 'package:elbya3/model/categories_model.dart';
import 'package:elbya3/model/home_model.dart';
import 'package:elbya3/view/component/component.dart';
import 'package:elbya3/view/screens/product_details_screen.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../size_config.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is ShopFavoritesSuccess) {
          if (state.favoritesModel.status) {
            snackBar(context, state.favoritesModel.message);
          } else {
            snackBar(context, state.favoritesModel.message);
          }
        }
      },
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.model != null && cubit.categoriesModel != null,
          builder: (context) =>
              productBuilder(cubit.model, cubit.categoriesModel, context),
          fallback: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  productBuilder(HomeModel model, CategoriesModel categoriesModel, context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          carouselSlider(model),
          SizedBox(
            height: getProportionateScreenHeight(10),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Categories',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ),
                Container(
                  height: getProportionateScreenHeight(100),
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => buildCategoryItem(
                        categoriesModel.data.categoryData[index]),
                    separatorBuilder: (context, index) => SizedBox(
                      width: 10,
                    ),
                    itemCount: categoriesModel.data.categoryData.length,
                  ),
                ),
                       SizedBox(
            height: getProportionateScreenHeight(15),
          ),
                const Text(
                  'New Products',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
          SizedBox(
            height: getProportionateScreenHeight(5),
          ),
          Container(
            color: Colors.grey[300],
            child: GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: getProportionateScreenHeight(1.2),
              crossAxisSpacing: getProportionateScreenHeight(1.2),
              //this to control for width and height
              childAspectRatio: getProportionateScreenWidth(1) /
                  getProportionateScreenHeight(1.59),

              children: List.generate(
                model.data.products.length,
                (index) =>
                    buildProductItem(model.data.products[index], context),
              ),
            ),
          ),
        ],
      ),
    );
  }

  buildCategoryItem(CategoryData model) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Image(
          image: NetworkImage(model.image),
          height: getProportionateScreenHeight(100),
          width: getProportionateScreenWidth(100),
          fit: BoxFit.cover,
        ),
        Container(
          width: getProportionateScreenWidth(100),
          color: Colors.black.withOpacity(.7),
          child: Text(
            model.name,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Colors.white),
          ),
        )
      ],
    );
  }

  buildProductItem(Product model, context) {
    return InkWell(
      onTap: () {
        ShopCubit.get(context).getProductsDetailsDataFromApi(id: model.id);
        changeNavigator(context, ProductDetailsScreen());
      },
      child: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(model.image),
                  width: double.infinity,
                  height: 200,
                ),
                if (model.discount != 0)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    color: Colors.red,
                    child: Text(
                      'DISCOUNT',
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    ),
                  )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.black,
                      height: 1.2,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        '${model.price.round()}', //round to convert to int

                        style: const TextStyle(
                          color: KPrimaryColor,
                        ),
                      ),
                      SizedBox(
                        width: getProportionateScreenWidth(30),
                      ),
                      if (model.discount != 0)
                        Text(
                          '${model.oldPrice.round()}', //round to convert to int

                          style: const TextStyle(
                              decoration: TextDecoration.lineThrough,
                              fontSize: 12),
                        ),
                      const Spacer(),
                      IconButton(
                        color: KPrimaryColor,
                        onPressed: () {
                          ShopCubit.get(context)
                              .addOrRemoveFavoriteCategoriesFromApi(model.id);
                        },
                        icon: Icon(ShopCubit.get(context).favorite[model.id]
                            ? Icons.favorite
                            : Icons.favorite_border),
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  //this to build item slider
  CarouselSlider carouselSlider(HomeModel model) {
    return CarouselSlider(
        items: model.data.banners
            .map((e) => Image(
                  image: NetworkImage(e.image),
                  fit: BoxFit.cover,
                ))
            .toList(),
        options: CarouselOptions(
          height: SizeConfig.screenHeight / 3,
          aspectRatio: 16 / 9,
          viewportFraction: 1.0,
          initialPage: 0,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: true,
          autoPlayInterval: Duration(seconds: 2),
          autoPlayAnimationDuration: Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,
          enlargeCenterPage: true,
          scrollDirection: Axis.horizontal,
        ));
  }
}
