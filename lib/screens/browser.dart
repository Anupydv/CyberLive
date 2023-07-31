import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:twitch_clone_tutorial/resources/firestore_methods.dart';
import 'package:twitch_clone_tutorial/responsive/responsive.dart';
import 'package:twitch_clone_tutorial/screens/broadcast_screen.dart';
import 'package:twitch_clone_tutorial/utils/colors.dart';
import 'package:twitch_clone_tutorial/utils/utils.dart';
import 'package:twitch_clone_tutorial/widgets/custom_button.dart';
import 'package:twitch_clone_tutorial/widgets/custom_textfield.dart';

class Browser extends StatefulWidget {
  const Browser({Key? key}) : super(key: key);

  @override
  State<Browser> createState() => _BrowserState();
}

class _BrowserState extends State<Browser> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Responsive(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  children: [
                    const Text(
                      'Player',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
