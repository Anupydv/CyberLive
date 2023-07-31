import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitch_clone_tutorial/providers/user_provider.dart';
import 'package:twitch_clone_tutorial/screens/broadcast_screen.dart';
import 'package:twitch_clone_tutorial/screens/browser.dart';
import 'package:twitch_clone_tutorial/screens/choice.dart';
import 'package:twitch_clone_tutorial/screens/feed_screen.dart';
import 'package:twitch_clone_tutorial/screens/go_live_screen.dart';
import 'package:twitch_clone_tutorial/screens/onboarding_screen.dart';
import 'package:twitch_clone_tutorial/screens/signup_screen.dart';
import 'package:twitch_clone_tutorial/screens/playerVid.dart';
import 'package:twitch_clone_tutorial/utils/colors.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = '/home';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _page = 0;
  List<Widget> pages = [
    const FeedScreen(),
    const GoLiveScreen(),
    Choice(),
    const LogoutScreen(),
  ];

  onPageChange(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: buttonColor,
        unselectedItemColor: primaryColor,
        backgroundColor: backgroundColor,
        unselectedFontSize: 12,
        onTap: onPageChange,
        currentIndex: _page,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.live_tv,
            ),
            label: 'Live',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add_rounded,
            ),
            label: 'Go Live',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.video_call,
            ),
            label: 'Video player',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.logout,
            ),
            label: 'Logout',
          ),
        ],
      ),
      body: pages[_page],
    );
  }
}

class LogoutScreen extends StatefulWidget {
  const LogoutScreen({Key? key}) : super(key: key);

  @override
  State<LogoutScreen> createState() => _LogoutScreenState();
}

class _LogoutScreenState extends State<LogoutScreen> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(),
      title: Text('Do you really want to logout?'),
      actions: [
        Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 20),
          child: InkWell(
            onTap: () {
              FirebaseAuth.instance.signOut();
              Navigator.pop(context,
                  MaterialPageRoute(builder: (context) => OnboardingScreen()));
            },
            child: Container(
              width: 100,
              height: 40,
              decoration: BoxDecoration(
                  color: Color.fromRGBO(145, 71, 255, 1),
                  borderRadius: BorderRadius.circular(20)),
              child: Center(
                  child: Text('Yes!',
                      style: TextStyle(
                        color: Colors.white,
                      ))),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 20),
          child: InkWell(
            onTap: () {
              Navigator.pushReplacementNamed(context, HomeScreen.routeName);
            },
            child: Container(
              width: 160,
              height: 40,
              decoration: BoxDecoration(
                  color: Color.fromRGBO(145, 71, 255, 1),
                  borderRadius: BorderRadius.circular(20)),
              child: Center(
                child: Text('No, I wanna stay here',
                    style: TextStyle(
                      color: Colors.white,
                    )),
              ),
            ),
          ),
        )
      ],
    );
  }
}
