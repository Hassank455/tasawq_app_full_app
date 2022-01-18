import 'package:flutter/material.dart';
import 'package:tik_laen_taswaq2/models/today_orders.dart';
import 'package:tik_laen_taswaq2/shared/components/constants.dart';

class NotificationDialog extends StatelessWidget {
  Order? order;

  NotificationDialog({this.order});

  @override
  Widget build(BuildContext context) {
    return Dialog(

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      backgroundColor: Colors.transparent,
      elevation: 1.0,
      child: Container(
        margin: EdgeInsets.all(5.0),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 30.0),
            Padding(
              padding: EdgeInsets.all(18.0),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(width: 20.0),
                      Expanded(
                        child: Container(
                          child: Text(
                            order!.id.toString(),
                            style: TextStyle(fontSize: 18.0),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 15.0),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(width: 20.0),
                      Expanded(
                        child: Container(
                          child: Text(
                            order?.toId?.name ?? '',
                            style: TextStyle(fontSize: 18.0),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 15.0),
                ],
              ),
            ),
            SizedBox(height: 20.0),
            Divider(
              height: 2.0,
              color: Colors.black,
              thickness: 2.0,
            ),
            SizedBox(height: 8.0),
            Padding(
              padding: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.red),
                    ),
                    color: Colors.white,
                    textColor: Colors.red,
                    padding: EdgeInsets.all(8.0),
                    onPressed: () {
                      //assetsAudioPlayer.stop();
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Cancel',
                      style: TextStyle(fontSize: 14.0),
                    ),
                  ),
                  SizedBox(width: 25.0),
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.green),
                    ),
                    color: Colors.green,
                    textColor: Colors.white,
                    onPressed: () {
                     // assetsAudioPlayer.stop();
                      //  checkAvailabilityOfRide(context);
                    },
                    child: Text(
                      'Accept'.toUpperCase(),
                      style: TextStyle(fontSize: 14.0),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.0),
          ],
        ),
      ),
    );
  }
}
