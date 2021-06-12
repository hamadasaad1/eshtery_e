import 'package:conditional_builder/conditional_builder.dart';
import 'package:elbya3/constants.dart';
import 'package:elbya3/core/network/local/local_helper.dart';
import 'package:elbya3/core/view_model/shop_cubit.dart';
import 'package:elbya3/core/view_model/shop_states.dart';
import 'package:elbya3/size_config.dart';
import 'package:elbya3/view/component/component.dart';
import 'package:elbya3/view/component/custom_svg_.dart';
import 'package:elbya3/view/component/default_bottom.dart';
import 'package:elbya3/view/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingScreen extends StatefulWidget {
  @override
  MapScreenState createState() => MapScreenState();
}

class MapScreenState extends State<SettingScreen>
    with SingleTickerProviderStateMixin {
  bool _status = true;
  final FocusNode myFocusNode = FocusNode();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var key = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(listener: (context, state) {
      if (state is! ShopLoadingProfile) {
        var cubit = ShopCubit.get(context);
        nameController.text = cubit.userModel.data.name ?? '';
        emailController.text = cubit.userModel.data.email ?? "";

        phoneController.text = cubit.userModel.data.phone ?? "";
      }
    }, builder: (context, state) {
      var cubit = ShopCubit.get(context);

      return ConditionalBuilder(
        condition: state is! ShopLoadingProfile && cubit.userModel != null,
        builder: (context) => Container(
          color: Colors.white,
          child: SingleChildScrollView(
            child: Form(
              key: key,
              child: Column(
                children: <Widget>[
                  Container(
                    height: 250.0,
                    color: Colors.white,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                              top: getProportionateScreenHeight(20.0)),
                          child: Stack(
                            fit: StackFit.loose,
                            children: <Widget>[
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                      width: getProportionateScreenWidth(140.0),
                                      height:
                                          getProportionateScreenHeight(140.0),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          image: NetworkImage(
                                              cubit.userModel.data.image),
                                          fit: BoxFit.cover,
                                        ),
                                      )),
                                ],
                              ),
                              Padding(
                                  padding: EdgeInsets.only(
                                    top: getProportionateScreenHeight(90.0),
                                    right: getProportionateScreenWidth(100.0),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      CircleAvatar(
                                        backgroundColor: KPrimaryColor,
                                        radius:
                                            getProportionateScreenWidth(25.0),
                                        child: Icon(
                                          Icons.camera_alt,
                                          color: Colors.white,
                                        ),
                                      )
                                    ],
                                  )),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    color: Color(0xffFFFFFF),
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 25.0),
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 25.0),
                              child: new Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      new Text(
                                        'Parsonal Information',
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      _status
                                          ? _getEditIcon()
                                          : new Container(),
                                    ],
                                  )
                                ],
                              )),
                          buildLabel('Name'),
                          buildTextField(
                              control: nameController,
                              hint: 'Enter Your Name',
                              icon: Icons.person,
                              validate: (String value) {
                                if (value.isEmpty) {
                                  return 'Enter Name Please';
                                } else {
                                  return null;
                                }
                              }),
                          buildLabel('Email ID'),
                          buildTextField(
                              control: emailController,
                              hint: 'Enter Your Email',
                              icon: Icons.email,
                              validate: (String value) {
                                if (value.isEmpty) {
                                  return 'Enter Email Please';
                                } else {
                                  return null;
                                }
                              }),
                          buildLabel('Mobile'),
                          buildTextField(
                              control: phoneController,
                              hint: 'Enter Your Phone',
                              icon: Icons.phone,
                              validate: (String value) {
                                if (value.isEmpty) {
                                  return 'Enter Phone Please';
                                } else {
                                  return null;
                                }
                              }),
                          !_status ? _getActionButtons(context) : Container(),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                child: TextButton(
                              onPressed: () {
                                CacheHelper.deleteDataToSharedPref(key: 'token')
                                    .then((value) {
                                  changeNavigatorReplacement(
                                      context, ShopLoginScreen());
                                });
                              },
                              child: ListTile(
                                title: const Text(
                                  'Log Out',
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700),
                                ),
                                trailing: CustomSvg(
                                  iconPath: 'assets/icons/Log out.svg',
                                  height: getProportionateScreenHeight(30),
                                ),
                              ),
                            )),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        fallback: (context) => Center(
          child: CircularProgressIndicator(),
        ),
      );
    });
  }

  buildLabel(String label) {
    return Padding(
        padding: EdgeInsets.only(
          left: getProportionateScreenWidth(25.0),
          right: getProportionateScreenWidth(25.0),
          top: getProportionateScreenHeight(25.0),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  label,
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ));
  }

  buildTextField({control, String hint, Function validate, IconData icon}) {
    return Padding(
      padding: EdgeInsets.only(
        left: getProportionateScreenWidth(25.0),
        right: getProportionateScreenWidth(25.0),
        top: getProportionateScreenHeight(2.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Flexible(
            child: TextFormField(
              controller: control,
              validator: validate,
              decoration: InputDecoration(
                prefixIcon: Icon(icon),
                hintText: hint,
              ),
              enabled: !_status,
              autofocus: !_status,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    myFocusNode.dispose();
    super.dispose();
  }

  Widget _getActionButtons(context) {
    return Padding(
      padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 45.0),
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: DefaultButton(
                text: 'Save',
                press: () {
                  if (key.currentState.validate()) {
                    ShopCubit.get(context).updateProfileFromApi(
                      name: nameController.text,
                      email: emailController.text,
                      phone: phoneController.text,
                    );
                    setState(
                      () {
                        _status = true;
                        FocusScope.of(context).requestFocus(new FocusNode());
                      },
                    );
                  }
                },
              ),
            ),
            flex: 2,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: DefaultButton(
                color: Colors.red,
                text: 'Cancel',
                press: () {
                  setState(
                    () {
                      _status = true;
                      FocusScope.of(context).requestFocus(new FocusNode());
                    },
                  );
                },
              ),
            ),
            flex: 2,
          ),
        ],
      ),
    );
  }

  Widget _getEditIcon() {
    return new GestureDetector(
      child: new CircleAvatar(
        backgroundColor: KPrimaryColor,
        radius: 14.0,
        child: new Icon(
          Icons.edit,
          color: Colors.white,
          size: 16.0,
        ),
      ),
      onTap: () {
        setState(() {
          _status = false;
        });
      },
    );
  }
}
