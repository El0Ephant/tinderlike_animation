import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//import 'package:tinderlike/swipe_widget.dart';
import 'package:tinderlike/cubit/button_cubit.dart';
import 'package:tinderlike/theme.dart';
import 'package:tinderlike/swipe/swipe_widget.dart';
import 'package:tinderlike/swipe/swipe_buttons.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late Animation<double> glow; //animation variable for circle 1
  late AnimationController glowController;
  Color glowColor = Colors.black;

  @override
  void initState() {
    glowController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));

    glow = Tween<double>(begin: 0, end: 5).animate(glowController);

    glow.addListener(() {
      setState(() {});
    });

    super.initState();
  }

  Future<void> animateGlow(Color color) async {
    glowColor = color;
    await glowController.forward();
    glowController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ButtonCubit(),
      child: BlocListener<ButtonCubit, ButtonState>(
        listener: (context, state) async {
          if (state is LeftSwipe) {
            await animateGlow(dislikeColor);
          }
          else if (state is RightSwipe) {
            await animateGlow(likeColor);
          }
          else if (state is UpSwipe) {
            await animateGlow(superlikeColor);
          }
        },
        child: Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          appBar: AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            title: const Text("Animation"),
          ),
          body: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  border: Border.all(color: glowColor, width: glow.value),
                ),
              ),
              const SwipeButtons(),
              const SwipeWidget(images: [
                "assets/person/person1.jpg",
                "assets/person/person2.jpg",
                "assets/person/person3.jpg",
                "assets/person/person4.jpg"
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
