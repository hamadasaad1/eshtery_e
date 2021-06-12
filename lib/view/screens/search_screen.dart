import 'package:conditional_builder/conditional_builder.dart';
import 'package:elbya3/core/view_model/shop_cubit.dart';
import 'package:elbya3/core/view_model/shop_states.dart';
import 'package:elbya3/model/search_model.dart';
import 'package:elbya3/view/component/component.dart';
import 'package:elbya3/view/screens/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants.dart';
import '../../size_config.dart';

class SearchScreen extends StatelessWidget {
  var textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(getProportionateScreenHeight(15)),
            child: textFormFiled(
              label: "Search",
              preIcon: Icons.search_outlined,
              onChange: (value) {
                print(value);
                ShopCubit.get(context).getSearchDataFromApi(searchText: value);
              },
              validate: (String value) {
                if (value.isEmpty) {
                  return 'Please Enter Search value';
                } else {
                  return null;
                }
              },
              type: TextInputType.text,
              controller: textController,
            ),
          ),
          Expanded(
            child: BlocConsumer<ShopCubit, ShopStates>(
              listener: (context, state) {},
              builder: (context, state) {
                var cubit = ShopCubit.get(context);
                return ConditionalBuilder(
                  condition: 
                      cubit.searchList.length!=0&&state is !ShopSearchProductsLoading,
                  builder: (context )=>cubit.searchList.isEmpty
                      ? buildSVGEmpty(message: 'Not found !!!')
                      : SingleChildScrollView(
                                              child: Container(
                            color: Colors.grey[300],
                            child: GridView.count(
                              shrinkWrap: true,
                               scrollDirection: Axis.vertical,
                              physics: const NeverScrollableScrollPhysics(),
                              crossAxisCount: 2,
                              mainAxisSpacing: getProportionateScreenHeight(1.2),
                              crossAxisSpacing: getProportionateScreenHeight(1.2),
                              //this to control for width and height
                              childAspectRatio: getProportionateScreenWidth(1) /
                                  getProportionateScreenHeight(1.59),

                              children: List.generate(
                                cubit.searchModel.data.searchItem
                                    .length,
                                (index) => buildProductItem(
                                  cubit.searchModel.data.searchItem[index],
                                  context,
                                ),
                              ),
                            ),
                          ),
                      ),
                  fallback: (context) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  buildProductItem(SearchItem model, context) {
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
            Image(
              image: NetworkImage(model.image),
              width: double.infinity,
              height: 200,
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
                      const Spacer(),
                      // IconButton(
                      //   color: KPrimaryColor,
                      //   onPressed: () {
                      //     ShopCubit.get(context)
                      //         .addOrRemoveFavoriteCategoriesFromApi(model.id);
                      //   },
                      //   icon: Icon(ShopCubit.get(context).favorite[model.id]
                      //       ? Icons.favorite
                      //       : Icons.favorite_border),
                      // )
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
