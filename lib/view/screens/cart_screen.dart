import 'package:conditional_builder/conditional_builder.dart';
import 'package:elbya3/constants.dart';
import 'package:elbya3/core/view_model/shop_cubit.dart';
import 'package:elbya3/core/view_model/shop_states.dart';
import 'package:elbya3/helper/progress_dialog.dart';
import 'package:elbya3/helper/style/theme.dart';
import 'package:elbya3/model/cart_model.dart';
import 'package:elbya3/size_config.dart';
import 'package:elbya3/view/component/component.dart';
import 'package:elbya3/view/component/custom_text.dart';
import 'package:elbya3/view/component/default_bottom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatelessWidget {
  ProgressDialog progressDialog;
  @override
  Widget build(BuildContext context) {
    progressDialog = ProgressDialog(context, ProgressDialogType.Normal);
    progressDialog.setMessage('Please Wait...');
    return Scaffold(
        //resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: Text('Cart Shoping'),
        ),
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.grey.shade100,
        body: Builder(builder: (context) {
          return BlocConsumer<ShopCubit, ShopStates>(
            listener: (context, state) {
              if (state is ShopUpdatCartSuccess) {
                snackBar(context, state.cartsUpdateModel.message);
              }

              if (state is ShopUpdateCartError) {
                snackBar(context, state.error);
              }
              if (state is ShopAddAndRemoveCartSuccess) {
                progressDialog.hide();
              }
              if (state is ShopAddAndRemoveCartError) {
                progressDialog.hide();
              }

              if (state is ShopAddAndRemoveCartLoading) {
                progressDialog.show();
              }
            },
            builder: (context, state) {
              var cubit = ShopCubit.get(context);
              return ConditionalBuilder(
                condition:
                    state is! ShopCartLoading && cubit.cartsModel != null,
                builder: (context) => cubit.cartsModel.data.cartItems.isEmpty
                    ? buildSVGEmpty(message: 'Cart Empty!!!')
                    : ListView(
                        children: <Widget>[
                          // createHeader(),
                          createSubTitle(cubit.cartsModel.data),
                          createCartList(cubit.cartsModel.data, context),
                          if (cubit.cartsModel.data.cartItems.isNotEmpty)
                            footer(context, cubit.cartsModel.data),
                        ],
                      ),
                fallback: (context) => const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
          );
        }));
  }

  footer(BuildContext context, Data date) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 30),
                  child: Text(
                    "Total",
                    style: CustomTextStyle.textFormFieldMedium
                        .copyWith(color: Colors.grey, fontSize: 12),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 30),
                  child: Text(
                    "\$${date.total}",
                    style: CustomTextStyle.textFormFieldBlack
                        .copyWith(color: KPrimaryColor, fontSize: 14),
                  ),
                ),
              ],
            ),
            Utils.getSizedBox(height: 8),
            DefaultButton(
              press: () {},
              text: 'Check Out',
            ),
            Utils.getSizedBox(height: 8),
          ],
        ),
        margin: EdgeInsets.only(top: 16),
      ),
    );
  }

  createHeader() {
    return Container(
      alignment: Alignment.topLeft,
      child: Text(
        "SHOPPING CART",
        style: CustomTextStyle.textFormFieldBold
            .copyWith(fontSize: 16, color: Colors.black),
      ),
      margin: EdgeInsets.only(left: 12, top: 12),
    );
  }

  createSubTitle(Data data) {
    return Container(
      alignment: Alignment.topLeft,
      child: Text(
        "Total(${data.cartItems.length}) Items",
        style: CustomTextStyle.textFormFieldBold
            .copyWith(fontSize: 12, color: Colors.grey),
      ),
      margin: EdgeInsets.only(left: 12, top: 4),
    );
  }

  createCartList(Data data, context) {
    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      itemBuilder: (context, index) {
        return createCartListItem(data.cartItems[index], context);
      },
      itemCount: data.cartItems.length,
    );
  }

  createCartListItem(CartItem product, context) {
    return Stack(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(
              left: getProportionateScreenWidth(16),
              right: getProportionateScreenWidth(16),
              top: getProportionateScreenHeight(16)),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(16))),
          child: Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(right: 8, left: 8, top: 8, bottom: 8),
                width: getProportionateScreenWidth(100),
                height: getProportionateScreenHeight(100),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(14)),
                    // color: Colors.blue.shade200,
                    image: DecorationImage(
                        image: NetworkImage(product.product.image))),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(right: 8, top: 4),
                        child: Text(
                          product.product.name,
                          maxLines: 2,
                          softWrap: true,
                          style: CustomTextStyle.textFormFieldSemiBold
                              .copyWith(fontSize: 14),
                        ),
                      ),
                      Utils.getSizedBox(height: 6),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "\$${product.product.price}",
                              style: CustomTextStyle.textFormFieldBlack
                                  .copyWith(color: KPrimaryColor),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      ShopCubit.get(context)
                                          .updateCartsDataFromApi(
                                              id: product.id,
                                              quantity: product.quantity + 1);
                                    },
                                    icon: Icon(Icons.add),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        right: getProportionateScreenWidth(3),
                                        left: getProportionateScreenWidth(3),
                                        bottom:
                                            getProportionateScreenHeight(12.0)),
                                    child: CustomText(
                                      text: "${product.quantity}",
                                      size: 18,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        bottom:
                                            getProportionateScreenHeight(10)),
                                    child: IconButton(
                                      onPressed: () {
                                        ShopCubit.get(context)
                                            .updateCartsDataFromApi(
                                                id: product.id,
                                                quantity: product.quantity - 1);
                                      },
                                      icon: Icon(Icons.minimize),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                flex: 100,
              )
            ],
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: InkWell(
            onTap: () {
              print(product.product.id.toString());
              ShopCubit.get(context)
                  .addOrRemoveCartsDataFromApi(id: product.product.id);
            },
            child: Container(
              width: 24,
              height: 24,
              alignment: Alignment.center,
              margin: EdgeInsets.only(right: 10, top: 8),
              child: Icon(
                Icons.close,
                color: Colors.white,
                size: 20,
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  color: KPrimaryColor),
            ),
          ),
        )
      ],
    );
  }
}
