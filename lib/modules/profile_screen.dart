import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_laen_taswaq2/layout/cubit/cubit.dart';
import 'package:tik_laen_taswaq2/shared/components/components.dart';
import 'package:tik_laen_taswaq2/shared/styles/color.dart';

import 'login/cubit/cubit.dart';
import 'login/cubit/states.dart';
import 'login/login_screen.dart';

class ProfileScrren extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var oldPasswordController = TextEditingController();
  var newPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              appBar: AppBar(
                title: Text(
                  'الملف الشخصي ',
                  style: TextStyle(fontSize: 22),
                ),
                centerTitle: true,
                backgroundColor: defaultColor,
                toolbarHeight: 80,
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(right: 10, left: 10, top: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'تغيير كلمة المرور',
                        style: TextStyle(fontSize: 22),
                      ),
                      Form(
                        key: formKey,
                        child: Column(
                          children: [
                            defualtTextFormField(
                              maxLines: 1,
                              hintText: 'ادخل كلمة المرور القديمة',
                              type: TextInputType.visiblePassword,
                              /*validate: (value) {
                              if (value.isEmpty) {
                                return 'please enter your email address';
                              }
                            },*/
                              controller: oldPasswordController,
                            ),
                            defualtTextFormField(
                              maxLines: 1,
                              hintText: 'كلمة المرور الجديدة',
                              type: TextInputType.visiblePassword,
                              suffix: ShopLoginCubit.get(context).suffix,
                              isPassword:
                                  ShopLoginCubit.get(context).isPassword,
                              suffixPressed: () {
                                ShopLoginCubit.get(context)
                                    .changePasswordVisibility();
                              },
                              /* validate: (value) {
                              if (value.isEmpty) {
                                return 'password is too short';
                              }
                            },*/
                              controller: newPasswordController,
                              onSubmit: (value) {
                                if (formKey.currentState!.validate()) {
                                  /*ShopLoginCubit.get(context).userLogin(
                                            email: emailController.text,
                                            password: passwordController.text,
                                          );*/
                                }
                              },
                            ),
                            SizedBox(height: 10),
                            defaultButton(
                              width: 220,
                              decoration: BoxDecoration(
                                  color: defaultColor,
                                  borderRadius: BorderRadius.circular(30)),
                              function: () {},
                              text: 'تغيير كلمة المرور',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 30),
                      Text(
                        'انهاء العمل  ',
                        style: TextStyle(fontSize: 30),
                      ),
                      Text(
                        'اضغط انهاء العمل لتنهي عملك',
                        style: TextStyle(fontSize: 20, color: Colors.grey),
                      ),
                      SizedBox(height: 30),
                      Center(
                        child: defaultButton(
                          width: 220,
                          decoration: BoxDecoration(
                              color: defaultColor,
                              borderRadius: BorderRadius.circular(30)),
                          function: () {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginScreen(),
                                ),
                                (route) => false);
                            ShopCubit.get(context).postEndWork();
                            //print(' !!!!!!!!!!!!! ${endWork!.status}');
                          },
                          text: 'انهاء العمل',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                      Container(
                        child: Row(
                          children: [
                            Text(
                              'مبلغ التامين',
                              style: TextStyle(fontSize: 25),
                            ),
                            SizedBox(width: 50),
                            Text(
                              ShopCubit.get(context).profile?.user?.insurance ?? '',
                              style: TextStyle(fontSize: 20,color: defaultColor),
                            ),
                          ],
                        ),
                      ),
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
