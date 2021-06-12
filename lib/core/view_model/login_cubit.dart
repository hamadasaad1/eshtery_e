import 'package:bloc/bloc.dart';
import 'package:elbya3/core/network/remot/dio_helper.dart';
import 'package:elbya3/core/network/remot/end_points.dart';
import 'package:elbya3/core/view_model/login_states.dart';
import 'package:elbya3/model/register_model.dart';
import 'package:elbya3/model/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(InitShopState());

  static LoginCubit get(context) => BlocProvider.of(context);

  IconData iconData = Icons.visibility_rounded;
  bool isChange = true;

  void changePasswordIcon() {
    isChange = !isChange;
    iconData = isChange ? Icons.visibility_off : Icons.visibility_rounded;
    emit(ChangePasswordIconState());
  }

  UserModel model;

  void userLogin({
    @required String email,
    @required String password,
  }) {
    emit(LoginLoadingState());
    DioHelper.postData(url: LOGIN, query: {
      'email': email,
      'password': password,
    }).then((value) {
      print(value.data.toString());

      model = UserModel.fromJson(value.data);
      KToken = model.data.token;
      emit(LoginSuccessState(model));
    }).catchError((error) {
      print("Error" + error.toString());
      emit(LoginErrorState(error.toString()));
    });
  }

  RegisterModel registerModel;

  void userRegister({
    @required String email,
    @required String password,
    @required String name,
    @required String phone,
  }) {
    emit(RegisterLoadingState());
    DioHelper.postData(
      url: REGISTER,
      query: {
        "name": name,
        "phone": phone,
        'email': email,
        'password': password,
        'image': ''
      },
    ).then((value) {
      print(value.data.toString());

      registerModel = RegisterModel.fromJson(value.data);
      KToken = registerModel.data.token;
      emit(RegisterSuccessState(registerModel));
    }).catchError((error) {
      print("Error" + error.toString());
      emit(RegisterErrorState(error.toString()));
    });
  }
}
