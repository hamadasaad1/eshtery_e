import 'package:elbya3/constants.dart';
import 'package:elbya3/core/view_model/shop_cubit.dart';
import 'package:elbya3/core/view_model/shop_states.dart';
import 'package:elbya3/view/component/component.dart';
import 'package:elbya3/view/component/custom_svg_.dart';

import 'package:elbya3/view/screens/cart_screen.dart';
import 'package:elbya3/view/screens/notification_screen.dart';
import 'package:elbya3/view/screens/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../size_config.dart';

class HomeLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text('ELBYA3'),
            actions: [
              IconButton(
                  onPressed: () {
                    changeNavigator(context, SearchScreen());
                  },
                  icon: Icon(
                    Icons.search,
                    color: KPrimaryColor,
                    size: getProportionateScreenWidth(30),
                  )),
              IconButton(
                onPressed: () {
                  changeNavigator(context, CartScreen());
                  ShopCubit.get(context).getCartsDataFromApi();
                },
                icon: Icon(
                  Icons.shopping_cart_outlined,
                  color: KPrimaryColor,
                  size: getProportionateScreenWidth(30),
                ),
              ),
              IconButton(
                onPressed: () {
                  changeNavigator(context, NotificationScreen());
                  ShopCubit.get(context).getNotificationDataFromApi();
                },
                icon: Icon(
                  Icons.notifications,
                  color: KPrimaryColor,
                  size: getProportionateScreenWidth(30),
                ),
              ),
            ],
          ),
          body: cubit.screen[cubit.currentIndex],
          bottomNavigationBar: buildBottomNavigationBar(cubit),
        );
      },
    );
  }

  BottomNavigationBar buildBottomNavigationBar(ShopCubit cubit) {
    return BottomNavigationBar(
      currentIndex: cubit.currentIndex,
      onTap: (index) {
        cubit.changeIndexNavBar(index);
      },
      items: [
        BottomNavigationBarItem(
          icon: CustomSvg(iconPath: 'assets/icons/Shop Icon.svg'),
          activeIcon: Text("Home"),
          label: "",
        ),
        BottomNavigationBarItem(
          icon: CustomSvg(iconPath: 'assets/icons/Gift Icon.svg'),
          label: '',
          activeIcon: Text("Categories"),
        ),
        BottomNavigationBarItem(
          icon: CustomSvg(iconPath: 'assets/icons/Heart Icon_2.svg'),
          label: '',
          activeIcon: Text("Favorites"),
        ),
        BottomNavigationBarItem(
          icon: CustomSvg(iconPath: 'assets/icons/Settings.svg'),
          label: '',
          activeIcon: Text(
            "Settings",
          ),
        ),
      ],
    );
  }
}
