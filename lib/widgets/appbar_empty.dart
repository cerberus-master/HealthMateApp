import 'package:flutter/material.dart';
class AppbarEmpty extends StatelessWidget {
  AppbarEmpty({this.child,this.backgroundColor});
  final Widget child;
  final Color backgroundColor;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 0,
      ),
      body: Material(
        color: Colors.transparent,
        child: Container(
          color: backgroundColor,
          child: child,
        ),
      ),
    );
  }
}
