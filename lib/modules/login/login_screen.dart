import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_laen_taswaq2/models/login_model.dart';
import 'package:tik_laen_taswaq2/modules/login/cubit/cubit.dart';
import 'package:tik_laen_taswaq2/modules/login/cubit/states.dart';
import 'package:tik_laen_taswaq2/modules/welcome/welcome_screen.dart';
import 'package:tik_laen_taswaq2/shared/components/components.dart';
import 'package:tik_laen_taswaq2/shared/components/constants.dart';
import 'package:tik_laen_taswaq2/shared/network/local/cache_helper.dart';
import 'package:tik_laen_taswaq2/shared/styles/color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../layout/bottom_home_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var formKey = GlobalKey<FormState>();

  var emailController = TextEditingController();

  var passwordController = TextEditingController();
  String? device_token ;
 // final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseMessaging fcm = FirebaseMessaging.instance;
  @override
  void initState() {
    super.initState();
  fcm.getToken().then((token){
      print('the token is : '+ token!);
      device_token = token ;
      print('the token is : '+ device_token!);

    });
  }

  @override
  Widget build(BuildContext context) {
    const double kDefaultPadding = 20.0;
    Size size = MediaQuery.of(context).size;

    return BlocProvider(
      create: (BuildContext context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (context, state) {
          if (state is ShopLoginSuccessState) {
            if (state.loginModel.status!) {
              print('#########################');
              // print(state.loginModel.msg);
              print(state.loginModel.user!.name);
              print(state.loginModel.user!.token);

              CacheHelper.saveData(
                key: 'token',
                value: state.loginModel.user!.token,
              ).then((value) {
                token = state.loginModel.user!.token!;
                navigateAndFinish(
                  context,
                  WelcomeScreen(),
                );
              });
            } else {
              print(state.loginModel.msg);

              showToast(
                text: state.loginModel.msg!,
                state: ToastStates.ERROR,
              );
            }
          }
        },
        builder: (context, state) {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              body: SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: kDefaultPadding * 2.3),
                        height: size.height * 0.4,
                        child: Stack(
                          children: [
                            Container(
                              width: double.infinity,
                              height: size.height * 0.4 - 60,
                              decoration: BoxDecoration(
                                  color: Colors.deepOrangeAccent,
                                  borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(15),
                                    bottomLeft: Radius.circular(15),
                                  )),
                              child: Image.asset(
                                'assets/images/Organetopshape.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                                left: 0,
                                bottom: 0,
                                //بتقدر من هان تنزل الدائرة اكتر او اقل
                                right: 0,
                                child: CircleAvatar(
                                  radius: 70,
                                  backgroundColor: Colors.white,
                                  child: Image.asset(
                                    'assets/images/logo.png',
                                    height: 204,
                                    width: 220,
                                  ),
                                )),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'تسجيل دخول',
                        style: TextStyle(fontSize: 30),
                      ),
                      Form(
                        key: formKey,
                        child: Column(
                          children: [
                            defualtTextFormField(
                              maxLines: 1,
                              hintText: 'ادخل الايميل',
                              type: TextInputType.emailAddress,
                              onSubmit: (value) {
                                if (formKey.currentState!.validate()) {
                                  /*ShopLoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );*/

                                }
                              },
                              validate: (value) {
                                if (value.isEmpty) {
                                  return 'please enter your email address';
                                }
                              },
                              controller: emailController,
                            ),
                            defualtTextFormField(
                              maxLines: 1,
                              hintText: 'كلمة المرور',
                              type: TextInputType.visiblePassword,
                              suffix: ShopLoginCubit.get(context).suffix,
                              isPassword:
                                  ShopLoginCubit.get(context).isPassword,
                              suffixPressed: () {
                                ShopLoginCubit.get(context)
                                    .changePasswordVisibility();
                              },
                              validate: (value) {
                                if (value.isEmpty) {
                                  return 'password is too short';
                                }
                              },
                              controller: passwordController,
                              onSubmit: (value) {
                                if (formKey.currentState!.validate()) {
                                  /*ShopLoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );*/
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 30),
                      (state is! ShopLoginLoadingState)
                          ? defaultButton(
                              decoration: BoxDecoration(
                                color: defaultColor,
                                borderRadius: BorderRadius.circular(
                                  30,
                                ),
                              ),
                              radius: 30,
                              width: 350,
                              function: () {
                                if (formKey.currentState!.validate()) {
                                  ShopLoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text,
                                    token: device_token.toString(),
                                  );
                                  print('the token is :$device_token');
                                  print(emailController.text);
                                  CacheHelper.saveData(
                                      key: 'email',
                                      value: emailController.text);
                                }
                                /*     if(state is ShopLoginSuccessState){
                                  navigateAndFinish(
                                    context,
                                    WelcomeScreen(user: emailController.text,),
                                    //WelcomeScreen(),
                                  );
                                }
*/
                                //showToast(text: ShopLoginCubit.get(context).loginModel!.msg!.toString(), state: ToastStates.ERROR);
                              },
                              text: "دخول",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20))
                          : Center(child: CircularProgressIndicator()),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
