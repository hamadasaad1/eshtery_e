import 'package:conditional_builder/conditional_builder.dart';
import 'package:elbya3/constants.dart';
import 'package:elbya3/core/network/local/local_helper.dart';
import 'package:elbya3/core/view_model/login_cubit.dart';
import 'package:elbya3/core/view_model/login_states.dart';
import 'package:elbya3/size_config.dart';
import 'package:elbya3/view/component/component.dart';
import 'package:elbya3/view/component/custom_svg_.dart';
import 'package:elbya3/view/component/custom_text.dart';
import 'package:elbya3/view/component/default_bottom.dart';
import 'package:elbya3/view/screens/home_layout.dart';
import 'package:elbya3/view/screens/home_screen.dart';
import 'package:elbya3/view/screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatelessWidget {
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerPhone = TextEditingController();
  var _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginStates>(
      listener: (context, state) {
        if (state is RegisterSuccessState) {
          if (state.model.status) {
            snackBar(context, state.model.message);
            //when success save token in shared and go to home screen
            CacheHelper.setDataToSharedPref(
                    key: "token", value: state.model.data.token)
                .then((value) {
              changeNavigatorReplacement(context, HomeLayout());
            });
          } else {
            print(state.model.message);
            snackBar(context, state.model.message);
          }
        } else if (state is RegisterErrorState) {
          snackBar(context, state.error);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(getProportionateScreenHeight(15)),
                child: buildForm(context, state),
              ),
            ),
          ),
        );
      },
    );
  }

  Form buildForm(BuildContext context, LoginStates state) {
    return Form(
      key: _key,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: CustomSvg(
              height: getProportionateScreenHeight(150),
              width: getProportionateScreenWidth(150),
              iconPath: 'assets/icons/shop_one.svg',
            ),
          ),
          SizedBox(
            height: getProportionateScreenHeight(10),
          ),
          CustomText(
            text: 'Sign Up',
            size: 22,
            color: KPrimaryColor,
          ),
          SizedBox(
            height: getProportionateScreenHeight(10),
          ),
          CustomText(
            text: 'Welcome register now ',
            color: Colors.grey,
          ),
          SizedBox(
            height: getProportionateScreenHeight(20),
          ),
          textFormFiled(
            label: 'Name',
            controller: controllerName,
            validate: (String value) {
              if (value.isEmpty) {
                return kNameNullError;
              } else {
                return null;
              }
            },
            type: TextInputType.text,
            preIcon: Icons.person,
            // widget: Icon(Icons.visibility_rounded)
          ),
          SizedBox(
            height: getProportionateScreenHeight(20),
          ),
          textFormFiled(
            label: 'Phone',
            controller: controllerPhone,
            validate: (String value) {
              if (value.isEmpty) {
                return kPhoneNumberNullError;
              } else {
                return null;
              }
            },
            type: TextInputType.phone,
            preIcon: Icons.phone,
            // widget: Icon(Icons.visibility_rounded)
          ),
          SizedBox(
            height: getProportionateScreenHeight(20),
          ),
          textFormFiled(
            label: 'Email',
            controller: controllerEmail,
            validate: (String value) {
              if (value.isEmpty) {
                return kEmailNullError;
              } else {
                return null;
              }
            },
            type: TextInputType.emailAddress,
            preIcon: Icons.email,
            // widget: Icon(Icons.visibility_rounded)
          ),
          SizedBox(
            height: getProportionateScreenHeight(20),
          ),
          textFormFiled(
              label: 'Password',
              controller: controllerPassword,
              obscureText: LoginCubit.get(context).isChange,
              validate: (String value) {
                if (value.isEmpty) {
                  return kPassNullError;
                } else {
                  return null;
                }
              },
              type: TextInputType.emailAddress,
              preIcon: Icons.lock_outline,
              widget: InkWell(
                  onTap: () {
                    LoginCubit.get(context).changePasswordIcon();
                  },
                  child: Icon(LoginCubit.get(context).iconData))),
          SizedBox(
            height: getProportionateScreenHeight(30),
          ),
          ConditionalBuilder(
            condition: (state is! RegisterLoadingState),
            builder: (context) => DefaultButton(
              text: 'REGISTER',
              press: () {
                if (_key.currentState.validate()) {
                  LoginCubit.get(context).userRegister(
                      name: controllerName.text,
                      phone: controllerPhone.text,
                      email: controllerEmail.text,
                      password: controllerPassword.text);
                }
              },
            ),
            fallback: (context) => const Center(
              child: CircularProgressIndicator(),
            ),
          ),
          SizedBox(
            height: getProportionateScreenHeight(15),
          ),
          // Row(
          //   children: [
          //     CustomText(
          //       text: 'Don\'t have an account ?',
          //     ),
          //     TextButton(
          //       onPressed: () {
          //         changeNavigator(context, RegisterScreen());
          //       },
          //       child: const Text('REGISTER'),
          //     )
          //   ],
          // )
        ],
      ),
    );
  }
}
