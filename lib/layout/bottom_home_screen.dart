import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_laen_taswaq2/modules/order_screen.dart';
import 'package:tik_laen_taswaq2/modules/profile_screen.dart';
import 'package:tik_laen_taswaq2/shared/components/components.dart';
import 'package:tik_laen_taswaq2/shared/styles/color.dart';

import '../modules/home_screen/home_screen.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class BottomHomeScreen extends StatefulWidget {
  @override
  State<BottomHomeScreen> createState() => _BottomHomeScreenState();
}

class _BottomHomeScreenState extends State<BottomHomeScreen> {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = ShopCubit.get(context);
          return Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              bottomNavigationBar: ConvexAppBar(
                items: [
                  TabItem(
                    icon: Image.asset(
                      "assets/images/person.png",
                      color: Colors.grey,
                    ),
                    title: 'حسابي',),
                  TabItem(
                      icon: Image.asset(
                        "assets/images/home.png",
                        color: Colors.grey,
                      ),
                      title: 'الرئيسية'),
                  TabItem(
                    icon: Image.asset(
                      "assets/images/shopping-bag.png",
                      color: Colors.grey,
                    ),
                    title: 'طلباتي',),
                ],
                initialActiveIndex: cubit.currentIndex,
                onTap: (index) {
                  cubit.changeItem(index);
                },
                height: 55,
                backgroundColor: Colors.red,
                activeColor: Colors.white,
              ),
              body: cubit.widgetOptions[cubit.currentIndex],
            ),
          );
        });
  }
}
