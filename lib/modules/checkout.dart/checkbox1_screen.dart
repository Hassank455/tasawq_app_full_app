import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_laen_taswaq2/layout/cubit/cubit.dart';
import 'package:tik_laen_taswaq2/layout/cubit/states.dart';
import 'package:tik_laen_taswaq2/models/confirm_receive.dart';
import 'package:tik_laen_taswaq2/models/today_orders.dart';
import 'package:tik_laen_taswaq2/modules/home_screen/home_screen.dart';
import 'package:tik_laen_taswaq2/shared/components/components.dart';
import 'package:tik_laen_taswaq2/shared/styles/color.dart';

import '../goAddress_screen.dart';
import 'alert_dialog_request_price.dart';

class Checkbox1Screen extends StatefulWidget {
  Order? order;
  int? index;
  Checkbox1Screen({this.order, this.index});

  @override
  _CheckboxScreenState createState() => _CheckboxScreenState();
}

class _CheckboxScreenState extends State<Checkbox1Screen> {
  var paidController = TextEditingController();

  late bool checked;
  void initState() {
    super.initState();
    checked = false;
    // new Timer.periodic(Duration(seconds: 3), (Timer t) => setState((){
    //   ShopCubit.get(context).balance!;
    //   ShopCubit.get(context).todayOrders!;
    //   ShopCubit.get(context).getTodayOrder();
    //   ShopCubit.get(context).getBalance();
    //   widget.order!;
    //   widget.order!.status!;
    //   widget.order!.price!;
    // }));

  }

  @override
  Widget build(BuildContext context) {
    ConfirmReceive? confirmReceive;
    int? paid = 0;
    return BlocConsumer<ShopCubit, ShopStates>(listener: (context, state) {
     // confirmReceive = ShopCubit.get(context).confirmReceive;
      if (state is ShopSuccessConfirmReceiveState) {
        confirmReceive = ShopCubit.get(context).confirmReceive;
        print('msg ShopSuccessDeliverOrderState');
       // print(state.confirmReceive.msg);
        print(confirmReceive!.msg);
        if (confirmReceive!.status!) {
          showToast(
              text: 'تم تاكيد الاستلام',
              state: ToastStates.SUCCESS);
          setState(() {
            widget.order?.status!;
          });
          Navigator.pop(context);
        } else {
          showToast(
              text: '${confirmReceive?.msg ?? ''}', state: ToastStates.ERROR);
        }
      } else if (state is ShopErrorConfirmReceiveState) {
        showToast(
            text: '${confirmReceive!.msg ?? ''}', state: ToastStates.ERROR);
        //showToast(text: '${ShopCubit.get(context).confirmReceive?.msg ?? ''}', state: ToastStates.ERROR);

      }
    }, builder: (context, state) {
      return Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 21),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/checkout.png',
                    ),
                    Text(
                      "تأكيد استلام المنتج",
                      style: TextStyle(fontSize: 26, color: Color(0xFF4A4B4D)),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Text(
                      "سعر المنتجات",
                      style: TextStyle(fontSize: 17, color: Color(0xFF4A4B4D)),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "المبلغ الذي تم دفعه ثمن المنتجات",
                      style: TextStyle(fontSize: 15, color: Color(0xFF6A6A6A)),
                    ),
                    SizedBox(height: 15),
                    TextField(
                      controller: paidController,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 24, color: Color(0xFF6A6A6A)),
                      cursorColor: Color(0xFFFC6011),
                      decoration: InputDecoration(
                        suffix: Text(
                          "NIS",
                          style:
                              TextStyle(fontSize: 20, color: Color(0xFF6A6A6A)),
                        ),
                        hintText: "00:00",
                        hintStyle:
                            TextStyle(fontSize: 24, color: Color(0xFF6A6A6A)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                            color: Color(0xFFBBBBBB),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                            color: Color(0xFFFC6011),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 27),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Checkbox(
                          activeColor: Color(0xFFFC6011),
                          value: checked,
                          onChanged: (bool? value) {
                            setState(() {
                              checked = value!;
                            });
                            if (value == true) {
                              paid = 1;
                              print(paid);
                            } else {
                              paid = 0;
                              print(paid);
                            }
                          },
                        ),
                        Text(
                          "فى حال لم تدفع سعر المنتجات حدد هذا الخيار",
                          style:
                              TextStyle(fontSize: 14, color: Color(0xFFFC6011)),
                        ),
                      ],
                    ),
                    SizedBox(height: 65),
                    defaultButton(
                      width: 330,
                      decoration: BoxDecoration(
                          color: defaultColor,
                          borderRadius: BorderRadius.circular(30)),
                      function: () {
                        print('postConfirmReceive');

                        print(
                            '${widget.order!.id} paid: $paid ${paidController.text}');
                        if (paidController.text.isNotEmpty) {
                          ShopCubit.get(context).postConfirmReceive(
                            widget.order!.id!,
                            widget.order?.price ?? '',
                            paidController.text,
                            widget.order?.paid ?? 0,
                          );

                          // print('${ShopCubit.get(context).confirmReceive!.order!.id}');
                        } else {
                          showToast(
                              text: 'ادخل المبلغ الذي تود دفعه',
                              state: ToastStates.ERROR);
                        }

                      },
                      text: 'ارسل',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                      ),
                    ),
                    SizedBox(height: 65),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
