import 'package:data_capture/util/constat.dart';
import 'package:flutter/material.dart';


class DesktopBody extends StatelessWidget {
  final Widget? menuConstraint;
  final Widget itemListConstraint;
  final Widget detailsConstraint;
  final bool? showTitle;

  DesktopBody(
      {this.menuConstraint,
      required this.itemListConstraint,
      required this.detailsConstraint, this.showTitle=true});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: showTitle!? appTitle:null,
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth >1340 ) {
            return Row(
              children: [
                if(menuConstraint!=null)
                  Expanded(
                    flex: 2 ,
                    child: menuConstraint!,
                  ),
                Expanded(
                  flex: 3 ,
                  child: itemListConstraint,
                ),
                Expanded(
                  flex: 8,
                  child: detailsConstraint,
                ),
              ],
            );
          }else {
            return Row(
              children: [
                if(menuConstraint!=null)
                  Expanded(
                    flex: 4 ,
                    child: menuConstraint!,
                  ),
                Expanded(
                  flex: 5 ,
                  child: itemListConstraint,
                ),
                Expanded(
                  flex: 10,
                  child: detailsConstraint,
                ),
              ],
            );
          }
        },
      ),
    );

  }
}
