import 'package:conditional_builder/conditional_builder.dart';
import 'package:elbya3/core/view_model/shop_cubit.dart';
import 'package:elbya3/core/view_model/shop_states.dart';
import 'package:elbya3/model/favorites_model.dart';
import 'package:elbya3/model/home_model.dart';
import 'package:elbya3/view/component/component.dart';
import 'package:elbya3/view/component/custom_svg_.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants.dart';
import '../../size_config.dart';

class FavoriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is ShopLoadingFavoritesSuccess) {
          const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return ConditionalBuilder(
          condition: state is! ShopLoadingFavoritesSuccess &&
              cubit.favoritesModel != null,
          builder: (context) => cubit.favoritesModel.data.productItem.isEmpty
              ? buildSVGEmpty(message: 'You don\'t have any favourites!!')
              : ListView.separated(
                  itemBuilder: (context, index) => (buildFavoritesItem(
                      cubit.favoritesModel.data.productItem[index].product,
                      context)),
                  separatorBuilder: (context, index) => Container(
                        color: KPrimaryColor,
                        height: .5,
                      ),
                  itemCount: cubit.favoritesModel.data.productItem.length),
          fallback: (context) => Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  buildFavoritesItem(ProductFavorite model, context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: Colors.white,
        height: getProportionateScreenHeight(130),
        padding: EdgeInsets.all(getProportionateScreenHeight(10)),
        child: Row(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(model.image),
                  width: getProportionateScreenWidth(120),
                  height: getProportionateScreenHeight(120),
                  fit: BoxFit.cover,
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
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.black,
                        height: 1.2,
                      ),
                    ),
                    Spacer(),
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
              ),
            )
          ],
        ),
      ),
    );
  }
}
