import 'package:bloc/bloc.dart';
import 'package:elbya3/constants.dart';
import 'package:elbya3/core/network/remot/dio_helper.dart';
import 'package:elbya3/core/network/remot/end_points.dart';
import 'package:elbya3/core/view_model/shop_states.dart';
import 'package:elbya3/model/cart_model.dart';
import 'package:elbya3/model/categories_model.dart';
import 'package:elbya3/model/add_favorites_model.dart';
import 'package:elbya3/model/category_product_model.dart';
import 'package:elbya3/model/favorites_model.dart';
import 'package:elbya3/model/home_model.dart';
import 'package:elbya3/model/notification_model.dart';
import 'package:elbya3/model/products_details_model.dart';
import 'package:elbya3/model/search_model.dart';
import 'package:elbya3/model/update_cart_model.dart';
import 'package:elbya3/model/user_model.dart';
import 'package:elbya3/view/screens/category_screen.dart';
import 'package:elbya3/view/screens/favorite_screen.dart';
import 'package:elbya3/view/screens/home_screen.dart';
import 'package:elbya3/view/screens/setting_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitState());

  static ShopCubit get(context) => BlocProvider.of(context);

  List<Widget> screen = [
    HomeScreen(),
    CategoryScreen(),
    FavoriteScreen(),
    SettingScreen(),
  ];
  int currentIndex = 0;

  void changeIndexNavBar(int index) {
    currentIndex = index;
    //this to when click get data
    if (index == 2) {
      getFavoriteCategoriesFromApi();
    }
    if (index == 3) {
      getUserProfileFromApi();
    }

    emit(ShopChangeNavBarState());
  }

  HomeModel model;

  Map<int, bool> favorite = {};

  Map<int, bool> inCart = {};

  void getHomeDataFromApi() {
    emit(ShopLoadingHomeState());
    DioHelper.getData(url: HOME, token: KToken).then((value) {
      model = HomeModel.fromJson(value.data);

      print(model.data.banners[0].category.name);
      //this for to and all products in map favoite id and type
      model.data.products.forEach((element) {
        favorite.addAll({element.id: element.inFavorites});
      });

      model.data.products.forEach((element) {
        inCart.addAll({element.id: element.inCart});
      });

      print("Favorits == " + favorite.toString());
      emit(ShopGetDataSuccessHomeState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopGetDataErrorHomeState(error.toString()));
    });
  }

  CategoriesModel categoriesModel;

  void getCategoriesDataFromApi() {
    emit(ShopLoadingHomeState());
    DioHelper.getData(url: CATEGORIES, token: KToken).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      print(categoriesModel.data.categoryData[0].name);
      emit(ShopCategoriesSuccessHomeState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopCategoriesErrorHomeState(error.toString()));
    });
  }

  AddFavoritesModel addFavoritesModel;
  void addOrRemoveFavoriteCategoriesFromApi(int id) {
    //this make change when click buttom
    favorite[id] = !favorite[id];
    emit(ShopChangeclickFavoritesSuccess());

    DioHelper.postData(
      url: FAVORITES,
      token: KToken,
      query: {'product_id': id},
    ).then((value) {
      addFavoritesModel = AddFavoritesModel.fromJson(value.data);
      print(value.toString());

      var status = addFavoritesModel.status;
      print(status);
      if (!status) {
        favorite[id] = !favorite[id];
        emit(ShopChangeclickFavoritesSuccess());
      } else {
        getFavoriteCategoriesFromApi();
      }
      emit(ShopFavoritesSuccess(addFavoritesModel));
    }).catchError((error) {
      print(error.toString());
      emit(ShopFavoritesError(error.toString()));

      favorite[id] = !favorite[id];
      emit(ShopChangeclickFavoritesSuccess());
    });
  }

  FavoritesModel favoritesModel;
  void getFavoriteCategoriesFromApi() {
    emit(ShopLoadingFavoritesSuccess());

    DioHelper.getData(
      url: FAVORITES,
      token: KToken,
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      print(favoritesModel.status.toString() + "Stutus");

      emit(ShopGetFavoritesSuccess());
    }).catchError((error) {
      print(error.toString());
      emit(ShopGetFavoritesError(error.toString()));
    });
  }

  UserModel userModel;
  void getUserProfileFromApi() {
    emit(ShopLoadingProfile());

    DioHelper.getData(
      url: PROFILE,
      token: KToken,
    ).then((value) {
      userModel = UserModel.fromJson(value.data);
      print(userModel.data.email);

      emit(ShopGetProfileSuccess());
    }).catchError((error) {
      print(error.toString());
      emit(ShopGetProfileError(error.toString()));
    });
  }

  void updateProfileFromApi({
    String email,
    String phone,
    String name,
  }) {
    DioHelper.putData(
        url: UPDATEPROFILE,
        token: KToken,
        query: {'name': name, 'phone': phone, 'email': email}).then((value) {
      KToken = value.data['data']['token'];
      print(KToken);
      getUserProfileFromApi();
      emit(ShopUpdateProfileSuccess());
    }).catchError((error) {
      print(error.toString());
      emit(ShopUpdatProfileError(error.toString()));
    });
  }

  NotificationModel notificationModel;

  void getNotificationDataFromApi() {
    emit(ShopNotificationLoading());
    DioHelper.getData(url: NOTIFICATION, token: KToken).then((value) {
      notificationModel = NotificationModel.fromJson(value.data);
      print(notificationModel.data.notificationData[0].title);
      emit(ShopNotificationSuccess());
    }).catchError((error) {
      print(error.toString());
      emit(ShopNotificationError(error.toString()));
    });
  }

  CartsModel cartsModel;

  void getCartsDataFromApi() {
    emit(ShopCartLoading());
    DioHelper.getData(url: CART, token: KToken).then((value) {
      cartsModel = CartsModel.fromJson(value.data);
      print(cartsModel.data.cartItems[0].product.name);
      emit(ShopCartSuccess(cartsModel));
    }).catchError((error) {
      print(error.toString());
      emit(ShopCartError(error.toString()));
    });
  }

  CartsUpdateModel cartsUpdateModel;
  void updateCartsDataFromApi({int id, int quantity}) {
    if (quantity < 1) {
      return;
    } else {
      DioHelper.putData(
          url: CART + '/$id',
          token: KToken,
          query: {"quantity": quantity}).then((value) {
        cartsUpdateModel = CartsUpdateModel.fromJson(value.data);
        getCartsDataFromApi();
        emit(ShopUpdatCartSuccess(cartsUpdateModel));
      }).catchError((error) {
        print("Error == " + error.toString());
        emit(ShopUpdateCartError(error.toString()));
      });
    }
  }

  void addOrRemoveCartsDataFromApi({int id}) {
    emit(ShopAddAndRemoveCartLoading());
    inCart[id] = !inCart[id];
    emit(ShopClickAddAndRemoveCartSuccess());

    DioHelper.postData(url: CART, token: KToken, query: {"product_id": id})
        .then((value) {
      getCartsDataFromApi();
      if (!value.data['status']) {
        inCart[id] = !inCart[id];
        emit(ShopClickAddAndRemoveCartSuccess());
      }
      emit(ShopAddAndRemoveCartSuccess());
    }).catchError((error) {
      inCart[id] = !inCart[id];
      print("Error == " + error.toString());
      emit(ShopAddAndRemoveCartError(error.toString()));
    });
  }

  ProductsDetailsModel detailsModel;
  void getProductsDetailsDataFromApi({int id}) {
    emit(ShopProductsDeatisLoading());
    DioHelper.getData(
      url: PRODUCTS + '/$id',
      token: KToken,
    ).then((value) {
      detailsModel = ProductsDetailsModel.fromJson(value.data);

      emit(ShopProductsDetailsSuccess());
    }).catchError((error) {
      print("Error == " + error.toString());
      emit(ShopProductsDeatisError(error.toString()));
    });
  }

  CategoryProductsModel categoryProductsModel;
  void getCategoryProductsDataFromApi({int id}) {
    emit(ShopCategoryProductsLoading());
    DioHelper.getData(
      url: PRODUCTS,
      query: {
        'category_id': id,
      },
      token: KToken,
    ).then((value) {
      categoryProductsModel = CategoryProductsModel.fromJson(value.data);

      emit(ShopCategoryProductsSuccess());
    }).catchError((error) {
      print("Error == " + error.toString());
      emit(ShopCategoryProductsError(error.toString()));
    });
  }

  SearchModel searchModel;
  List<SearchItem> searchList = [];
  void getSearchDataFromApi({String searchText}) {
    emit(ShopSearchProductsLoading());
    searchList = [];
    DioHelper.postData(
      url: PRODUCTS + '/search',
      query: {
        "text": searchText,
      },
      token: KToken,
    ).then((value) {
      searchModel = SearchModel.fromJson(value.data);
      searchList = searchModel.data.searchItem;
      emit(ShopSearchProductsSuccess());
    }).catchError((error) {
      print("Error == " + error.toString());
      emit(ShopSearchProductsError(error.toString()));
    });
  }
}
