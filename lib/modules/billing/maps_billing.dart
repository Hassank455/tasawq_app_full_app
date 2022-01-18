import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tik_laen_taswaq2/shared/styles/color.dart';

class MapsBilling extends StatefulWidget {
  String? latudide;
  String? longtuide;
  String? name;
  String? address;

  MapsBilling({this.latudide, this.longtuide, this.name, this.address});

  @override
  _MapsBillingState createState() => _MapsBillingState();
}

class _MapsBillingState extends State<MapsBilling> {
  double? lat, lng;
  String? name1, address1;
  var myMarkers = HashSet<Marker>();

  @override
  Widget build(BuildContext context) {
    lat = double.parse(widget.latudide!);
    lng = double.parse(widget.longtuide!);
   /* if(lat == null && lng == null){
      lat = 31.515106853596972;
      lng = 34.4370002686346;
    }*/

    name1 = widget.name;
    address1 = widget.address;
    print('########################');
    print('$lat + $lng + $name1 + $address1');
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'اظهار الموقع',
          style: TextStyle(fontSize: 22),
        ),
        centerTitle: true,
        backgroundColor: defaultColor,
        toolbarHeight: 80,
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        myLocationButtonEnabled: true,
        initialCameraPosition: CameraPosition(
          //target: LatLng(lat ?? 31.515106853596972, lng ?? 34.4370002686346),
          target: LatLng(lat!, lng!),
          //target: LatLng(31.515106853596972, 34.4370002686346),
          zoom: 15.4746,
        ),
        onMapCreated: (googleMapController) {
          /*if (lat == 31.515106853596972 && lng == 34.4370002686346) {

          }else{*/
            setState(() {
              myMarkers.add(
                Marker(
                  markerId: MarkerId('1'),
                  position: LatLng(lat!, lng!),
                  infoWindow: InfoWindow(
                    title: name1 ?? '',
                    snippet: address1 ?? '',
                  ),
                ),
              );
            });
        //  }
        },
        markers: myMarkers,
        zoomGesturesEnabled: true,
        zoomControlsEnabled: true,
        myLocationEnabled: true,
      ),
    );
  }
}
