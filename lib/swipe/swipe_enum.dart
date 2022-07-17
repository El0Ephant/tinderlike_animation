import 'package:flutter/material.dart';

import 'package:tinderlike/theme.dart';

enum SwipeEnum {
  left,
  right,
  up,
  no

}

extension SwipeExtension on SwipeEnum {

  String get message {
    switch (this) {
      case SwipeEnum.left:
        return 'Dislike';
      case SwipeEnum.right:
        return 'Like';
      case SwipeEnum.up:
        return 'Superlike!';
      default:
        return "-";
    }
  }

  Color get color {
    switch (this) {
      case SwipeEnum.left:
        return dislikeColor;
      case SwipeEnum.right:
        return likeColor;
      case SwipeEnum.up:
        return superlikeColor;
      default:
        return Colors.black;
    }
  }

  Alignment get alignment {
    switch (this) {
      case SwipeEnum.left:
        return const Alignment(-9, 0);
      case SwipeEnum.right:
        return const Alignment(9, 0);
      case SwipeEnum.up:
        return const Alignment(0, -3);
      default:
        return Alignment.center;
    }

  }
}

SwipeEnum swipeInfo(double dragX, double dragY) {
  print(dragY);
  if (dragY > 0.5 && dragX.abs() < 0.3) {
    return SwipeEnum.up;
  }

  if(dragY < 0.4) {
    if (dragX > 0.5) {
      return SwipeEnum.right;
    }

    if (dragX < -0.5) {
      return SwipeEnum.left;
    }
  }
  return SwipeEnum.no;
}