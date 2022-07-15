import 'dart:io';

import 'package:flutter/material.dart';

import 'package:tinderlike/swipe/swipe_card.dart';
import 'package:tinderlike/swipe/person_card.dart';

class SwipeWidget extends StatefulWidget {
  const SwipeWidget({Key? key, required this.images}) : super(key: key);

  final List<String> images;

  @override
  State<SwipeWidget> createState() => _SwipeWidgetState();
}

class _SwipeWidgetState extends State<SwipeWidget> {
  late int index;

  @override
  void initState() {
    index = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        index + 1 < widget.images.length
            ? Center(child: PersonCard(image: widget.images[index+1]))
            : const Center(),
        index < widget.images.length
            ? SwipeCard(image: widget.images[index], onSwap:  _update)
            : const Center(),

      ],
    );
  }

  void _update() {
    setState(() {
      index++;
    });
  }
}
