import 'package:flutter/material.dart';

import 'package:tinderlike/swipe_card.dart';

//Старая версия, не используется в проекте
class SwipeWidget extends StatefulWidget {
  SwipeWidget({Key? key, required this.images}) : super(key: key);

  List<String> images;

  @override
  State<SwipeWidget> createState() => _SwipeWidgetState();


}

class _SwipeWidgetState extends State<SwipeWidget> {
  @override
  Widget build(BuildContext context) {
    if (widget.images.isNotEmpty) {
      return SwipeCard(
        currentImage: widget.images[widget.images.length - 1],
        nextImage: widget.images.length > 1 ? widget.images[widget.images
            .length - 2] : null,
        swap: _swap,
      );
    }
    return const Center();
  }

  void _swap() {
    setState(() {widget.images.removeLast();});
  }
}
