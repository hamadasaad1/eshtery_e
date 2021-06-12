import 'package:conditional_builder/conditional_builder.dart';
import 'package:elbya3/constants.dart';
import 'package:elbya3/core/view_model/shop_cubit.dart';
import 'package:elbya3/core/view_model/shop_states.dart';

import 'package:elbya3/model/category_product_model.dart';
import 'package:elbya3/size_config.dart';
import 'package:elbya3/view/component/component.dart';

import 'package:elbya3/view/screens/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryProductsScreen extends StatelessWidget {
  final String name;

  CategoryProductsScreen(this.name);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(name),
        ),
        backgroundColor: Colors.grey.shade100,
        body: Builder(builder: (context) {
          return BlocConsumer<ShopCubit, ShopStates>(
            listener: (context, state) {},
            builder: (context, state) {
              var cubit = ShopCubit.get(context);
              return ConditionalBuilder(
                condition: state is! ShopCategoryProductsLoading &&
                    cubit.categoryProductsModel != null,
                builder: (context) => cubit
                        .categoryProductsModel.data.categoryProducts.isEmpty
                    ? buildSVGEmpty(message: 'Empty !!!')
                    : Container(
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
                            cubit.categoryProductsModel.data.categoryProducts
                                .length,
                            (index) => buildProductItem(
                              cubit.categoryProductsModel.data
                                  .categoryProducts[index],
                              context,
                            ),
                          ),
                        ),
                      ),
                fallback: (context) => const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
          );
        }));
  }

  buildProductItem(CategoryProducts model, context) {
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
}
