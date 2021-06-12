import 'package:conditional_builder/conditional_builder.dart';
import 'package:elbya3/constants.dart';
import 'package:elbya3/core/view_model/shop_cubit.dart';
import 'package:elbya3/core/view_model/shop_states.dart';
import 'package:elbya3/model/notification_model.dart';
import 'package:elbya3/size_config.dart';
import 'package:elbya3/view/component/expanadable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifiction'),
      ),
      body: BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = ShopCubit.get(context);
          return ConditionalBuilder(
            condition: state is! ShopNotificationLoading &&
                cubit.notificationModel != null,
            builder: (context) => Padding(
              padding:  EdgeInsets.all(getProportionateScreenHeight(10)),
              child: ListView.separated(
                  itemBuilder: (context, index) => buildNotificationItem(context,
                      cubit.notificationModel.data.notificationData[index]),
                  separatorBuilder: (context, index) => SizedBox(
                        height: getProportionateScreenHeight(10),
                      ),
                  itemCount:
                      cubit.notificationModel.data.notificationData.length),
            ),
            fallback: (context)=>const Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }

  Container buildNotificationItem(
      BuildContext context, NotificationData notificationData) {
    return Container(
      height: getProportionateScreenHeight(150),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: KPrimaryLightColor),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              notificationData.title,
              style: Theme.of(context).textTheme.bodyText1.copyWith(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w700),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ExpandableText(
                  notificationData.message,
                  trimLines: 2,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
