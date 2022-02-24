import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_laen_taswaq2/layout/cubit/cubit.dart';
import 'package:tik_laen_taswaq2/layout/cubit/states.dart';
import 'package:tik_laen_taswaq2/models/new_order.dart';
import 'package:tik_laen_taswaq2/models/today_orders.dart';
import 'package:tik_laen_taswaq2/modules/goAddress_screen.dart';
import 'package:tik_laen_taswaq2/modules/home_screen/home_screen.dart';
import 'package:tik_laen_taswaq2/shared/components/components.dart';
import 'package:tik_laen_taswaq2/shared/styles/color.dart';

class AlertDialogRequestPrice extends StatefulWidget {
  Order4? order;

  AlertDialogRequestPrice({this.order});

  @override
  State<AlertDialogRequestPrice> createState() => _AlertDialogRequestPriceState();
}

class _AlertDialogRequestPriceState extends State<AlertDialogRequestPrice> {
  void initState() {
    super.initState();

  }
  bool isButtonClickable = true;
  @override
  Widget build(BuildContext context) {
    var noteController = TextEditingController();
    return BlocConsumer<ShopCubit, ShopStates>(listener: (context, state) {
      if (state is ShopSuccessRequestPriceState) {
        setState(() {
          widget.order!.status!;
        });
        print('msg requestPrice');
        print(ShopCubit.get(context).requestPrice!.msg);
        Navigator.pop(context);
        showToast(
            text: '${ShopCubit.get(context).requestPrice!.msg}',
            state: ToastStates.SUCCESS);
      }
    }, builder: (context, state) {
      return Directionality(
        textDirection: TextDirection.rtl,
        child: AlertDialog(
          content: Container(
            width: double.infinity,
            height: 250,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 30.0),
                TextField(
                  controller: noteController,
                  maxLines: 3,
                  cursorColor: Color(0xFFFC6011),
                  decoration: InputDecoration(
                    hintText: "اكتب التفاصيل",
                    helperStyle:
                        TextStyle(fontSize: 14, color: Color(0xFF6A6A6A)),
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
                SizedBox(height: 50.0),
                defaultButton(
                  width: 230,
                  decoration: BoxDecoration(
                      color: defaultColor,
                      borderRadius: BorderRadius.circular(30)),
                  function: () async{
                    if(isButtonClickable){
                      if(noteController.text.isNotEmpty){
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

                        ShopCubit.get(context).getRequestPrice(widget.order!.id!,noteController.text);
                        // setState(() {
                        //   widget.order!.status!;
                        //   widget.order!.id!;
                        //   widget.order!.price;
                        //
                        // });
                        setState(() {
                          widget.order!.status!;
                        });
                      }else{
                        print("isButtonClickable");
                        print(isButtonClickable);
                        showToast(
                            text: 'ثم بتعبئة الملاحظات',
                            state: ToastStates.ERROR);

                      }
                    }

                  },
                  text: 'ارسال',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
