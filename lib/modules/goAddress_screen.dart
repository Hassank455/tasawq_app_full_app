import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tik_laen_taswaq2/layout/cubit/cubit.dart';
import 'package:tik_laen_taswaq2/layout/cubit/states.dart';
import 'package:tik_laen_taswaq2/models/balance.dart';
import 'package:tik_laen_taswaq2/models/direction.dart';
import 'package:tik_laen_taswaq2/models/today_orders.dart';
import 'package:tik_laen_taswaq2/modules/home_screen/home_screen.dart';
import 'package:tik_laen_taswaq2/shared/components/components.dart';
import 'package:tik_laen_taswaq2/shared/network/Notification/pushNotificationService.dart';
import 'package:tik_laen_taswaq2/shared/network/remote/direction_repository.dart';
import 'package:tik_laen_taswaq2/shared/styles/color.dart';

import 'RefreshWidgetGoAddress.dart';
import 'checkout.dart/alert_dialog_request_price.dart';
import 'checkout.dart/checkbox1_screen.dart';
import 'checkout.dart/checkbox2_screen.dart';
import 'package:tik_laen_taswaq2/shared/cubit/states.dart';

class GoAddressScreen extends StatefulWidget {
  Order? order;
  int? index;
  GoAddressScreen({this.order, this.index});

  @override
  _GoAddressScreenState createState() => _GoAddressScreenState();
}

class _GoAddressScreenState extends State<GoAddressScreen> {
  var myMarkers = HashSet<Marker>();
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  Order order = Order();
  List<Polyline> myPolyLine = [];
  Directions? _info;
  Timer? timer;
  Position? currentPosition;

  Future<void> getMyLocation() async {
    Position position1 = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    currentPosition = position1;
    print(
        "This is your current Position ::${currentPosition?.longitude} ${currentPosition?.longitude}");
  }

  createPolyLine(double? fromlatudide1, double? fromlongtuide1,
      double? tolatudide1, double? tolongtuid1e) async {
    if (fromlatudide1 != null &&
        fromlongtuide1 != null &&
        tolatudide1 != null &&
        tolongtuid1e != null) {
      /*myPolyLine.add(
        Polyline(
          polylineId: PolylineId('1'),
          color: Colors.blue,
          width: 4,
          points: [
            */ /*     LatLng(31.51185984005637, 34.43524073950763),
          LatLng(31.514612948959932, 34.43978976578175),*/ /*
            LatLng(fromlatudide1, fromlongtuide1),
            LatLng(tolatudide1, tolongtuid1e),
          ],
        ),
      )*/
      final directions = await DirectionsRepository().getDirections(
          origin: LatLng(fromlatudide1, fromlongtuide1),
          destination: LatLng(tolatudide1, tolongtuid1e));
      setState(() => _info = directions);
    }
  }

  @override
  Widget build(BuildContext context) {
    double? fromlatudide =
    double.parse(widget.order!.fromAddress?.lat ?? '31.515106853596972');
    double? fromlongtuide =
    double.parse(widget.order!.fromAddress?.lng ?? '34.4370002686346');
    double? tolatudide =
    double.parse(widget.order!.toAddress?.lat ?? '31.515106853596972');
    double? tolongtuide =
    double.parse(widget.order!.toAddress?.lng ?? '34.4370002686346');

    /* print('##################');
    print('$fromlatudide + $fromlongtuide + $tolatudide + $tolongtuide');
    print(
        '${widget.order!.fromAddress?.name} + ${widget.order!.fromAddress?.address}');*/

    // createPolyLine(31.51185984005637, 34.43524073950763,31.514612948959932, 34.43978976578175);
    createPolyLine(fromlatudide, fromlongtuide, tolatudide, tolongtuide);

    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is ShopSuccessTrackState) {
          //showToast(text: 'تم التتبع', state: ToastStates.SUCCESS);
        }
      },
      builder: (context, state) {
        ShopCubit.get(context).todayOrders!;
        ShopCubit.get(context).balance!;
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            body: RefreshWidgetGoAddress(
              onRefresh: () async {
                widget.order!;
                widget.order!.status!;
                ShopCubit.get(context).getTodayOrder();
                ShopCubit.get(context).getBalance();
                ShopCubit.get(context).deliverOrder!;
              },
              child: Column(
                children: [
                  Container(
                    height: 70,
                    margin: EdgeInsets.only(top: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(left: 100),
                          child: Text('التوجه للعنوان',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Icon(Icons.arrow_forward_ios_outlined)),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 400,
                    child: GoogleMap(
                      mapType: MapType.normal,
                      myLocationButtonEnabled: true,
                      initialCameraPosition: CameraPosition(
                        target: LatLng(fromlatudide, fromlongtuide),
                        // target: LatLng(31.514612948959932, 34.43978976578175),
                        zoom: 15.4746,
                      ),
                      onMapCreated: (googleMapController) {
                        if (fromlatudide != null &&
                            fromlongtuide != null &&
                            tolatudide != null &&
                            tolongtuide != null) {
                          setState(() {
                            myMarkers.add(
                              Marker(
                                markerId: MarkerId('1'),
                                //position: LatLng(31.51185984005637, 34.43524073950763),
                                position: LatLng(fromlatudide, fromlongtuide),
                                infoWindow: InfoWindow(
                                  title: widget.order!.fromId?.name ?? '-',
                                  snippet:
                                  widget.order!.fromAddress!.address ?? '-',
                                ),
                              ),
                            );
                            myMarkers.add(
                              Marker(
                                markerId: MarkerId('2'),
                                // position: LatLng(31.514612948959932, 34.43978976578175),
                                position: LatLng(tolatudide, tolongtuide),
                                infoWindow: InfoWindow(
                                  title: widget.order?.toAddress?.name ?? '-',
                                  snippet:
                                  (ShopCubit.get(context).todayOrders?.order![widget.index!]
                                      .toAddress?.address ?? '-'
                                  ),
                                  // widget.order?.toAddress?.address ?? '-',
                                ),
                              ),
                            );
                          });
                        }
                      },
                      markers: myMarkers,
                      //polylines: myPolyLine.toSet(),
                      polylines: {
                        if (_info != null)
                          Polyline(
                            polylineId: const PolylineId('overview_polyline'),
                            color: Colors.red,
                            width: 5,
                            points: _info!.polylinePoints!
                                .map((e) => LatLng(e.latitude, e.longitude))
                                .toList(),
                          ),
                      },
                      myLocationEnabled: true,
                      zoomGesturesEnabled: true,
                      zoomControlsEnabled: true,
                      compassEnabled: true,
                    ),
                  ),
                  SizedBox(height: 20),
                  //  (widget.order!.status == 0)
                  (ShopCubit.get(context)
                      .todayOrders!.order![widget.index!]
                      .status) == 0 || (ShopCubit.get(context)
                      .todayOrders!.order![widget.index!]
                      .status) == 1
                      ? defaultButton(
                      function: () async {
                        show1();
                        await getMyLocation();
                        setState(() {
                          ShopCubit.get(context).postTrackUser(
                            id: widget.order?.id,
                            lat: currentPosition?.longitude.toString(),
                            lng: currentPosition?.latitude.toString(),
                          );
                        });
                        setState(() {
                          widget.order!.status!;
                          order.status!;
                        });
                        print(
                            '  تاكيد استلام المنتج ${currentPosition?.longitude} ${currentPosition?.latitude}');
                      },
                      width: 250,
                      text: 'تاكيد استلام المنتج',
                      style: TextStyle(color: Colors.white),
                      decoration: BoxDecoration(
                          color: defaultColor,
                          borderRadius: BorderRadius.circular(15)))
                  // : (widget.order?.price == null || widget.order?.price == '0' )
                      : ((ShopCubit.get(context)
                      .todayOrders!
                      .order![widget.index!]
                      .price) ==
                      null ||
                      (ShopCubit.get(context)
                          .todayOrders!
                          .order![widget.index!]
                          .price) ==
                          '0')
                      ? defaultButton(
                      function: () {
                        showDialog(
                          context: context,
                          barrierColor: Colors.black12,
                          builder: (context) {
                            return SingleChildScrollView(
                              child: AlertDialogRequestPrice(
                                  order: widget.order),
                            );
                          },
                        );
                        setState(() {
                          widget.order!;
                          widget.order!.status!;
                          widget.order?.price!;

                          ShopCubit.get(context).getTodayOrder();
                          ShopCubit.get(context).getBalance();
                        });
                        /*ShopCubit.get(context)
                                      .getRequestPrice(order!.id!);*/
                      },
                      width: 250,
                      text: 'طلب التسعير',
                      style: TextStyle(color: Colors.white),
                      decoration: BoxDecoration(
                          color: defaultColor,
                          borderRadius: BorderRadius.circular(15)))
                  //     (widget.order!.status == 2 || widget.order!.status != 1)

                      : (ShopCubit.get(context)
                      .todayOrders!.order![widget.index!]
                      .status) == 2
                      ? defaultButton(
                    function: () async {
                      show2();
                      await getMyLocation();
                      ShopCubit.get(context).postTrackUser(
                        id: (ShopCubit.get(context)
                            .todayOrders!.order![widget.index!].id),
                        lat: currentPosition?.longitude.toString(),
                        lng: currentPosition?.latitude.toString(),
                      );
                      setState(() {
                        widget.order!.status!;
                        widget.order!.id!;
                        widget.order!.paidPrice!;
                      });
                    },
                    width: 250,
                    text: 'تاكيد تسليم المنتج',
                    style: TextStyle(color: Colors.white),
                    decoration: BoxDecoration(
                        color: defaultColor,
                        borderRadius: BorderRadius.circular(15)),):Container(),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void show1() {
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        context: context,
        builder: (context) {
          return Checkbox1Screen(
            order: widget.order,
            index: widget.index,

          );
        });
  }

  void show2() {
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        context: context,
        builder: (context ) {
          return Checkbox2Screen(
            order: widget.order,
            index: widget.index,
          );
        });
  }
}