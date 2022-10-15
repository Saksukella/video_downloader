import 'package:flutter/material.dart';

class SCurveString {
  String curveName;
  Curve curve;

  SCurveString(this.curveName, this.curve);
}

final List<SCurveString> curveStrings = [
  SCurveString("BounceIn", Curves.bounceIn),
  SCurveString("BounceInOut", Curves.bounceInOut),
  SCurveString("BounceOut", Curves.bounceOut),
  SCurveString("EaseIn", Curves.easeIn),
  SCurveString("EaseInOut", Curves.easeInOut),
  SCurveString("EaseOut", Curves.easeOut),
  SCurveString("FastOutSlowIn", Curves.fastOutSlowIn),
  SCurveString("Linear", Curves.linear),
  SCurveString("SlowMiddle", Curves.slowMiddle),
  SCurveString("Decelerate", Curves.decelerate),
  SCurveString("ElasticIn", Curves.elasticIn),
  SCurveString("ElasticOut", Curves.elasticOut),
  SCurveString("EaseInBack", Curves.easeInBack),
  SCurveString("EaseInCirc", Curves.easeInCirc),
  SCurveString("EaseInCubic", Curves.easeInCubic),
  SCurveString("EaseInExpo", Curves.easeInExpo),
  SCurveString("EaseInQuad", Curves.easeInQuad),
  SCurveString("EaseInQuart", Curves.easeInQuart),
  SCurveString("EaseInQuint", Curves.easeInQuint),
  SCurveString("EaseInSine", Curves.easeInSine),
  SCurveString("EaseOutBack", Curves.easeOutBack),
  SCurveString("EaseOutCirc", Curves.easeOutCirc),
  SCurveString("EaseOutCubic", Curves.easeOutCubic),
  SCurveString("EaseOutExpo", Curves.easeOutExpo),
  SCurveString("EaseOutQuad", Curves.easeOutQuad),
  SCurveString("EaseOutQuart", Curves.easeOutQuart),
  SCurveString("EaseOutQuint", Curves.easeOutQuint),
  SCurveString("EaseOutSine", Curves.easeOutSine),
  SCurveString("ElasticInOut", Curves.elasticInOut),
];
