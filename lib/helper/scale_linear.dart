import 'package:flutter/material.dart';
import 'package:interpolate/interpolate.dart';

class ScaleLinear {
  List<double> _x;
  List<double> _y;

  ScaleLinear({
    List<double> inputRange,
    List<double> outputRange,
  }) {
    _x = inputRange.map((e) => e.toDouble()).toList();
    _y = outputRange.map((e) => e.toDouble()).toList();


    assert(_x.length == _y.length,
        "interpolate: the length of inputRange must be equal to the length ot the outputRange");
    assert(_x.length == 2 && _y.length ==2,
        "interpolate: the range should have more than two data points");
  }

  double eval(double val) {
    Interpolate ipDomain = Interpolate(
        inputRange: _x,
        outputRange:_y,
        extrapolate: Extrapolate.clamp);
    // Animatable<double>  tweenRangeLinear = Tween<double>(begin:_y[0] , end: _y[1])
    //     .chain(CurveTween(curve: Curves.linear));
    double domain = ipDomain.eval(val);
    // return tweenRangeLinear.transform(domain);
    return domain;
  }

  double invert(double val) {
    Interpolate ipDomain = Interpolate(
        inputRange: _x,
        outputRange: _y,
        extrapolate: Extrapolate.clamp);

    // Animatable<double>  tweenRangeLinear = Tween<double>(begin:_x[1] , end: _x[0])
    //     .chain(CurveTween(curve: Curves.linear));
    // double domain = ipDomain.eval(val);
    // return tweenRangeLinear.transform(domain);
    double domain = ipDomain.eval(val);
    return _y[1]-domain;
  }
}
