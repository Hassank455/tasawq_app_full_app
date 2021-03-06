import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:tik_laen_taswaq2/layout/cubit/cubit.dart';
import 'package:tik_laen_taswaq2/layout/cubit/states.dart';
import 'package:tik_laen_taswaq2/models/balance.dart';
import 'package:tik_laen_taswaq2/models/new_order.dart';
import 'package:tik_laen_taswaq2/models/today_orders.dart';
import 'package:tik_laen_taswaq2/modules/billing/bill_screen.dart';
import 'package:tik_laen_taswaq2/modules/fcm.dart';
import 'package:tik_laen_taswaq2/modules/home_screen/refresh_widget.dart';
import 'package:tik_laen_taswaq2/modules/login/login_screen.dart';
import 'package:tik_laen_taswaq2/shared/components/components.dart';
import 'package:tik_laen_taswaq2/shared/network/Notification/pushNotificationService.dart';
import 'package:tik_laen_taswaq2/shared/styles/color.dart';

import 'alert_dialog.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();

}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController scrollController = ScrollController();
  // TodayOrder? model;

  Order4? order3 = Order4();
  Timer? timer;
  int? index;

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  void time()async{
    new Timer.periodic(Duration(seconds: 5), (Timer t) => setState((){
      // ShopCubit.get(context).todayOrders!;
      ShopCubit.get(context).getNewOrder();
      //  ShopCubit.get(context).getBalance();
      ShopCubit.get(context).postUserTrack();
      print('ddddd');
      print(ShopCubit.get(context).profile?.user?.name);
      ShopCubit.get(context).getNewOrder();
    }));
  }
  @override
  void initState() {
    super.initState();
    time();



    PushNotificationService pushNotificationService = PushNotificationService(order2: order3,index:index );
    pushNotificationService.initialize(context,order3!);
    //pushNotificationService.getToken();
  }


  @override
  void dispose() {
    ShopCubit.get(context).postUserTrack();
    time();
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {

    NewOrder? model;
    Balance? balance;
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          model = ShopCubit.get(context).newOrders;
          balance = ShopCubit.get(context).balance;

          return SafeArea(
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: RefreshWidget(
                onRefresh: () async {
                  ShopCubit.get(context).getTodayOrder();
                  ShopCubit.get(context).getBalance();

                },
                child: Scaffold(
                  body: SingleChildScrollView(
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            containerHomePage(
                              width: double.infinity,
                              height: 200.h,
                              color: defaultColor,
                              alignment: Alignment.topCenter,
                              padding: EdgeInsets.only(top: 20),
                              child: Column(
                                children: [
                                  Text(
                                    '???????? ????????????',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 22.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    ShopCubit.get(context).profile?.user?.name ?? '',
                                    style: TextStyle(color: Colors.white,
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold),
                                  ),

                                ],
                              ),
                            ),
                            Center(
                              child: containerHomePage(
                                margin: EdgeInsets.only(top: 130),
                                width: 300,
                                height: 200,
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        spreadRadius: 4,
                                        blurRadius: 10,
                                        offset: Offset(0, 3),
                                      )
                                    ],
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(30)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(right: 30, top: 10),
                                      padding: EdgeInsets.all(5),
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '???????? ???????????? | ??????????????',
                                            style: TextStyle(fontSize: 23),
                                          ),
                                          SizedBox(height: 15),
                                          Row(
                                            children: [
                                              Text(
                                                'NIS',
                                                style: TextStyle(fontSize: 15),
                                              ),
                                              SizedBox(width: 10),
                                              balance != null
                                                  ? Text(balance!.balance![1],
                                                  style:
                                                  TextStyle(fontSize: 35))
                                                  : Text('0',
                                                  style: TextStyle(
                                                      fontSize: 35)),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15),
                        Container(
                          alignment: Alignment.bottomRight,
                          padding: EdgeInsets.only(right: 25, top: 20),
                          child: Text(
                            '?????????????? ???????? ??????????',
                            style: TextStyle(fontSize: 25),
                          ),
                        ),
                        SizedBox(height: 15),
                        model != null
                            ? (model!.order2!.length != 0)
                            ? ListView.builder(
                          controller: scrollController,
                          shrinkWrap: true,
                          itemCount: model!.order2!.length,
                          itemBuilder: (context, index) {
                            return listViewText(
                                context, model!.order2![index],index);
                          },
                        )
                            : Center(
                          child: Text(
                            '???? ???????? ?????????? ??????????   !!!!!',
                            style: TextStyle(fontSize: 20),
                          ),
                        )
                            : Padding(
                          padding: const EdgeInsets.only(top: 120),
                          child: Center(child: CircularProgressIndicator()),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }

  Widget listViewText(context, Order4? model,int index) {
    return Column(
      children: [
        containerHomePage(
            width: 300,
            height: 200,
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 4,
                blurRadius: 10,
                offset: Offset(0, 3),
              )
            ], color: Colors.white, borderRadius: BorderRadius.circular(25)),
            child: Container(
              margin: EdgeInsets.only(right: 20, top: 20, left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${model?.fromId?.name ?? '-'}',
                    style: TextStyle(fontSize: 23, color: defaultColor),
                  ),
                  Text(
                    '${model?.fromAddress?.address ?? '-'}',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                    maxLines: 2,
                  ),
                  SizedBox(height: 7),
                  myDivider(),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '   ?????????? | #${model?.id ?? '-'}',
                        style: TextStyle(fontSize: 15),
                      ),
                      SizedBox(width: 10),
                      defaultButton(
                        decoration: BoxDecoration(
                          color: defaultColor,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        width: 100,
                        height: 32,
                        function: () {
                          // initState();
                    //      dispose();
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BillScreen(
                                      order: model,
                                      index :index
                                  ))
                          );
                        },
                        text: '????????????????',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ],
                  ),
                ],
              ),
            )),
        SizedBox(height: 20),
      ],
    );
  }
}