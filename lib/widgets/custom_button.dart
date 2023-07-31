import 'package:flutter/material.dart';
import 'package:twitch_clone_tutorial/utils/colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.onTap,
    required this.text,
  }) : super(key: key);
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          primary: buttonColor,
          minimumSize: const Size(200, 60),
          side: BorderSide(),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(40))),
      onPressed: onTap,
      child: Text(
        text,
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}
