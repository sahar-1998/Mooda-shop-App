import 'package:flutter/material.dart';

class WidgetButton extends StatelessWidget {
  String text;
  Color color;

  Function onPress;

  WidgetButton(
      {required this.onPress, required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        minimumSize: const Size(250, 55),
      ),
      onPressed: () {
        onPress();
      },
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
