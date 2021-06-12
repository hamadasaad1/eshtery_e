import 'package:elbya3/constants.dart';
import 'package:elbya3/core/view_model/shop_cubit.dart';
import 'package:elbya3/core/view_model/shop_states.dart';
import 'package:elbya3/model/categories_model.dart';
import 'package:elbya3/size_config.dart';
import 'package:elbya3/view/component/component.dart';
import 'package:elbya3/view/component/custom_svg_.dart';
import 'package:elbya3/view/screens/category_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return ListView.separated(
            itemBuilder: (context, index) => builCategoryItem(
                  cubit.categoriesModel.data.categoryData[index],
                  context,
                ),
            separatorBuilder: (context, index) => Container(
                  height: .6,
                  color: KPrimaryColor,
                ),
            itemCount: cubit.categoriesModel.data.categoryData.length);
      },
    );
  }

  builCategoryItem(CategoryData model, context) {
    return InkWell(
      onTap: () {
        ShopCubit.get(context).getCategoryProductsDataFromApi(id: model.id);
        changeNavigator(context, CategoryProductsScreen(model.name));
      },
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: [
            Image(
              image: NetworkImage(model.image),
              height: getProportionateScreenHeight(120),
              width: getProportionateScreenWidth(120),
              fit: BoxFit.cover,
            ),
            SizedBox(
              width: getProportionateScreenWidth(10),
            ),
            Text(
              model.name,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.black),
            ),
            Spacer(),
            CustomSvg(iconPath: 'assets/icons/arrow_right.svg'),
          ],
        ),
      ),
    );
  }
}
