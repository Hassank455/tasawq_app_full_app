import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_laen_taswaq2/layout/bottom_home_screen.dart';
import 'package:tik_laen_taswaq2/layout/cubit/cubit.dart';
import 'package:tik_laen_taswaq2/layout/cubit/states.dart';
import 'package:tik_laen_taswaq2/models/login_model.dart';
import 'package:tik_laen_taswaq2/modules/login/cubit/cubit.dart';
import 'package:tik_laen_taswaq2/modules/login/login_screen.dart';
import 'package:tik_laen_taswaq2/shared/components/components.dart';
import 'package:tik_laen_taswaq2/shared/network/local/cache_helper.dart';
import 'package:tik_laen_taswaq2/shared/styles/color.dart';

import '../login/cubit/states.dart';

class WelcomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();

    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/Delivery vector.png',
                height: 200,
                width: double.infinity,
              ),
              Text(
                '${CacheHelper.getData(key: 'email') ?? 'تم تسجيل بدء العمل'} اهلا بك ',
                style:
                TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'اضغط على بدء العمل لتسجيل عملك بالمكتب',
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                ),
              ),
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: defaultButton(
                    decoration: BoxDecoration(
                      color: defaultColor,
                      borderRadius: BorderRadius.circular(
                        30,
                      ),
                    ),
                    radius: 30,
                    width: double.infinity,
                    function: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return alertDialog2(context, emailController);
                        },
                      );
                      /*ShopCubit.get(context).postStartBalance(
                              emailController.text);
                          print('123456 ${ShopCubit
                              .get(context)
                              .startBalance!
                              .msg}');
                          showToast(text: '${ShopCubit
                              .get(context)
                              .startBalance!
                              .msg}', state: ToastStates.SUCCESS);*/
                    },
                    text: "بدء العمل",
                    style: TextStyle(color: Colors.white, fontSize: 20)),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()));
                    },
                    child: Text(
                      "خروج",
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    )),
              )
            ],
          ),
        ),
      ),
    );
    // });
  }
}