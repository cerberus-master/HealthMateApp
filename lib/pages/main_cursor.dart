import 'package:flutter/material.dart';

import 'weight_target_page.dart';

class MainCursor extends StatelessWidget {
  final double top;
  final String kg;
  final Animation<double> animation;

  MainCursor({this.top, this.kg,this.animation});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Positioned(
      // top: size.height/2-SIZE_MAIN_CURSOR/2,
      top: top,
      left: size.width / 2 - SIZE_MAIN_CURSOR / 2,

      child: AnimatedBuilder(
        animation:animation ,
        child: Container(
          height: SIZE_MAIN_CURSOR,
          width: SIZE_MAIN_CURSOR,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(50),
          ),
          child: Center(
            child: Text(
              kg,
              style: TextStyle(fontSize: 30, color: backgroundColor),
            ),
          ),
        ),
        builder: (BuildContext context, Widget child){
          return Transform.scale(scale: animation.value,child: child,);
        },
      ),
    );
  }
}
