import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tik_laen_taswaq2/layout/cubit/cubit.dart';
import 'package:tik_laen_taswaq2/layout/cubit/states.dart';
import 'package:tik_laen_taswaq2/models/confirm_receive.dart';
import 'package:tik_laen_taswaq2/models/new_order.dart';
import 'package:tik_laen_taswaq2/models/today_orders.dart';
import 'package:tik_laen_taswaq2/modules/home_screen/home_screen.dart';
import 'package:tik_laen_taswaq2/shared/components/components.dart';
import 'package:tik_laen_taswaq2/shared/components/constants.dart';
import 'package:tik_laen_taswaq2/shared/styles/color.dart';

import '../goAddress_screen.dart';
import 'alert_dialog_request_price.dart';

class Checkbox1Screen extends StatefulWidget {
  Order4? order;
  int? index;
  Checkbox1Screen({this.order, this.index});

  @override
  _CheckboxScreenState createState() => _CheckboxScreenState();
}

class _CheckboxScreenState extends State<Checkbox1Screen> {
  var paidController = TextEditingController();


  /*Future<void> map()async{

  }
  late Position? position;*/
      late bool checked;
  void initState()  {
    super.initState();
    checked = false;
    /*Future.delayed(Duration(seconds: 2),()async {
      position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
    });*/
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

  /*@override
  void didChangeDependencies() async {
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high) ;
    super.didChangeDependencies();
  }*/
  bool isButtonClickable = true;

  @override
  Widget build(BuildContext context) {

    /*print('@#@#@#');
    print(position?.latitude.toString());
    print(position?.longitude.toString());*/

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
          Navigator.pop(context);
          showToast(
              text: '???? ?????????? ????????????????',
              state: ToastStates.SUCCESS);
          setState(() {
            widget.order?.status!;
          });
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
                      "?????????? ???????????? ??????????",
                      style: TextStyle(fontSize: 26, color: Color(0xFF4A4B4D)),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Text(
                      "?????? ??????????????",
                      style: TextStyle(fontSize: 17, color: Color(0xFF4A4B4D)),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "???????????? ???????? ???? ???????? ?????? ??????????????",
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
                          "???? ?????? ???? ???????? ?????? ?????????????? ?????? ?????? ????????????",
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
                      function: ()  async{

                        if(isButtonClickable){

                          position = await Geolocator.getCurrentPosition(
                              desiredAccuracy: LocationAccuracy.high) ;
                          print('@#@#@#');
                          print(position?.latitude.toString());
                          print(position?.longitude.toString());

                          print('postConfirmReceive');

                          print(
                              '${widget.order!.id} paid: $paid ${paidController.text}');
                          if (paidController.text.isNotEmpty) {
                            Duration time = Duration(seconds: 8);
                            setState(() {
                              isButtonClickable = false;                     //make the button disable to making variable false.
                              print("Clicked Once");
                              print(isButtonClickable);

                              Future.delayed(time,(){
                                setState(() {
                                  isButtonClickable = true;                    //future delayed to change the button back to clickable
                                });
                              });
                            });
                            ShopCubit.get(context).postConfirmReceive(
                                widget.order!.id!,
                                widget.order?.price ?? '',
                                paidController.text,
                                widget.order?.paid ?? 0,
                                position!.latitude.toString(),
                                position!.longitude.toString()
                            );

                            // print('${ShopCubit.get(context).confirmReceive!.order!.id}');
                          } else {
                            showToast(
                                text: '???????? ???????????? ???????? ?????? ????????',
                                state: ToastStates.ERROR);
                          }

                        }

                      },
                      text: '????????',
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
Position? position;
/*
void map()async{
   position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high) ;
}*/
