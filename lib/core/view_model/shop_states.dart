import 'package:elbya3/model/add_favorites_model.dart';
import 'package:elbya3/model/cart_model.dart';
import 'package:elbya3/model/update_cart_model.dart';

abstract class ShopStates {}

class ShopInitState extends ShopStates {}

class ShopChangeNavBarState extends ShopStates {}

class ShopLoadingHomeState extends ShopStates {}

class ShopGetDataSuccessHomeState extends ShopStates {}

class ShopGetDataErrorHomeState extends ShopStates {
  final String error;

  ShopGetDataErrorHomeState(this.error);
}

class ShopCategoriesSuccessHomeState extends ShopStates {}

class ShopCategoriesErrorHomeState extends ShopStates {
  final String error;

  ShopCategoriesErrorHomeState(this.error);
}

class ShopFavoritesSuccess extends ShopStates {
  final AddFavoritesModel favoritesModel;

  ShopFavoritesSuccess(this.favoritesModel);
}

class ShopChangeclickFavoritesSuccess extends ShopStates {}

class ShopFavoritesError extends ShopStates {
  final String error;

  ShopFavoritesError(this.error);
}

class ShopGetFavoritesSuccess extends ShopStates {}

class ShopLoadingFavoritesSuccess extends ShopStates {}

class ShopGetFavoritesError extends ShopStates {
  final String error;

  ShopGetFavoritesError(this.error);
}

class ShopGetProfileSuccess extends ShopStates {}

class ShopLoadingProfile extends ShopStates {}

class ShopGetProfileError extends ShopStates {
  final String error;

  ShopGetProfileError(this.error);
}

class ShopUpdateProfileSuccess extends ShopStates {}

class ShopUpdatProfileError extends ShopStates {
  final String error;

  ShopUpdatProfileError(this.error);
}

class ShopNotificationSuccess extends ShopStates {}

class ShopNotificationLoading extends ShopStates {}

class ShopNotificationError extends ShopStates {
  final String error;

  ShopNotificationError(this.error);
}

class ShopCartSuccess extends ShopStates {
  final CartsModel model;

  ShopCartSuccess(this.model);
}

class ShopCartLoading extends ShopStates {}

class ShopCartError extends ShopStates {
  final String error;

  ShopCartError(this.error);
}

class ShopUpdatCartSuccess extends ShopStates {
  final CartsUpdateModel cartsUpdateModel;

  ShopUpdatCartSuccess(this.cartsUpdateModel);
}

class ShopUpdateCartError extends ShopStates {
  final String error;

  ShopUpdateCartError(this.error);
}

class ShopAddAndRemoveCartSuccess extends ShopStates {}

class ShopClickAddAndRemoveCartSuccess extends ShopStates {}
class ShopAddAndRemoveCartLoading extends ShopStates {}

class ShopAddAndRemoveCartError extends ShopStates {
  final String error;

  ShopAddAndRemoveCartError(this.error);
}

class ShopProductsDetailsSuccess extends ShopStates {}

class ShopProductsDeatisLoading extends ShopStates {}

class ShopProductsDeatisError extends ShopStates {
  final String error;

  ShopProductsDeatisError(this.error);
}

class ShopCategoryProductsSuccess extends ShopStates {}

class ShopCategoryProductsLoading extends ShopStates {}

class ShopCategoryProductsError extends ShopStates {
  final String error;

  ShopCategoryProductsError(this.error);
}

class ShopSearchProductsSuccess extends ShopStates {}

class ShopSearchProductsLoading extends ShopStates {}

class ShopSearchProductsError extends ShopStates {
  final String error;

  ShopSearchProductsError(this.error);
}
