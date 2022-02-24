import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tik_laen_taswaq2/layout/bottom_home_screen.dart';
import 'package:tik_laen_taswaq2/layout/cubit/cubit.dart';
import 'package:tik_laen_taswaq2/layout/cubit/states.dart';
import 'package:tik_laen_taswaq2/models/accept_order.dart';
import 'package:tik_laen_taswaq2/models/new_order.dart';
import 'package:tik_laen_taswaq2/models/today_orders.dart';
import 'package:tik_laen_taswaq2/modules/billing/dialog_for_add_information.dart';
import 'package:tik_laen_taswaq2/modules/goAddress_screen.dart';
import 'package:tik_laen_taswaq2/modules/home_screen/home_screen.dart';
import 'package:tik_laen_taswaq2/modules/home_screen/refresh_widget.dart';
import 'package:tik_laen_taswaq2/modules/radio_screen.dart';
import 'package:tik_laen_taswaq2/shared/components/components.dart';
import 'package:tik_laen_taswaq2/shared/styles/color.dart';

class BillScreen extends StatefulWidget {
  Order4? order;
  int? index;
  BillScreen({this.order, this.index});

  @override
  _BillScreenState createState() => _BillScreenState();
}

var refreshKey = GlobalKey<RefreshIndicatorState>();

class _BillScreenState extends State<BillScreen> {
  Position? currentPosition;

  Future<void> getMyLocation() async {
    Position position1 = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    currentPosition = position1;
    print(
        "This is your current Position ::${currentPosition?.longitude} ${currentPosition?.longitude}");
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        content:  Text('هل تريد الانتفال الى الصفحة الرئيسية ؟'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text('لا'),
          ),
          TextButton(
            onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>BottomHomeScreen())),
            child: new Text('نعم'),
          ),
        ],
      ),
    )) ?? false;
  }
  @override
  Widget build(BuildContext context) {

    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is ShopSuccessAcceptOrderState) {
          if (state.acceptOrder.status) {
            showToast(text: state.acceptOrder.msg, state: ToastStates.SUCCESS);

          }
        }
      },
      builder: (context, state) {

        int? paidPriceSum = int.parse((ShopCubit.get(context)
            .newOrders!.order2![widget.index!].paidPrice) ?? '0');
        int? priceSum = int.parse((ShopCubit.get(context)
            .newOrders!.order2![widget.index!].price) ?? '0');
        return Directionality(
            textDirection: TextDirection.rtl,
            child: WillPopScope(
              onWillPop: _onWillPop,
              child: Scaffold(
                  body: RefreshWidget(
                    onRefresh: () async {
                      ShopCubit.get(context).getTodayOrder();
                    },
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 40.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding:  EdgeInsets.only(left: 100.h),
                                  child: Text('  فاتورة #${(ShopCubit.get(context)
                                      .newOrders!.order2![widget.index!].id)}',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 20.sp)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 18),
                                  child: GestureDetector(
                                      onTap: () {
                                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> BottomHomeScreen()));
                                      },
                                      child: Icon(Icons.arrow_forward_ios_outlined)),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 13.h),
                          containerBillScreen(
                            context: context,
                            name: (ShopCubit.get(context)
                                .newOrders!.order2![widget.index!].fromId?.name) ?? '-',
                            address: (ShopCubit.get(context)
                                .newOrders!.order2![widget.index!].fromAddress?.address) ?? '-',
                            mobile: (ShopCubit.get(context)
                                .newOrders!.order2![widget.index!].fromMobile) ?? '',
                            latudide: (ShopCubit.get(context)
                                .newOrders!.order2![widget.index!].fromAddress?.lat),
                            longtuide: (ShopCubit.get(context)
                                .newOrders!.order2![widget.index!].fromAddress?.lng),
                            id: (ShopCubit.get(context)
                                .newOrders!.order2![widget.index!].toAddress?.id),
                          ),
                          SizedBox(height: 13.h),
                          Center(child: myDivider(width: 360.w)),
                          SizedBox(height: 13.h),
                          ((ShopCubit.get(context)
                              .newOrders!.order2![widget.index!].toId) != null &&
                              (ShopCubit.get(context)
                                  .newOrders!.order2![widget.index!].fromId) != null/* && widget.order?.toId != null &&
                          widget.order?.toAddress != null*/)
                              ? containerBillScreen(
                            context: context,
                            name: (ShopCubit.get(context)
                                .newOrders!.order2![widget.index!].toId?.name) ?? '-',
                            address: (ShopCubit.get(context)
                                .newOrders!.order2![widget.index!].toAddress?.address) ?? '-',
                            mobile: (ShopCubit.get(context)
                                .newOrders!.order2![widget.index!].toMobile) ?? '',
                            latudide: (ShopCubit.get(context)
                                .newOrders!.order2![widget.index!]).toAddress?.lat,
                            longtuide: (ShopCubit.get(context)
                                .newOrders!.order2![widget.index!].toAddress?.lng),
                            id: (ShopCubit.get(context)
                                .newOrders!.order2![widget.index!].toAddress?.id),
                          )
                              : Center(
                              child: GestureDetector(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      barrierDismissible: true,
                                      builder: (BuildContext context) =>
                                          DialogForAddInformation(order: widget.order,),
                                    );
                                  },
                                  child: Icon(Icons.add, size: 35.h))),

                          SizedBox(height: 13.h),
                          myDivider(width: double.infinity, height: 8),
                          Padding(
                            padding:  EdgeInsets.all(18.0.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'التفاصيل',
                                  style: TextStyle(fontSize: 18.sp),
                                ),
                                Text(
                                  (ShopCubit.get(context)
                                      .newOrders!.order2![widget.index!].details) ?? '-',
                                  style: TextStyle(fontSize: 12.sp),
                                ),
                              ],
                            ),
                          ),
                          Center(child: myDivider(width: 350.w)),
                          Padding(
                            padding:  EdgeInsets.all(20.0.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'ملاحظة',
                                  style: TextStyle(fontSize: 18.sp, color: defaultColor),
                                ),
                                Text(
                                  (ShopCubit.get(context)
                                      .newOrders!.order2![widget.index!].notes) ?? '-',
                                  style: TextStyle(fontSize: 14.sp),
                                ),
                              ],
                            ),
                          ),
                          myDivider(width: double.infinity, height: 8.h),
                          Container(
                            padding: EdgeInsets.only(right: 20.h, left: 20.h),
                            child: Column(
                              children: [
                                RowTodayOrder(
                                    text1: 'مبلغ الطلبية',
                                    numberText: '$paidPriceSum',
                                    nisText: ' NIS '),
                                SizedBox(height: 5.h),
                                RowTodayOrder(
                                    text1: 'تكلفة التوصيل',
                                    numberText: '$priceSum  ',
                                    nisText: ' NIS '),
                                SizedBox(height: 15.h),
                                myDivider(width: 380.w),
                                SizedBox(height: 10.h),
                                RowTodayOrder(
                                    text1: 'الاجمالي',
                                    numberText: '${paidPriceSum + priceSum} ',
                                    color2: defaultColor,
                                    nisText: ' NIS ',
                                    color: defaultColor),
                              ],
                            ),
                          ),
                          SizedBox(height: 18.h),
                          myDivider(width: double.infinity, height: 8),
                          SizedBox(height: 17.h),
                          Center(
                              child: Column(
                                children: [
                                  (ShopCubit.get(context)
                                      .newOrders!.order2![widget.index!]
                                      .status) == 0
                                      ? Column(
                                    children: [
                                      defaultButton(
                                        width: 330,
                                        decoration: BoxDecoration(
                                            color: defaultColor,
                                            borderRadius:
                                            BorderRadius.circular(30)),
                                        function: () {

                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      GoAddressScreen(
                                                          order: widget.order,
                                                          index:widget.index)));
                                          ShopCubit.get(context)
                                              .postAcceptOrder(widget.order!.id!);
                                          ShopCubit.get(context).postTrackUser(id:widget.order?.id);
                                          ShopCubit.get(context).postTrackUser(
                                            id: (ShopCubit.get(context)
                                                .newOrders!.order2![widget.index!].id),
                                            lat: currentPosition?.longitude.toString(),
                                            lng: currentPosition?.latitude.toString(),
                                          );


                                          /*
                                          ShopCubit.get(context)
                                              .getTodayOrder();
                                        */

                                        },
                                        text: 'قبول الطلب',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 19.sp,
                                        ),
                                      ),
                                      SizedBox(height: 18.h),
                                      TextButton(
                                        onPressed: () =>
                                            show(context, widget.order!),
                                        child: Text(
                                          "رفض الطلب",
                                          style: TextStyle(
                                              color: Colors.black, fontSize: 20.sp),
                                        ),
                                      )
                                    ],
                                  )
                                      : Container(),
                                  (ShopCubit.get(context)
                                      .newOrders!.order2![widget.index!]
                                      .status) == 1 || (ShopCubit.get(context)
                                      .newOrders!.order2![widget.index!]
                                      .status) == 2
                                      ? Column(
                                    children: [
                                      defaultButton(
                                        width: 330.w,
                                        decoration: BoxDecoration(
                                            color: defaultColor,
                                            borderRadius:
                                            BorderRadius.circular(30)),
                                        function: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      GoAddressScreen(
                                                          order: widget.order,
                                                          index:widget.index
                                                      )));
                                          /*  ShopCubit.get(context)
                                            .getTodayOrder();*/
                                        },
                                        text: 'اتمام الطلب',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20.sp,
                                        ),
                                      ),
                                    ],
                                  )
                                      : Container(),
                                  SizedBox(height: 176.h),
                                ],
                              )),
                        ],
                      ),
                    ),
                  )),
            ));
      },
    );
  }

  void show(context, Order4? order) {
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        context: context,
        builder: (context) {
          return RadioScreen(
            order: order,
          );
        });
  }
}