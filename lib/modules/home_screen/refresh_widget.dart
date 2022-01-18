import 'dart:io';


import 'package:flutter/material.dart';
import 'package:tik_laen_taswaq2/shared/styles/color.dart';

class RefreshWidget extends StatefulWidget {
  final GlobalKey<RefreshIndicatorState>? keyRefresh;
  final Widget? child;
  final  RefreshCallback onRefresh;

  const RefreshWidget({
    Key? key,
    this.keyRefresh,
    required this.onRefresh,
    required this.child,
  }) : super(key: key);

  @override
  _RefreshWidgetState createState() => _RefreshWidgetState();
}

class _RefreshWidgetState extends State<RefreshWidget> {
  @override
  Widget build(BuildContext context) => buildAndroidList();

  Widget buildAndroidList() => RefreshIndicator(
    color: defaultColor,
    key: widget.keyRefresh,
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