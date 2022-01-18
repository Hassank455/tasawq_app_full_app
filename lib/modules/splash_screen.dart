import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tik_laen_taswaq2/modules/login/login_screen.dart';
import 'package:tik_laen_taswaq2/shared/network/local/cache_helper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void submit() {
    CacheHelper.saveData(
      key: 'onBoarding',
      value: true,
    ).then((value) {
      if (value) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
      }
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(milliseconds: 4000), () {
      submit();
    });



  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  'assets/images/Background icons.png',
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  fit: BoxFit.cover,
                ),
                Image.asset('assets/images/logo.png'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
