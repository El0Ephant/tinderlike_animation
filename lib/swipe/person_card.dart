import 'package:flutter/material.dart';
class PersonCard extends StatelessWidget {
  const PersonCard ({Key? key, required this.image}) : super(key: key);
  final String image;

  @override
  Widget build(BuildContext context) {

    final height = MediaQuery.of(context).size.height * 0.45;
    final width = MediaQuery.of(context).size.width * 0.8;

    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: SizedBox(
        height: height,
        width: width,
        child: Image.asset(image, fit: BoxFit.cover),
      ),
    );
  }
}