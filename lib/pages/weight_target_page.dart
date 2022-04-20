import 'package:flutter/material.dart';
import 'package:interpolate/interpolate.dart';
import 'package:withings_health_mate/helper/scale_linear.dart';
import 'package:withings_health_mate/pages/opposite_cursor.dart';
import 'package:withings_health_mate/pages/separator.dart';
import 'package:withings_health_mate/widgets/appbar_empty.dart';
import 'dart:math' as math;

import 'appbar_header.dart';
import 'cursor.dart';
import 'line.dart';
import 'main_cursor.dart';

const double ROW_HEIGHT = 100;
const Color backgroundColor = Color.fromRGBO(64, 154, 238, 1.0);
const double SIZE_MAIN_CURSOR = 100;

class WeightTargetPage extends StatefulWidget {
  @override
  _WeightTargetPageState createState() => _WeightTargetPageState();
}

class _WeightTargetPageState extends State<WeightTargetPage>
    with TickerProviderStateMixin {
  double weightBody = 84;
  double heightBody = 1.77;
  int from;
  int to;

  Map<int, String> separators = {
    18: "Underweight",
    19: "Healthy weight",
    24: "Healthy weight",
    25: "Overweight",
    29: "Overweight",
    30: "Obsese",
  };

  ScrollController _scrollController;
  double scrollPosition = 0;
  double middlePositionScroll;

  Interpolate ipTranslateY;
  Interpolate ipTranslateY2;
  Interpolate ipScale;
  Interpolate ipHeightLine;
  Interpolate ipBMIToPositionScroll;
  Interpolate ipPositionToBMI;

  // ScaleLinear _scaleLinear;

  String totalKg = "";
  String relativeKg = "";

  AnimationController _controllerHeader;
  Animation<double> topOffset;

  AnimationController _controllerMainCursor;
  Animation<double> _scaleMainCursor;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    int BMI = (weightBody / (heightBody * heightBody)).round();
    from = BMI - 10;
    to = BMI + 10;

    _scrollController = ScrollController();
    _scrollController.addListener(() {
      setState(() {
        scrollPosition = _scrollController.offset;
        if (ipBMIToPositionScroll != null && ipPositionToBMI != null) {
          update(scrollPosition);
        }
      });
    });
    initAnimationHeader();
    // Tween(begin: ,end: ).l
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final Size size = MediaQuery.of(context).size;
      final bottomPadding = MediaQuery.of(context).padding.bottom;
      final topPadding = MediaQuery.of(context).padding.top;
      // double endPositionScroll = 21 * ROW_HEIGHT - size.height;
      // middlePositionScroll = endPositionScroll / 2;
      // _scrollController.jumpTo(middlePositionScroll);

      initInterpolate(size, bottomPadding, topPadding);
      scrollToDefaultValue();
    });
  }

  void initInterpolate(Size size, double bottomPadding, double topPadding) {
    double heightScreen = size.height - bottomPadding - topPadding;
    List<double> inputRange = [0, 21 * ROW_HEIGHT - heightScreen];
    ipTranslateY = Interpolate(
        inputRange: inputRange,
        outputRange: [0, heightScreen - SIZE_MAIN_CURSOR],
        extrapolate: Extrapolate.clamp);
    ipTranslateY2 = Interpolate(
        inputRange: inputRange,
        outputRange: [heightScreen - 50, 0],
        extrapolate: Extrapolate.clamp);
    ipScale = Interpolate(
      inputRange: [inputRange[0], inputRange[1] / 2, inputRange[1]],
      outputRange: [0.5, 1, 0.5],
    );
    ipHeightLine = Interpolate(
        inputRange: [inputRange[0], inputRange[1] / 2, inputRange[1]],
        outputRange: [heightScreen - 150, 25, heightScreen - 100],
        extrapolate: Extrapolate.clamp);

    ipBMIToPositionScroll = Interpolate(
        inputRange: [from.toDouble(), to.toDouble()],
        outputRange: [21 * ROW_HEIGHT - heightScreen, 0],
        extrapolate: Extrapolate.clamp);
    ipPositionToBMI = Interpolate(
        inputRange: [0, 21 * ROW_HEIGHT - heightScreen],
        outputRange: [to.toDouble(), from.toDouble()],
        extrapolate: Extrapolate.clamp);
    // _scaleLinear = ScaleLinear(
    //     inputRange: [from.toDouble(), to.toDouble()], outputRange: [0, 21 * ROW_HEIGHT - heightScreen]);
  }

  void initAnimationHeader() {
    _controllerHeader =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    final Animation<double> curve =
        CurvedAnimation(parent: _controllerHeader, curve: Curves.ease);
    topOffset = Tween<double>(begin: 0, end: -300).animate(curve);

    _controllerMainCursor = AnimationController(
        vsync: this, duration: Duration(milliseconds: 2000));

    _scaleMainCursor =
        Tween<double>(begin: 1, end: 1.2).animate(CurvedAnimation(
            parent: _controllerMainCursor,
            curve: Interval(
              0.8,
              1,
              curve: Curves.elasticOut,
            )));
  }

  void scrollToDefaultValue() {
    double BMI = (weightBody / (heightBody * heightBody));

    double position = ipBMIToPositionScroll.eval(BMI);

    _scrollController.jumpTo(position);
  }

  void update(double value) {
    double BMI = ipPositionToBMI.eval(value);

    double kg = BMI * heightBody * heightBody;
    totalKg = ((kg * 2).round() / 2).toStringAsFixed(1);
    relativeKg = (((kg - weightBody) * 2).round() / 2).toStringAsFixed(1);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _scrollController?.dispose();
    _controllerHeader?.dispose();
    _controllerMainCursor?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            NotificationListener(
              onNotification: (t) {
                if (t is ScrollEndNotification) {
                  _controllerHeader?.reverse();
                  _controllerMainCursor?.reset();
                  _controllerMainCursor?.repeat();
                } else if (t is ScrollStartNotification) {
                  _controllerHeader?.reset();
                  _controllerHeader?.forward();

                  _controllerMainCursor?.reset();
                }
                return true;
              },
              child: ListView(
                controller: _scrollController,
                physics: ClampingScrollPhysics(),
                children: _buildListBMI().reversed.toList(),
              ),
            ),

            Positioned.fill(
                child: IgnorePointer(
              ignoring: true,
              child: Stack(
                children: [

                  Line(scrollPosition: scrollPosition,ipTranslateY: ipTranslateY,ipTranslateY2: ipTranslateY2,),
                  OppositeCursor(
                    top: ipTranslateY2 != null
                        ? ipTranslateY2.eval(scrollPosition)
                        : 0,
                  ),
                  Cursor(
                    scale: ipScale != null ? ipScale.eval(scrollPosition) : 0,
                    kg: relativeKg,
                  ),
                  MainCursor(
                    top: ipTranslateY != null
                        ? ipTranslateY.eval(scrollPosition)
                        : 0,
                    kg: totalKg,
                    animation: _scaleMainCursor,
                  ),
                ],
              ),
            )),
            topOffset!=null?AppbarHeader(animation: topOffset,):Container(),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildListBMI() {
    int range = to - from + 1;
    List<Widget> results = [];
    for (int i = 0; i < range; i++) {
      int BMI = from + i;
      String label = separators[BMI];
      bool opening = separators[BMI - 1] != null;
      results.add(Container(
        key: Key(i.toString()),
        // color: Colors.red,
        decoration: BoxDecoration(
            // border: Border.all(color: Colors.white,width: 1),
            color: backgroundColor),

        child: Column(
          children: [
            Container(
              height: ROW_HEIGHT,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      "BMI " + BMI.toString(),
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                  if (label != null)
                    Align(
                      alignment: opening == true
                          ? Alignment.bottomRight
                          : Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 15),
                        child: Text(label,
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.white.withOpacity(0.8))),
                      ),
                    ),
                ],
              ),
            ),
            if (opening == true && label != null) Separator()
          ],
        ),
      ));
    }
    return results;
  }
}
