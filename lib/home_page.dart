import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//import 'package:tinderlike/swipe_widget.dart';
import 'package:tinderlike/cubit/button_cubit.dart';

import 'package:tinderlike/swipe/swipe_widget.dart';
import 'package:tinderlike/swipe/swipe_buttons.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text("Animation"),
      ),
      body: BlocProvider(
        create: (_) => ButtonCubit(),
        child: Stack(
          children: const [
            SwipeButtons(),
            SwipeWidget(images: [
              "assets/person/person1.jpg",
              "assets/person/person2.jpg",
              "assets/person/person3.jpg",
              "assets/person/person4.jpg"
            ]),
          ],
        ),
      ),
    );
  }
}
