import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_laen_taswaq2/layout/cubit/cubit.dart';
import 'package:tik_laen_taswaq2/layout/cubit/states.dart';
import 'package:tik_laen_taswaq2/models/today_orders.dart';
import 'package:tik_laen_taswaq2/shared/components/components.dart';
import 'package:tik_laen_taswaq2/shared/components/constants.dart';
import 'package:tik_laen_taswaq2/shared/styles/color.dart';

import '../billing/bill_screen.dart';

class DialogForAddInformation extends StatelessWidget {

  Order? order;
  DialogForAddInformation({this.order});

  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var addressController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) async {
        if (state is ShopSuccessAddInformationState){
          showToast(text: 'تم اضافة البيانات', state: ToastStates.SUCCESS);
          /*ShopCubit.get(context).getTodayOrder();*/
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: AlertDialog(
            content: Container(
              height: 400,
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Text(
                      'يمكنك ادخال البيانات',
                      style: TextStyle(fontSize: 22),
                    ),
                    SizedBox(height: 40),
                    TextFormField(
                      controller: nameController,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'يجب ادخال الاسم';
                        }
                      },
                      decoration: InputDecoration(
                        hintText: 'ادخل الاسم',
                      ),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'يجب ادخال رقم الهاتف';
                        }
                      },
                      decoration: InputDecoration(
                        hintText: 'ادخل رقم الهاتف',
                      ),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: addressController,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'يجب ادخال العنوان';
                        }
                      },
                      decoration: InputDecoration(
                        hintText: 'ادخل العنوان',
                      ),
                    ),
                    SizedBox(height: 40),
                    defaultButton(
                      decoration: BoxDecoration(
                          color: defaultColor,
                          borderRadius: BorderRadius.circular(30)),
                      function: () {
                        if (formKey.currentState!.validate()) {
                          ShopCubit.get(context).postAddInformation(id: order?.id,
                              name: nameController.text.toString(),
                              mobile: phoneController.text.toString(),
                              address: addressController.text.toString());
                        }
                      },
                      text: 'حفظ البيانات',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
