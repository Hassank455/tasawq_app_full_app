import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tik_laen_taswaq2/layout/bottom_home_screen.dart';
import 'package:tik_laen_taswaq2/layout/cubit/cubit.dart';
import 'package:tik_laen_taswaq2/layout/cubit/states.dart';
import 'package:tik_laen_taswaq2/models/deliver_order.dart';
import 'package:tik_laen_taswaq2/models/new_order.dart';

import 'package:tik_laen_taswaq2/models/today_orders.dart';
import 'package:tik_laen_taswaq2/modules/billing/bill_screen.dart';
import 'package:tik_laen_taswaq2/modules/home_screen/home_screen.dart';
import 'package:tik_laen_taswaq2/shared/components/components.dart';
import 'package:tik_laen_taswaq2/shared/components/constants.dart';
import 'package:tik_laen_taswaq2/shared/styles/color.dart';

import '../goAddress_screen.dart';
import 'alert_dialog_request_price.dart';
import 'checkbox1_screen.dart';
import 'myAddress_screen.dart';


class Checkbox2Screen extends StatefulWidget {
  Order4? order;
  int? index;
  Checkbox2Screen({this.order, this.index});

  @override
  _Checkbox2ScreenState createState() => _Checkbox2ScreenState();
}

class _Checkbox2ScreenState extends State<Checkbox2Screen> {
   bool isButtonClick= true;
  var paidController2 = TextEditingController();
  TextEditingController productPriceController = TextEditingController();

  int? selectedValue;
  int? idRemain;


  setSelectedRadio(int val) {
    setState(() {
      selectedValue = val;
    });
  }



  @override
  void didChangeDependencies() {
    var arg = ModalRoute.of(context)!.settings.arguments;
    String? paidpp = (ShopCubit.get(context)
        .newOrders!.order2![widget.index!]
        .paidPrice);
    productPriceController.text = paidpp ?? '0';
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    paidController2.dispose();
    productPriceController.dispose();
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    DeliverOrder? deliverOrder;

    return BlocConsumer<ShopCubit, ShopStates>(listener: (context, state) {
      if (state is ShopSuccessDeliverOrderState) {
        deliverOrder = ShopCubit.get(context).deliverOrder;

        print('msg ShopSuccessDeliverOrderState');
        print(deliverOrder!.msg);
        if (deliverOrder!.status!) {
          showToast(text: 'تم تاكيد التسليم', state: ToastStates.SUCCESS);
        }
        Navigator.pop(context);
        // print(ShopCubit.get(context).deliverOrder!.msg);
        // showToast(text: '${ShopCubit.get(context).deliverOrder!.msg}', state: ToastStates.SUCCESS);
      } else if (state is ShopErrorDeliverOrderState) {
        showToast(text: '${deliverOrder?.msg ?? ''}', state: ToastStates.ERROR);
        //showToast(text: '${ShopCubit.get(context).deliverOrder!.msg}', state: ToastStates.ERROR);

      }
    }, builder: (context, state) {
      //deliverOrder = ShopCubit.get(context).deliverOrder;
      int? price = int.parse((ShopCubit.get(context)
          .newOrders!.order2![widget.index!]
          .price) ?? '0');

      return Container(
        width: double.infinity,
        height: 650,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 30),
              Padding(
                padding:  EdgeInsets.only(right: 15.h, left: 15.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      alignment: Alignment.topRight,
                      padding: EdgeInsets.only(right: 15.h),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.close,
                          size: 28.h,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 18.h),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'فاتورة التسليم',
                    style: TextStyle(fontSize: 18.sp),
                  ),
                  Column(
                    children: [
                      Padding(
                        padding:
                         EdgeInsets.only(right: 18.h, left: 18.h, top: 18.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'NIS',
                                ),
                                SizedBox(width: 18.h),
                                Container(
                                  width: 68.w,
                                  child: TextFormField(
                                    //controller: productPriceController,
                                    controller: productPriceController,
                                    keyboardType: TextInputType.number,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'please enter a number';
                                      }
                                    },
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 1.w, color: Colors.grey),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              'سعر الطلبات',
                              style:
                              TextStyle(fontSize: 18.sp, color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:  EdgeInsets.all(18.0.h),
                        child: RowTodayOrder2(
                          text1: 'تكلفة التوصيل',
                          numberText: (ShopCubit.get(context)
                              .newOrders!.order2![widget.index!]
                              .price) ?? 0,
                          color2: Colors.black,
                          nisText: ' NIS    ',
                          color: Colors.black,
                        ),
                      ),
                      myDivider(width: 360),
                      Padding(
                        padding:
                         EdgeInsets.only(right: 28.w, left: 18.w, top: 10.h),
                        child: RowTodayOrder2(
                          text1: 'الاجمالي',
                          numberText:
                          '${(int.parse(productPriceController.text)) + price} ',
                          nisText: ' NIS ',
                          color2: defaultColor,
                          color: defaultColor,
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 27.h),
                  Text(
                    'المبلغ الاجمالي المستلم ',
                    style: TextStyle(fontSize: 20.sp),
                  ),
                  SizedBox(height: 10.h),
                  /*Text(
                    'المبلغ الذي تم تحصيله من الزبون',
                    style: TextStyle(fontSize: 19, color: Colors.grey),
                  ),*/
                  SizedBox(height: 10.h),
                  Padding(
                    padding:  EdgeInsets.only(right: 50.h, left: 50.h),
                    child: TextField(
                      enabled: (ShopCubit.get(context)
                          .newOrders!.order2![widget.index!]
                          .paid) == null ? false : true,
                      controller: paidController2,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        suffix: Text(
                          "NIS",
                          style:
                          TextStyle(fontSize: 20.sp, color: Color(0xFF6A6A6A)),
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
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 50),
                        child: Text('الرصيد    ${widget.order?.fromBalance?.balance ?? '-'}       ',
                        style:TextStyle(fontSize: 18.sp, color: Colors.black),

                        ),
                      ),

                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                // width: 200,
                                child: Text(
                                  widget.order?.fromId?.name ?? '-',
                                  style: TextStyle(
                                      fontSize: 16, color: Color(0xFF2D2D2D)),
                                ),
                                alignment: Alignment.centerRight,
                              ),
                              Container(
                                child: Radio(
                                  activeColor: Color(0xFFFC6011),
                                  value: 1,
                                  groupValue: selectedValue,
                                  onChanged: (int? value) {
                                    setSelectedRadio(value!);
                                    idRemain = value;
                                    print('setSelectedRadio');
                                    print(idRemain);
                                  },
                                ),
                                alignment: Alignment.centerLeft,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 50),
                        child: Text('الرصيد    ${widget.order?.toBalance?.balance ?? '-'}       ',
                        style:TextStyle(fontSize: 18, color: Colors.black),
                            ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                // width: 200,
                                child: Text(
                                  widget.order?.toId?.name ?? '-',
                                  style: TextStyle(
                                      fontSize: 16, color: Color(0xFF2D2D2D)),
                                ),
                                alignment: Alignment.centerRight,
                              ),
                              Container(
                                child: Radio(
                                  activeColor: Color(0xFFFC6011),
                                  value: 2,
                                  groupValue: selectedValue,
                                  onChanged: (int? value) {
                                    setSelectedRadio(value!);
                                    idRemain = value;
                                    print('setSelectedRadio');
                                    print(idRemain);
                                  },
                                ),
                                alignment: Alignment.centerLeft,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 28.h),

                 defaultButton(
                    width: 330,
                    decoration: BoxDecoration(
                        color: defaultColor,
                        borderRadius: BorderRadius.circular(30)),
                    function: () async {
                      if(isButtonClick){

                        position = await Geolocator.getCurrentPosition(
                            desiredAccuracy: LocationAccuracy.high) ;
                        print('@#@#@#');
                        print(position?.latitude.toString());
                        print(position?.longitude.toString());
                        if ((ShopCubit.get(context)
                            .newOrders!.order2![widget.index!]
                            .price) == null) {
                          showToast(
                              text: 'يرجى طلب التسعير', state: ToastStates.ERROR);
                          Navigator.pop(context);
                        } else {
                          if (paidController2.text.isNotEmpty && idRemain == 1) {
                            Duration time = Duration(seconds: 8);
                            setState(() {
                              isButtonClick = false;                     //make the button disable to making variable false.
                              print("Clicked Once");
                              print(isButtonClick);

                              Future.delayed(time,(){
                                setState(() {
                                  isButtonClick = true;                    //future delayed to change the button back to clickable
                                });
                              });
                            });

                            ShopCubit.get(context).postDeliverOrder(
                                widget.order!.id!,
                                paidController2.text.toString(),
                                widget.order!.fromId!.id.toString(),
                                productPriceController.text.toString(),
                                position!.latitude.toString(),
                                position!.longitude.toString()
                            );
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BottomHomeScreen()));
                            showToast(
                                text: 'تم تاكيد التسليم',
                                state: ToastStates.SUCCESS);
                            /* print(
                                  '${deliverOrder!.orderDeliver!.id} ${deliverOrder!.orderDeliver!.remain}');*/
                            /*ShopCubit.get(context).postDeliverOrder(
                                  ShopCubit.get(context).deliverOrder!.orderDeliver!.id!,
                                  paidController2.text.toString(),
                                  ShopCubit.get(context).deliverOrder!.orderDeliver?.remain ?? 'remain');*/
                            print(
                                '${widget.order!.id!}  ${paidController2.text} ${widget.order!.remain ?? 'remain'}');
                          } else if(paidController2.text.isNotEmpty && idRemain == 2){
                            ShopCubit.get(context).postDeliverOrder(
                                widget.order!.id!,
                                paidController2.text.toString(),
                                widget.order!.toId!.id.toString(),
                                productPriceController.text.toString(),
                                position!.latitude.toString(),
                                position!.longitude.toString()

                            );
                            print(widget.order!.toId!.id.toString());
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BottomHomeScreen()));
                            showToast(
                                text: 'تم تاكيد التسليم',
                                state: ToastStates.SUCCESS);
                          }else {

                            showToast(
                                text: 'يرجى ادخال رقم او اختيار احد المستخدمين',
                                state: ToastStates.ERROR);
                          }
                        }

                      }

                    },
                    text: 'تاكيد',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.sp,
                    ),
                  ),
                  SizedBox(height: 18.h),
                  (widget.order!.fromAddress == null &&
                      widget.order!.toAddress == null)
                      ? defaultButton(
                    width: 330.w,
                    decoration: BoxDecoration(
                        color: defaultColor,
                        borderRadius: BorderRadius.circular(30)),
                    function: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BillScreen(
                                order: widget.order,
                              )),
                          ModalRoute.withName('/'));
                    },
                    text: 'عليك الرجوع وادخال البيانات',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.sp,
                    ),
                  )
                      : Container(),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}
