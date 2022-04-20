import 'package:flutter/material.dart';

class Separator extends StatelessWidget {
  Separator({this.dash = 50});

  final int dash;

  @override
  Widget build(BuildContext context) {
    double width = (MediaQuery.of(context).size.width / (dash * 2));

    return Row(
      children: [
        for (int i = 0; i < dash; i++)
          Container(
            width: width,
            height: 1,
            color: Colors.white,
            margin: EdgeInsets.only(right: width),
          )
      ],
    );
  }
}
