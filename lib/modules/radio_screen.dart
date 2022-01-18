import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_laen_taswaq2/layout/bottom_home_screen.dart';
import 'package:tik_laen_taswaq2/layout/cubit/cubit.dart';
import 'package:tik_laen_taswaq2/layout/cubit/states.dart';
import 'package:tik_laen_taswaq2/models/today_orders.dart';
import 'package:tik_laen_taswaq2/modules/home_screen/home_screen.dart';
import 'package:tik_laen_taswaq2/shared/components/components.dart';
import 'package:tik_laen_taswaq2/shared/styles/color.dart';

class RadioScreen extends StatefulWidget {
  Order? order;

  RadioScreen({this.order});

  @override
  _RadioScreenState createState() => _RadioScreenState();
}

class _RadioScreenState extends State<RadioScreen> {
  late int selectedValue;

  var cancelController = TextEditingController();

  @override
  void initState() {
    super.initState();
    selectedValue = 0;
  }

  setSelectedRadio(int val) {
    setState(() {
      selectedValue = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(listener: (context, state) {
      if (state is ShopSuccessCancelOrderState) {
        if (state.cancelOrder.status!) {
          print('aaaaaaaaaaaaaaaaaaa');
          print(state.cancelOrder.msg!);
          showToast(text: state.cancelOrder.msg!, state: ToastStates.ERROR);
        }
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
              SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 21),
                  child: Column(
                    children: [
                      Text(
                        "اكتب سبب الرفض",
                        style:
                        TextStyle(fontSize: 18, color: Color(0xFF4A4B4D)),
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      Divider(
                        color: Color(0xFF707070),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          color: Color(0xFFF6F6F6),
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  child: Text(
                                    "لا يوحد بنزين",
                                    style: TextStyle(
                                        fontSize: 16, color: Color(0xFF2D2D2D)),
                                  ),
                                  alignment: Alignment.centerRight,
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  child: Radio(
                                    activeColor: Color(0xFFFC6011),
                                    value: 1,
                                    groupValue: selectedValue,
                                    onChanged: (int? value) {
                                      setSelectedRadio(value!);
                                    },
                                  ),
                                  alignment: Alignment.centerLeft,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 17,
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          color: Color(0xFFF6F6F6),
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  child: Text(
                                    "مشكلة في الفزبة",
                                    style: TextStyle(
                                        fontSize: 16, color: Color(0xFF2D2D2D)),
                                  ),
                                  alignment: Alignment.centerRight,
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  child: Radio(
                                    activeColor: Color(0xFFFC6011),
                                    value: 2,
                                    groupValue: selectedValue,
                                    onChanged: (int? value) {
                                      setSelectedRadio(value!);
                                    },
                                  ),
                                  alignment: Alignment.centerLeft,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 17,
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          color: Color(0xFFF6F6F6),
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  child: Text(
                                    "لدي مشوار اخر",
                                    style: TextStyle(
                                        fontSize: 16, color: Color(0xFF2D2D2D)),
                                  ),
                                  alignment: Alignment.centerRight,
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  child: Radio(
                                    activeColor: Color(0xFFFC6011),
                                    value: 3,
                                    groupValue: selectedValue,
                                    onChanged: (int? value) {
                                      setSelectedRadio(value!);
                                    },
                                  ),
                                  alignment: Alignment.centerLeft,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 17,
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          color: Color(0xFFF6F6F6),
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  child: Text(
                                    "امر طارئ",
                                    style: TextStyle(
                                        fontSize: 16, color: Color(0xFF2D2D2D)),
                                  ),
                                  alignment: Alignment.centerRight,
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  child: Radio(
                                    activeColor: Color(0xFFFC6011),
                                    value: 4,
                                    groupValue: selectedValue,
                                    onChanged: (int? value) {
                                      setSelectedRadio(value!);
                                    },
                                  ),
                                  alignment: Alignment.centerLeft,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Container(
                        width: double.infinity,
                        child: Text(
                          "لدي سبب اخر !",
                          style:
                          TextStyle(fontSize: 16, color: Color(0xFF2D2D2D)),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: cancelController,
                        maxLines: 3,
                        cursorColor: Color(0xFFFC6011),
                        decoration: InputDecoration(
                          hintText: "اكتب سبب الرفض",
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
                      SizedBox(
                        height: 75,
                      ),
                      defaultButton(
                        width: 330,
                        decoration: BoxDecoration(
                            color: defaultColor,
                            borderRadius: BorderRadius.circular(30)),
                        function: () {
                          /*if (cancelController.text.isNotEmpty) {
                            ShopCubit.get(context).postCancelOrder(
                                widget.order!.id!, cancelController.text);
                            showToast(text: 'تم رفض الطلب بنجاح',
                                state: ToastStates.SUCCESS);
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(
                                    builder: (context) => BottomHomeScreen()));
                            print(
                                '${widget.order!.id!} + ${cancelController
                                    .text}');
                          } else {
                            showToast(text: 'لا يوجد سبب لارساله',
                                state: ToastStates.ERROR);
                          }*/
                          if(selectedValue == 1){
                            ShopCubit.get(context).postCancelOrder(
                                widget.order!.id!, 'لا يوحد بنزين');
                            showToast(text: 'تم رفض الطلب بنجاح',
                                state: ToastStates.SUCCESS);
                            ShopCubit.get(context)
                                .getTodayOrder();
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(
                                    builder: (context) => BottomHomeScreen()));
                            print(
                                '${widget.order!.id!} + ${cancelController
                                    .text}');
                          }else if(selectedValue == 2){
                            ShopCubit.get(context).postCancelOrder(
                                widget.order!.id!, 'مشكلة في الفزبة');
                            showToast(text: 'تم رفض الطلب بنجاح',
                                state: ToastStates.SUCCESS);
                            ShopCubit.get(context)
                                .getTodayOrder();
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(
                                    builder: (context) => BottomHomeScreen()));
                            print(
                                '${widget.order!.id!} + ${cancelController
                                    .text}');
                          }else if(selectedValue == 3){
                            ShopCubit.get(context).postCancelOrder(
                                widget.order!.id!, 'لدي مشوار اخر');
                            showToast(text: 'تم رفض الطلب بنجاح',
                                state: ToastStates.SUCCESS);
                            ShopCubit.get(context)
                                .getTodayOrder();
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(
                                    builder: (context) => BottomHomeScreen()));
                            print(
                                '${widget.order!.id!} + ${cancelController
                                    .text}');
                          }else if(selectedValue == 4){
                            ShopCubit.get(context).postCancelOrder(
                                widget.order!.id!, 'امر طارئ');
                            showToast(text: 'تم رفض الطلب بنجاح',
                                state: ToastStates.SUCCESS);
                            ShopCubit.get(context)
                                .getTodayOrder();
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(
                                    builder: (context) => BottomHomeScreen()));
                            print(
                                '${widget.order!.id!} + ${cancelController
                                    .text}');
                          }else{
                            showToast(text: 'لا يوجد سبب لارساله',
                                state: ToastStates.ERROR);
                          }
                        },
                        text: 'ارسل',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
