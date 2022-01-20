import 'package:flutter/material.dart';
import 'package:tik_laen_taswaq2/layout/cubit/cubit.dart';
import 'package:tik_laen_taswaq2/models/new_order.dart';
import 'package:tik_laen_taswaq2/models/today_orders.dart';
import 'package:tik_laen_taswaq2/modules/home_screen/home_screen.dart';
import 'package:tik_laen_taswaq2/shared/components/components.dart';
import 'package:tik_laen_taswaq2/shared/components/constants.dart';
import 'package:tik_laen_taswaq2/shared/styles/color.dart';

import '../billing/bill_screen.dart';

class AlertDialogHome extends StatefulWidget {
  Order4? order;
  int? index;

  AlertDialogHome({this.order ,this.index});

  @override
  State<AlertDialogHome> createState() => _AlertDialogHomeState();
}

class _AlertDialogHomeState extends State<AlertDialogHome> {

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0))),
      content: Container(
        height: 200,
        child: Column(
          children: [
            Text(
              'لديك طلب جديد',
              style: TextStyle(fontSize: 25),
            ),
            SizedBox(height: 10),
            Text(
              'اضغط تم وتوجه لاستلام طلبك',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 10),
            defaultButton(
              width: 270,
              decoration: BoxDecoration(
                color: Colors.red.shade50, borderRadius: BorderRadius.circular(30),),
              function: () {
               assetsAudioPlayer.stop();
                Navigator.pop(context);
              },
              text: 'تم',
              style: TextStyle(
                color: defaultColor,
                fontSize: 25,
              ),
            ),
          ],
        ),
      ),
    );
  }
}