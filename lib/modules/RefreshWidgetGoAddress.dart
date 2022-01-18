import 'dart:io';


import 'package:flutter/material.dart';
import 'package:tik_laen_taswaq2/shared/styles/color.dart';

class RefreshWidgetGoAddress extends StatefulWidget {
  final GlobalKey<RefreshIndicatorState>? keyRefreshGo;
  final Widget? child;
  final  RefreshCallback onRefresh;

  const RefreshWidgetGoAddress({
    Key? key,
    this.keyRefreshGo,
    required this.onRefresh,
    required this.child,
  }) : super(key: key);

  @override
  _RefreshWidgetGoAddressState createState() => _RefreshWidgetGoAddressState();
}

class _RefreshWidgetGoAddressState extends State<RefreshWidgetGoAddress> {
  @override
  Widget build(BuildContext context) => buildAndroidList();

  Widget buildAndroidList() => RefreshIndicator(
    color: defaultColor,
    key: widget.keyRefreshGo,
    onRefresh: widget.onRefresh,
    child: widget.child!,
  );

/* Widget buildIOSList() => CustomScrollView(
    physics: BouncingScrollPhysics(),
    slivers: [
      CupertinoSliverRefreshControl(onRefresh: widget.onRefresh),
      SliverToBoxAdapter(child: widget.child),
    ],
  );*/
}