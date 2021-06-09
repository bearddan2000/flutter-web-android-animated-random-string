import 'package:flutter/material.dart';
import 'dart:math';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}


class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation animation;
  String text = 'Hello World';

  String chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => chars.codeUnitAt(_rnd.nextInt(chars.length))));

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      duration: Duration(
        seconds: 1,
      ),
      vsync: this,
    );
    animation = Tween(begin: 1.0, end: 2.0).animate(animationController);

    animationController.addStatusListener(animationStatusListener);
    animationController.forward();
  }

  void animationStatusListener(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      text = getRandomString(5);
      animationController.reverse();
    } else if (status == AnimationStatus.dismissed) {
      text = getRandomString(5);
      animationController.forward();
    }
  }
@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Animated Text"),
      ),
      body: AnimatedBuilder(
        animation: animation,
        builder: (BuildContext context, Widget child) {
          final size = 100 * (animation.value);
          return Container(
          decoration: BoxDecoration(color: Colors.white),
          child: Center(
            child: Text(
              text,
              textDirection: TextDirection.ltr,
              style: TextStyle(
                fontSize: size,
                color: Colors.black87,
              ),
            ),
          ),
          );
        },
      ),
    );
  }
}
