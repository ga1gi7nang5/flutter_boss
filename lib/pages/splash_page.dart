import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_boss/pages/home_page.dart';


class SplashPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new SplashState();
  }

}

class SplashState extends State<SplashPage> {
  Timer _t;

  @override
  void initState() {
    super.initState();
    _t = new Timer(const Duration(microseconds: 1500), () {
      try {
        // 知识点： 动画，PageRouteBuilder
        Navigator.pushAndRemoveUntil(context, PageRouteBuilder<Null>(
          pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
            return AnimatedBuilder(
              animation:  animation,
              builder: (BuildContext context, Widget child) {
                return Opacity(
                  opacity: animation.value,
                  child: new HomePage(title: 'Boss直聘'),
                );
              },
            );
          },
          transitionDuration: Duration(milliseconds: 300)
        ), (Route route) => route == null);
      } catch (e) {

      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _t.cancel();
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Material(
      color: new Color.fromARGB(255, 55, 194, 188),
      child: Container(
        alignment: Alignment(0, -0.3),
        child: Text(
          "Boss直聘",
          style: TextStyle(color: Colors.white, fontSize: 50.0, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}