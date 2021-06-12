import 'package:elbya3/model/register_model.dart';
import 'package:elbya3/model/user_model.dart';

abstract class LoginStates{

}

class InitShopState extends LoginStates{}
class ChangePasswordIconState extends LoginStates{}
class LoginSuccessState extends LoginStates{
  final UserModel model;

  LoginSuccessState(this.model);
}
class LoginErrorState extends LoginStates{
  final String error;

  LoginErrorState(this.error);
}
class LoginLoadingState extends LoginStates{}

class RegisterSuccessState extends LoginStates{
  final RegisterModel model;

  RegisterSuccessState(this.model);
}
class RegisterErrorState extends LoginStates{
  final String error;

  RegisterErrorState(this.error);
}
class RegisterLoadingState extends LoginStates{}