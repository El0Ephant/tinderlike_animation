import 'package:flutter/material.dart';

import 'package:tinderlike/swipe/small/circle_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tinderlike/cubit/button_cubit.dart';

class SwipeButtons extends StatelessWidget {
  const SwipeButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Column(
      children: [
        SizedBox(
          height: height * 0.3 - AppBar().preferredSize.height,
          width: width,
        ),
        ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              height: height * 0.52,
              width: width * 0.8,
              color: Colors.white,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleButton(color: Colors.red, onTap: (){BlocProvider.of<ButtonCubit>(context).leftSwipe();},),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleButton(color: Colors.green, onTap: (){BlocProvider.of<ButtonCubit>(context).rightSwipe();},),
                    ),
                  ],
                ),
              ),
            )),
      ],
    );
  }
}
