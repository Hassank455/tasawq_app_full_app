import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_laen_taswaq2/layout/cubit/cubit.dart';
import 'package:tik_laen_taswaq2/layout/cubit/states.dart';
import 'package:tik_laen_taswaq2/models/accept_order.dart';
import 'package:tik_laen_taswaq2/models/today_orders.dart';
import 'package:tik_laen_taswaq2/modules/billing/dialog_for_add_information.dart';
import 'package:tik_laen_taswaq2/modules/goAddress_screen.dart';
import 'package:tik_laen_taswaq2/modules/home_screen/refresh_widget.dart';
import 'package:tik_laen_taswaq2/modules/radio_screen.dart';
import 'package:tik_laen_taswaq2/shared/components/components.dart';
import 'package:tik_laen_taswaq2/shared/styles/color.dart';

class BillScreen extends StatefulWidget {
  Order? order;
  int? index;

  BillScreen({this.order, this.index});

  @override
  _BillScreenState createState() => _BillScreenState();
}

var refreshKey = GlobalKey<RefreshIndicatorState>();

class _BillScreenState extends State<BillScreen> {
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

        int? paidPriceSum = int.parse(widget.order?.paidPrice ?? '0');
        int? priceSum = int.parse(widget.order?.price ?? '0');
        return Directionality(
            textDirection: TextDirection.rtl,
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
                          margin: EdgeInsets.only(top: 40),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 100),
                                child: Text('  فاتورة #${widget.order!.id}',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 22)),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Icon(Icons.arrow_forward_ios_outlined)),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 15),
                        containerBillScreen(
                          context: context,
                          name: widget.order?.fromId?.name ?? '-',
                          address: widget.order?.fromAddress?.address ?? '-',
                          mobile: widget.order?.fromMobile ?? '',
                          latudide: widget.order?.fromAddress?.lat,
                          longtuide: widget.order?.fromAddress?.lng,
                          id: widget.order?.toAddress?.id,
                        ),
                        SizedBox(height: 15),
                        Center(child: myDivider(width: 360)),
                        SizedBox(height: 15),
                        (widget.order?.toId != null &&
                            widget.order?.fromId != null/* && widget.order?.toId != null &&
                        widget.order?.toAddress != null*/)
                            ? containerBillScreen(
                          context: context,
                          name: widget.order?.toId?.name ?? '-',
                          address: widget.order?.toAddress?.address ?? '-',
                          mobile: widget.order?.toMobile ?? '',
                          latudide: widget.order?.toAddress?.lat,
                          longtuide: widget.order?.toAddress?.lng,
                          id: widget.order?.toAddress?.id,
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
                                child: Icon(Icons.add, size: 40))),

                        SizedBox(height: 15),
                        myDivider(width: double.infinity, height: 8),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'التفاصيل',
                                style: TextStyle(fontSize: 20),
                              ),
                              Text(
                                widget.order?.details ?? '-',
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                        Center(child: myDivider(width: 350)),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'ملاحظة',
                                style: TextStyle(fontSize: 20, color: defaultColor),
                              ),
                              Text(
                                widget.order?.notes ?? '-',
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                        myDivider(width: double.infinity, height: 8),
                        Container(
                          padding: EdgeInsets.only(right: 20, left: 20),
                          child: Column(
                            children: [
                              RowTodayOrder(
                                  text1: 'مبلغ الطلبية',
                                  numberText: '$paidPriceSum',
                                  nisText: ' NIS '),
                              SizedBox(height: 5),
                              RowTodayOrder(
                                  text1: 'تكلفة التوصيل',
                                  numberText: '$priceSum  ',
                                  nisText: ' NIS '),
                              SizedBox(height: 15),
                              myDivider(width: 380),
                              SizedBox(height: 10),
                              RowTodayOrder(
                                  text1: 'الاجمالي',
                                  numberText: '${paidPriceSum + priceSum} ',
                                  color2: defaultColor,
                                  nisText: ' NIS ',
                                  color: defaultColor),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        myDivider(width: double.infinity, height: 8),
                        SizedBox(height: 20),
                        Center(
                            child: Column(
                              children: [
                                (ShopCubit.get(context)
                                    .todayOrders!.order![widget.index!]
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

                                        /*
                                        ShopCubit.get(context)
                                            .getTodayOrder();
                                      */

                                      },
                                      text: 'قبول الطلب',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 22,
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                    TextButton(
                                      onPressed: () =>
                                          show(context, widget.order!),
                                      child: Text(
                                        "رفض الطلب",
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 20),
                                      ),
                                    )
                                  ],
                                )
                                    : Container(),
                                (ShopCubit.get(context)
                                    .todayOrders!.order![widget.index!]
                                    .status) == 1 || (ShopCubit.get(context)
                                    .todayOrders!.order![widget.index!]
                                    .status) == 2
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
                                                        index:widget.index
                                                    )));
                                        /*  ShopCubit.get(context)
                                          .getTodayOrder();*/
                                      },
                                      text: 'اتمام الطلب',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 22,
                                      ),
                                    ),
                                  ],
                                )
                                    :  (ShopCubit.get(context)
                                    .todayOrders!.order![widget.index!]
                                    .status) == 3?
                                Container()
                                    : Container(),
                                SizedBox(height: 180),
                              ],
                            )),
                      ],
                    ),
                  ),
                )));
      },
    );
  }

  void show(context, Order order) {
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