import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tik_laen_taswaq2/layout/cubit/cubit.dart';
import 'package:tik_laen_taswaq2/layout/cubit/states.dart';
import 'package:tik_laen_taswaq2/models/today_orders.dart';
import 'package:tik_laen_taswaq2/shared/components/components.dart';
import 'package:tik_laen_taswaq2/shared/styles/color.dart';

class MyAddressScreen extends StatefulWidget {
  //Order? order;
  int? id;
  MyAddressScreen({/*this.order,*/this.id});

  @override
  _MyAddressScreenState createState() => _MyAddressScreenState();
}

class _MyAddressScreenState extends State<MyAddressScreen> {
  var myMarkers = HashSet<Marker>();
  late Position currentPosition;
  late GoogleMapController newGoogleMapController;
  Completer<GoogleMapController> _controllerGoogleMap = Completer();
  Position? position;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(listener: (context, state) {
      if (state is ShopSuccessSaveAddressState) {
        print('${ShopCubit.get(context).saveAddress!.msg ?? ''}');
        showToast(
            text: ShopCubit.get(context).saveAddress!.msg!,
            state: ToastStates.SUCCESS);
      } else {
        // showToast(text: ShopCubit.get(context).saveAddress!.msg!, state: ToastStates.ERROR);
      }
    }, builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Address'),
          backgroundColor: defaultColor,
        ),
        body: Column(
          children: [
            Container(
              height: 650,
              child: GoogleMap(
                //padding: EdgeInsets.only(bottom: bottomPaddingOfMap),
                mapType: MapType.normal,
                myLocationButtonEnabled: true,
                myLocationEnabled: true,
                zoomGesturesEnabled: true,
                zoomControlsEnabled: true,
                compassEnabled: true,
                initialCameraPosition: _kGooglePlex,
                onMapCreated: (GoogleMapController controller) {
                  _controllerGoogleMap.complete(controller);
                  newGoogleMapController = controller;
                  locatePosition();
                },
              ),
            ),
            Spacer(),
            defaultButton(
              width: 330,
              decoration: BoxDecoration(
                  color: defaultColor, borderRadius: BorderRadius.circular(30)),
              function: () {
                ShopCubit.get(context).postSaveAddress(
                    widget.id!, position!.latitude, position!.longitude);
                print('////////save Address');
                print(
                    '${widget.id} ${position!.latitude} ${position!.longitude}');
              },
              text: 'حفظ البيانات',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
              ),
            ),
          ],
        ),
      );
    });
  }

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  void locatePosition() async {
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    currentPosition = position!;

    LatLng latLngPosition = LatLng(position!.latitude, position!.longitude);

    CameraPosition cameraPosition =
        new CameraPosition(target: latLngPosition, zoom: 14);
    newGoogleMapController
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }
}
