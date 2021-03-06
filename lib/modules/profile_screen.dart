import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tik_laen_taswaq2/layout/cubit/cubit.dart';
import 'package:tik_laen_taswaq2/shared/components/components.dart';
import 'package:tik_laen_taswaq2/shared/components/constants.dart';
import 'package:tik_laen_taswaq2/shared/styles/color.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login/cubit/cubit.dart';
import 'login/cubit/states.dart';
import 'login/login_screen.dart';

class ProfileScrren extends StatefulWidget {
  @override
  State<ProfileScrren> createState() => _ProfileScrrenState();
}

class _ProfileScrrenState extends State<ProfileScrren> {
  var formKey = GlobalKey<FormState>();

  var oldPasswordController = TextEditingController();

  var newPasswordController = TextEditingController();
  @override
  void initState() {
    super.initState();
    new Timer.periodic(Duration(seconds: 5), (Timer t) => setState((){
      // ShopCubit.get(context).todayOrders!;
      // ShopCubit.get(context).getTodayOrder();
      //  ShopCubit.get(context).getBalance();
      ShopCubit.get(context).postUserTrack();
      print('dddddsssss');

      //  ShopCubit.get(context).getNewOrder();
    }));

  }


  @override
  void dispose() {
    ShopCubit.get(context).postUserTrack();
    super.dispose();

  }
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
                  style: TextStyle(fontSize: 22.sp),
                ),
                centerTitle: true,
                backgroundColor: defaultColor,
                toolbarHeight: 80.h,
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding:  EdgeInsets.only(right: 10.h, left: 10.h, top: 20.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'تغيير كلمة المرور',
                        style: TextStyle(fontSize: 18.sp),
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
                            SizedBox(height: 8.h),
                            defaultButton(
                              width: 200.w,
                              decoration: BoxDecoration(
                                  color: defaultColor,
                                  borderRadius: BorderRadius.circular(30)),
                              function: () {},
                              text: 'تغيير كلمة المرور',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Text(
                        'انهاء العمل  ',
                        style: TextStyle(fontSize: 23.sp),
                      ),
                      Text(
                        'اضغط انهاء العمل لتنهي عملك',
                        style: TextStyle(fontSize: 17.sp, color: Colors.grey),
                      ),
                      SizedBox(height: 20.h),
                      Center(
                        child: defaultButton(
                          width: 200.h,
                          decoration: BoxDecoration(
                              color: defaultColor,
                              borderRadius: BorderRadius.circular(30)),
                          function: () async{
                            SharedPreferences preferences = await SharedPreferences.getInstance();
                            await preferences.clear();
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
                            fontSize: 18.sp,
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Container(
                        child: Row(
                          children: [
                            Text(
                              'مبلغ التامين',
                              style: TextStyle(fontSize: 23.sp),
                            ),
                            SizedBox(width: 50.w),
                            Text(
                              ShopCubit.get(context).profile?.user?.insurance ?? '',
                              style: TextStyle(fontSize: 20.sp,color: defaultColor),
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
