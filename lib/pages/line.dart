import 'package:flutter/material.dart';
import 'package:interpolate/interpolate.dart';
class Line extends StatelessWidget {
  final Interpolate ipTranslateY;
  final Interpolate ipTranslateY2;
  final double scrollPosition;
  Line({this.ipTranslateY,this.ipTranslateY2,this.scrollPosition});
  @override
  Widget build(BuildContext context) {
    double topLine = 0;
    double bottomLine = 0;
    if (ipTranslateY != null && ipTranslateY2 != null) {
      if (ipTranslateY.eval(scrollPosition) <=
          ipTranslateY2.eval(scrollPosition)) {
        topLine = ipTranslateY.eval(scrollPosition);
        bottomLine = ipTranslateY2.eval(scrollPosition);
      } else {
        topLine = ipTranslateY2.eval(scrollPosition);
        bottomLine = ipTranslateY.eval(scrollPosition);
      }
    }
    return Positioned(
        width: MediaQuery.of(context).size.width,
        top: topLine,
        height: bottomLine-topLine,
        child: Column(
          children: [
            Expanded(
              child: Container(
                width: 1,
                color: Colors.white,
              ),
            ),
          ],
        )

    );
  }
}
