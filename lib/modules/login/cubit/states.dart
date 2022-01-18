import 'package:tik_laen_taswaq2/models/login_model.dart';

abstract class ShopLoginStates {}

class ShopLoginInitialState extends ShopLoginStates {}

class ShopLoginLoadingState extends ShopLoginStates {}

class ShopLoginSuccessState extends ShopLoginStates {
  final ShopLoginModel loginModel;

  ShopLoginSuccessState(this.loginModel);
}

class ShopLoginErrorState extends ShopLoginStates {
  final String error;

  ShopLoginErrorState(this.error);
}

class ShopLoginGetUserInfoState extends ShopLoginStates {}

class ShopLoginSuccessGetUserInfoState extends ShopLoginStates {
  final User user;

  ShopLoginSuccessGetUserInfoState(this.user);
}

class ShopLoginErrorGetUserInfoState extends ShopLoginStates {
  final String error;

  ShopLoginErrorGetUserInfoState(this.error);
}

class ShopRegisterChangePasswordVisibilityState extends ShopLoginStates {}
