import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tik_laen_taswaq2/models/login_model.dart';
import 'package:tik_laen_taswaq2/modules/login/cubit/states.dart';
import 'package:tik_laen_taswaq2/shared/network/end_points.dart';
import 'package:tik_laen_taswaq2/shared/network/remote/dio_helper.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit() : super(ShopLoginInitialState());

  static ShopLoginCubit get(context) => BlocProvider.of(context);

  ShopLoginModel? loginModel;
 // User? user;

  void userLogin({
    required String email,
    required String password,
    required token,
  })
  {
    emit(ShopLoginLoadingState());

    DioHelper.postData(
      url: LOGIN,
      data:
      {
        'email': email,
        'password': password,
        'device_token': token
      },
    ).then((value)
    {
      print(value.data);
      loginModel = ShopLoginModel.fromJson(value.data);
     // user = loginModel!.user;
      emit(ShopLoginSuccessState(loginModel!));
    }).catchError((error)
    {
      print(error.toString());
      emit(ShopLoginErrorState(error.toString()));
    });
  }

  /* User? user;

  void getUserInfo()
  {
    emit(ShopLoginGetUserInfoState());

    DioHelper.getData(
      url: LOGIN,
    ).then((value)
    {
      print(value.data);
      user = User.fromJson(value.data);
      // user = loginModel!.user;
      emit(ShopLoginSuccessGetUserInfoState(user!));
    }).catchError((error)
    {
      print(error.toString());
      emit(ShopLoginErrorGetUserInfoState(error.toString()));
    });
  }
*/
  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility()
  {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined ;

    emit(ShopRegisterChangePasswordVisibilityState());
  }


}