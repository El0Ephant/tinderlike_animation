import "package:flutter/material.dart";


class CircleButton extends StatelessWidget {
  const CircleButton({Key? key, required this.onTap, this.color = Colors.white, this.icon}) : super(key: key);

  final Color color;
  final Function onTap;
  final Icon? icon;
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: () {
        onTap();
      },
      elevation: 2.0,
      fillColor: color,
      shape: const CircleBorder(),
      child: SizedBox(height: MediaQuery.of(context).size.height*0.06, child:  icon ?? const Center(),),
    );
  }
}