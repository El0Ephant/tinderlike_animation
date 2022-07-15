import "package:flutter/material.dart";


class CircleButton extends StatelessWidget {
  CircleButton({Key? key, required this.onTap, this.color = Colors.white}) : super(key: key);

  final Color color;
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: () {
        onTap();
      },
      elevation: 2.0,
      fillColor: color,
      shape: const CircleBorder(),
      child: SizedBox(height: MediaQuery.of(context).size.height*0.07,),
    );
  }
}