import 'package:flutter/material.dart';
import 'package:tik_laen_taswaq2/layout/cubit/cubit.dart';
import 'package:tik_laen_taswaq2/models/today_orders.dart';
import 'package:tik_laen_taswaq2/modules/home_screen/home_screen.dart';
import 'package:tik_laen_taswaq2/shared/components/components.dart';
import 'package:tik_laen_taswaq2/shared/components/constants.dart';
import 'package:tik_laen_taswaq2/shared/styles/color.dart';

import '../billing/bill_screen.dart';

class AlertDialogHome extends StatefulWidget {
  Order? order;
  int? index;

  AlertDialogHome({this.order ,this.index});

  @override
  State<AlertDialogHome> createState() => _AlertDialogHomeState();
}

class _AlertDialogHomeState extends State<AlertDialogHome> {

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        height: 400,
        child: Column(
          children: [
            Text(
              'لديك طلب جديد',
              style: TextStyle(fontSize: 25),
            ),
            SizedBox(height: 10),
            Text(
              'اضغط موافقة وتوجه لاستلام طلبك',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 10),
            Text(
                  //textOrder!,
              widget.order?.fromId?.name ?? '-',
              style: TextStyle(fontSize: 22, color: defaultColor),
            ),
            SizedBox(height: 10),
            Text(
              //address!,
              widget.order?.fromAddress?.address ?? '-',
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            defaultButton(
              width: 270,
              decoration: BoxDecoration(
                  color: defaultColor, borderRadius: BorderRadius.circular(30)),
              function: () {
               // assetsAudioPlayer.stop();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>HomeScreen()
                        // BillScreen(
                        //   order: widget.order,
                        //   index: widget.index,
                        // )
                    ));
              },
              text: 'موافق',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
              ),
            ),SizedBox(height: 20),
            defaultButton(
              width: 270,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(30),),
              function: () {
                //assetsAudioPlayer.stop();
                Navigator.pop(context);
              },
              text: 'رفض',
              style: TextStyle(
                color: defaultColor,
                fontSize: 22,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
