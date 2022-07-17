import 'dart:io';

import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';

import 'package:tinderlike/theme.dart';

//Старая версия, не используется в проекте
class SwipeCard extends StatefulWidget {
  const SwipeCard({Key? key,
    required this.currentImage,
    required this.nextImage,
    required this.swap})
      : super(key: key);

  final String currentImage;
  final String? nextImage;
  final Function() swap;

  @override
  State<SwipeCard> createState() => _SwipeCardState();
}

class _SwipeCardState extends State<SwipeCard> {

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 0.45;
    final width = MediaQuery.of(context).size.width * 0.8;
    return Draggable(
      child: SizedBox(
          height: height,
          width: width,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(widget.currentImage, fit: BoxFit.fitHeight),
          )),
      childWhenDragging: SizedBox(
          height: height,
          width: width,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: widget.nextImage != null ? Image.asset(widget.nextImage!, fit: BoxFit.fitHeight) : const Center(),
          )),
      feedback: SizedBox(
          height: height,
          width: width,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(widget.currentImage, fit: BoxFit.fitHeight),
          )),



      onDragEnd: (dragDetails) async {
        final minOffset = MediaQuery.of(context).size.width * 0.3;
        final offset = dragDetails.offset.dx;

        if (offset > minOffset) {
          Flushbar(
            message: 'Like!',
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 1),
          ).show(context);

          widget.swap();
          return;
        }

        if (offset < -minOffset) {
          Flushbar(
            message: 'Dislike',
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 1),
          ).show(context);

          widget.swap();
          return;
        }


      },
    );
  }
}