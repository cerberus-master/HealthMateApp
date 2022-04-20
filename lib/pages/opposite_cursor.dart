import 'package:flutter/material.dart';
class OppositeCursor extends StatelessWidget {
  final double top;
  OppositeCursor({this.top});
  @override
  Widget build(BuildContext context) {
    final Size size=MediaQuery.of(context).size;
    return Positioned(
      top: top,
      left: size.width/2-25/2,
      height: 25,
      width: 25,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,

            borderRadius: BorderRadius.circular(25/2),

        ),

      ),
    );
  }
}