import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:twitch_clone_tutorial/screens/playerVid.dart';
import 'package:twitch_clone_tutorial/screens/videoappasset.dart';
import 'package:video_player/video_player.dart';

class Choice extends StatefulWidget {
  const Choice({Key? key}) : super(key: key);

  @override
  State<Choice> createState() => _ChoiceState();
}

class _ChoiceState extends State<Choice> {
  TextEditingController textEditingController = TextEditingController();
  String res = '';

  void _pickFile() async {
    // opens storage to pick files and the picked file or files
    // are assigned into result and if no file is chosen result is null.
    // you can also toggle "allowMultiple" true or false depending on your need
    final result = await FilePicker.platform.pickFiles();

    // if no file is picked
    if (result == null) return;

    PlatformFile file = result.files.first;
    VideoPlayerController.asset(file.name);
    // we get the file from result object
    // Navigator.push(
    //     context, MaterialPageRoute(builder: (context) => VideoAppAsset(file)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Link of video:'),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Center(
                child: TextField(
                  controller: textEditingController,
                  onSubmitted: (String str) async {
                    await Future.delayed(Duration(seconds: 2));
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                VideoApp(textEditingController.text)));
                  },
                ),
              ),
            ),
            Text('OR'),
            Text('Video File: '),
            Center(
              child: MaterialButton(
                onPressed: () {
                  _pickFile();
                },
                child: Text(
                  'Pick and open file',
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
