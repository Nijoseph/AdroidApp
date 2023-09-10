import 'package:data_capture/util/constat.dart';
import 'package:flutter/material.dart';

class TabletBody extends StatelessWidget {
  final Widget? menuConstraint;
  final Widget? itemListConstraint;
  final Widget detailsConstraint;
  final bool? showTitle;
  TabletBody(
      {this.menuConstraint,
      this.itemListConstraint,
      required this.detailsConstraint, this.showTitle=true});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: showTitle!? appTitle:null,
      drawer: menuConstraint,
      body:itemListConstraint!=null? Row(
        children: [

          Expanded(
            flex: 7,
            child: itemListConstraint!,
          ),
          Expanded(
            flex: 13,
            child: detailsConstraint,
          ),
        ],
      ):detailsConstraint,
    );
  }
}
