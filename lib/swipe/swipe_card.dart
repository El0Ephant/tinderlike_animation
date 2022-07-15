import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tinderlike/cubit/button_cubit.dart';

import 'package:tinderlike/swipe/swipe_enum.dart';
import 'package:tinderlike/swipe/person_card.dart';

/// Украдено, но адаптировано
class SwipeCard extends StatefulWidget {
  const SwipeCard({Key? key, required this.image, required this.onSwap})
      : super(key: key);

  final String image;
  final Function onSwap;

  @override
  State<SwipeCard> createState() => _SwipeCardState();
}

class _SwipeCardState extends State<SwipeCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  /// The alignment of the card as it is dragged or being animated.
  ///
  /// While the card is being dragged, this value is set to the values computed
  /// in the GestureDetector onPanUpdate callback. If the animation is running,
  /// this value is set to the value of the [_animation].
  Alignment _dragAlignment = Alignment.center;

  late Animation<Alignment> _animation;

  /// Calculates and runs a [SpringSimulation].
  Future<SwipeEnum> _runAnimation(Offset pixelsPerSecond, Size size, [SwipeEnum? type]) async {
    final swipeType = type ?? swipeInfo(_dragAlignment.x);

    late final Alignment resultAlignment;

    switch (swipeType.index) {
      case 0:
        resultAlignment = const Alignment(-9, 0);
        break;
      case 1:
        resultAlignment = const Alignment(9, 0);
        break;
      case 2:
        resultAlignment = Alignment.center;
        break;
    }

    _animation = _controller.drive(
      AlignmentTween(
        begin: _dragAlignment,
        end: resultAlignment,
      ),
    );
    // Calculate the velocity relative to the unit interval, [0,1],
    // used by the animation controller.
    final unitsPerSecondX = (pixelsPerSecond.dx / size.width);
    final unitsPerSecondY = (pixelsPerSecond.dy / size.height);
    final unitsPerSecond = Offset(unitsPerSecondX, unitsPerSecondY);
    final unitVelocity = unitsPerSecond.distance;

    const spring = SpringDescription(
      mass: 50,
      stiffness: 10,
      damping: 1,
    );

    final simulation = SpringSimulation(spring, 0, 1, -unitVelocity);

    await _controller.animateWith(simulation);
    return swipeType;
  }


  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);

    _controller.addListener(() {
      setState(() {
        _dragAlignment = _animation.value;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void performSwipe(SwipeEnum swipeType, BuildContext context) {

    Flushbar(
      message: swipeType.message,
      backgroundColor: swipeType.color,
      duration: const Duration(seconds: 1),
    ).show(context);
    setState(() {
      _dragAlignment = Alignment.center;
    }
    );
    widget.onSwap();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery
        .of(context)
        .size;

    return BlocListener<ButtonCubit, ButtonState>(
      listener: (context, state) async {
        if (state is LeftSwipe) {
          await _runAnimation(
              const Offset(300,40), size, SwipeEnum.left);
          performSwipe(SwipeEnum.left, context);
        }
        if (state is RightSwipe) {
          await _runAnimation(
              const Offset(300,40), size, SwipeEnum.right);
          performSwipe(SwipeEnum.right, context);
        }
      },
      child: GestureDetector(
        onPanDown: (details) {
          _controller.stop();
        },
        onPanUpdate: (details) {
          setState(() {
            _dragAlignment += Alignment(
              details.delta.dx / (size.width / 2),
              details.delta.dy / (size.height / 2),
            );
          });
        },
        onPanEnd: (details) async {
          final swipeType = await _runAnimation(
              details.velocity.pixelsPerSecond, size);
          if (swipeType != SwipeEnum.no) {
            performSwipe(swipeType, context);
          }
        },
        child: Align(
          alignment: _dragAlignment,
          child: PersonCard(image: widget.image),
        ),
      ),
    );
  }
}
