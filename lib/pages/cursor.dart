import 'package:flutter/material.dart';
import 'package:withings_health_mate/pages/weight_target_page.dart';
class Cursor extends StatelessWidget {
  final double scale;
  final String kg;
  Cursor({this.scale,this.kg});
  @override
  Widget build(BuildContext context) {

    return Positioned.fill(


      child: Center(
        child: Transform.scale(
          scale:scale,
          child: Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(50),
            border: Border.all(width: 2,color: Colors.white,)
            ),
            child: Center(
              child:  Text(
                kg,
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
            ),

          ),
        ),
      ),
    );
  }
}
