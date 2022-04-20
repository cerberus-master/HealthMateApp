import 'package:flutter/material.dart';
import 'package:withings_health_mate/pages/weight_target_page.dart';

class AppbarHeader extends StatelessWidget {

  final Animation<double> animation;
  AppbarHeader({this.animation});
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,

      width: MediaQuery.of(context).size.width,
      child: AnimatedBuilder(
        animation: animation,
        child: Container(
          decoration: BoxDecoration(
              color: backgroundColor,
              border: Border(bottom: BorderSide(width: 1, color: Colors.white))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                child: Text(
                  "Cancel",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
              Text(
                "TARGET WEIGHT",
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                child: Text(
                  "Next",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
        builder: (BuildContext context, Widget child){
          return Transform.translate(
            offset: Offset(0,animation!=null?animation.value:0),
            child: child,
          );
        },
      ),
    );
  }
}
