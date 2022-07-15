import 'package:flutter/material.dart';
enum SwipeEnum {
  left,
  right,
  no

}

extension SwipeExtension on SwipeEnum {

  String get message {
    switch (this) {
      case SwipeEnum.left:
        return 'Dislike';
      case SwipeEnum.right:
        return 'Like';
      default:
        return "-";
    }
  }

  Color get color {
    switch (this) {
      case SwipeEnum.left:
        return Colors.red;
      case SwipeEnum.right:
        return Colors.green;
      default:
        return Colors.black;
    }
  }
}

SwipeEnum swipeInfo(double drag) {
  if (drag > 0.5) {
    return SwipeEnum.right;
  }

  if (drag < -0.5) {
    return SwipeEnum.left;
  }

  return SwipeEnum.no;
}