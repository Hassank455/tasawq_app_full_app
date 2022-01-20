import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tik_laen_taswaq2/layout/bottom_home_screen.dart';
import 'package:tik_laen_taswaq2/layout/cubit/cubit.dart';
import 'package:tik_laen_taswaq2/models/today_orders.dart';
import 'package:tik_laen_taswaq2/modules/billing/bill_screen.dart';
import 'package:tik_laen_taswaq2/modules/billing/maps_billing.dart';
import 'package:tik_laen_taswaq2/modules/checkout.dart/myAddress_screen.dart';
import 'package:tik_laen_taswaq2/shared/styles/color.dart';
import 'package:url_launcher/url_launcher.dart';

Widget defualtTextFormField(
    {required TextEditingController controller,
    FormFieldValidator? validate,
    required TextInputType type,
    ValueChanged? onSubmit,
    bool isPassword = false,
    IconData? suffix,
    IconData? prefix,
    VoidCallback? suffixPressed,
    String? hintText,
    int? maxLines}) {
  return Container(
    margin: EdgeInsets.all(20),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(30)),
      color: Colors.grey[200],
    ),
    padding: EdgeInsets.only(right: 0, top: 5, bottom: 5),
    child: TextFormField(
      controller: controller,
      validator: validate,
      onFieldSubmitted: onSubmit,
      obscureText: isPassword,
      maxLines: maxLines,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: hintText,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: suffixPressed,
                icon: Icon(
                  suffix,
                  color: defaultColor,
                ),
              )
            : null,
      ),
    ),
  );
}

Widget defaultButton(
        {double width = double.infinity,
        double height = 55.0,
        Color background = defaultColor,
        bool isUpperCase = true,
        double radius = 3.0,
        required VoidCallback function,
        required String text,
        TextStyle? style,
        BoxDecoration? decoration}) =>
    Container(
      width: width,
      height: height,
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: style,
        ),
      ),
      decoration: decoration,
    );

Widget containerHomePage(
    {Widget? child,
    double? width,
    double? height,
    Color? color,
    Alignment? alignment,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    Decoration? decoration}) {
  return Container(
    width: width,
    height: height,
    color: color,
    alignment: alignment,
    padding: padding,
    margin: margin,
    child: child,
    decoration: decoration,
  );
}

Widget myDivider({double height = 1.5, double width = double.infinity}) =>
    Container(
      width: width,
      height: height,
      color: Colors.grey[300],
    );

Widget alertDialog2(context, controller) {
  return AlertDialog(
    content: Container(
      height: 250,
      child: Column(
        children: [
          Text(
            'رصيد الافتتاحية',
            style: TextStyle(fontSize: 25),
          ),
          SizedBox(height: 10),
          Text(
            'ادخل المبلغ المتوفر معك لبدء العمل',
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(height: 10),
          TextFormField(
            controller: controller,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: Colors.grey),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
          SizedBox(height: 20),
          defaultButton(
            width: 270,
            decoration: BoxDecoration(
                color: defaultColor, borderRadius: BorderRadius.circular(30)),
            function: () {
              if (controller.text.isNotEmpty) {
                ShopCubit.get(context).postStartWork();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BottomHomeScreen(),
                    ),
                    (route) => false);
                if (ShopCubit.get(context).startBalance?.msg != null) {
                  ShopCubit.get(context)
                      .postStartBalance(controller.text.toString());

                  print('123456 ${ShopCubit.get(context).startBalance?.msg}');

                  showToast(
                      text: '${ShopCubit.get(context).startBalance?.msg}',
                      state: ToastStates.SUCCESS);
                } else {
                  showToast(text: 'تسجيل بدء العمل', state: ToastStates.ERROR);
                }
              } else {
                showToast(text: 'ادخل رصيد افتتاحي', state: ToastStates.ERROR);
              }
            },
            text: 'موافق',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
            ),
          )
        ],
      ),
    ),
  );
}

Widget containerBillScreen(
    {context,
    String? name,
    String? address,
    String? mobile,
    String? latudide,
    String? longtuide,
    int? id}) {
  return Container(
    width: double.infinity,
    margin: EdgeInsets.all(20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name ?? '-',
              style: TextStyle(
                color: defaultColor,
                fontSize: 20,
              ),
            ),
            Container(
              width: 220,
              child: Text(
                address ?? '-',
                style: TextStyle(fontSize: 16),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        Row(
          children: [
            (latudide != null && longtuide != null)
                ? Padding(
              padding: const EdgeInsets.all(5.0),
              child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MapsBilling(
                              latudide: latudide,
                              longtuide: longtuide,
                              name: name ?? '-',
                              address: address ?? '-',
                            )));
                  },
                  child: Image.asset("assets/images/Group-map.png")),
            )
                :Container(),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: GestureDetector(
                  onTap: () async{
                    if (mobile != null && mobile != '') {
                      // _makePhoneCall('tel:$mobile');
                      await launch('tel:$mobile');
                    } else {
                      showToast(
                          text: 'لا يوجد رقم هاتف', state: ToastStates.ERROR);
                    }
                  },
                  child: Image.asset("assets/images/Group-phone.png")),
            ),
          ],
        ),
      ],
    ),
  );
}

Future<void> _makePhoneCall(String url) async {
  //if (await canLaunch(url)) {
    await launch(url);
 // } else {
    throw "could not launch $url";

  //}
}

Widget RowTodayOrder(
    {String? text1,
    String? numberText,
    String? nisText,
    Color color = Colors.grey,
    Color color2 = Colors.black}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        text1!,
        style: TextStyle(fontSize: 18, color: Colors.black),
      ),
      Row(
        children: [
          Text(
            numberText!,
            style: TextStyle(fontSize: 18, color: color2),
          ),
          Text(
            nisText!,
            style: TextStyle(fontSize: 12, color: color),
          ),
        ],
      ),
    ],
  );
}

Widget RowTodayOrder2(
    {String? text1,
    dynamic? numberText,
    String? nisText,
    Color color = Colors.grey,
    Color color2 = Colors.black}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Row(
        children: [
          Text(
            nisText ?? '0',
            style: TextStyle(fontSize: 12, color: color),
          ),
          Text(
            '${numberText ?? 0}',
            style: TextStyle(fontSize: 18, color: color2),
          ),
        ],
      ),
      Text(
        text1!,
        style: TextStyle(fontSize: 18, color: Colors.black),
      ),
    ],
  );
}

void navigateAndFinish(
  context,
  widget,
) =>
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      (route) {
        return false;
      },
    );

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

void showToast({
  required String text,
  required ToastStates state,
}) =>
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0,
    );

// enum
enum ToastStates { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastStates state) {
  Color color;

  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }

  return color;
}
