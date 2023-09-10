import 'package:data_capture/util/constat.dart';
import 'package:flutter/material.dart';


class MobileBody extends StatelessWidget {
  final Widget? menuConstraint;
  final Widget screenConstraint;
  final bool? showTitle;
  MobileBody(
      {this.menuConstraint,
        required this.screenConstraint, this.showTitle=true,});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: showTitle!? appTitle:null,
      drawer: menuConstraint,
      body: screenConstraint,
    );
  }
}
