import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_laen_taswaq2/layout/cubit/cubit.dart';
import 'package:tik_laen_taswaq2/layout/cubit/states.dart';
import 'package:tik_laen_taswaq2/models/details_order.dart';
import 'package:tik_laen_taswaq2/models/today_orders.dart';
import 'package:tik_laen_taswaq2/shared/components/components.dart';
import 'package:tik_laen_taswaq2/shared/styles/color.dart';

class OrderScreen extends StatelessWidget {
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    TodayOrder? model;

    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        model = ShopCubit.get(context).todayOrders;
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            appBar: AppBar(
              title: Text(
                'طلبات اليوم ',
                style: TextStyle(fontSize: 22),
              ),
              centerTitle: true,
              backgroundColor: defaultColor,
              toolbarHeight: 80,
            ),
            body: SingleChildScrollView(
              child: Container(
                color: Colors.grey[100],
                child: Column(
                  children: [
                    Container(
                      height: 55,
                      color: Colors.white,
                      padding: EdgeInsets.only(left: 30, right: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'عدد الطلبات (${model!.order!.length})',
                            //'${ShopCubit.get(context).todayOrders!.order!.length}',
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ),
                          Text(
                            '${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}',
                            style: TextStyle(fontSize: 18, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 40),
                    model != null
                        ? (model!.order!.length != 0)
                        ? ListView.builder(
                      controller: scrollController,
                      shrinkWrap: true,
                      itemCount: ShopCubit.get(context)
                          .todayOrders!
                          .order!
                          .length,
                      itemBuilder: (context, index) {
                        return todayOrderFinesh(model!.order![index]);
                      },
                    )
                        : Center(
                      child: Text(
                        'لا يوجد طلبات اليوم   !!!!!',
                        style: TextStyle(fontSize: 20),
                      ),
                    )
                        : Padding(
                      padding: const EdgeInsets.only(top: 120),
                      child: Center(child: CircularProgressIndicator()),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget todayOrderFinesh(Order? model) {
    return Column(
      children: [
        containerHomePage(
            width: 360,
            height: 270,
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 5.5,
                offset: Offset(0, 3),
              )
            ], color: Colors.white, borderRadius: BorderRadius.circular(25)),
            child: Container(
              margin: EdgeInsets.only(right: 20, top: 10, left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${model?.fromId?.name ?? '-'}',
                        style: TextStyle(fontSize: 23, color: defaultColor),
                      ),
                      SizedBox(height: 10),
                      RowTodayOrder(
                          text1: 'اجمالي الطلب',
                          numberText: '${model?.paidPrice ?? '0'} | ',
                          nisText: ' NIS '),
                      SizedBox(height: 5),
                      RowTodayOrder(
                          text1: 'تكلفة التوصيل',
                          numberText: '${model?.price ?? 0} | ',
                          nisText: ' NIS '),
                      SizedBox(height: 5),
                      RowTodayOrder(
                          text1: 'المبلغ المتبقي',
                          numberText: '${model?.remain ?? '0'} | ',
                          nisText: ' NIS '),
                      SizedBox(height: 20),
                      myDivider(),
                      SizedBox(height: 20),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            'وقت التسليم  | ',
                            style: TextStyle(fontSize: 17, color: Colors.grey),
                          ),
                          SizedBox(width: 5),
                          Container(
                            width: 100,
                            child: Text(
                              '${model?.deliveryTime ?? '-'} ',
                              style: TextStyle(fontSize: 17, color: Colors.black),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 10),
                      defaultButton(
                        decoration: BoxDecoration(
                          color: Color(0xFF00DD8C),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        width: 100,
                        height: 32,
                        function: () {},
                        text: 'تم التسليم',
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
