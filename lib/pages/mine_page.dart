import 'package:flutter/material.dart';

class MinePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MinePageState();
  }

}

class _MinePageState extends State<MinePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        elevation: 0.0,
        actions: <Widget>[
          new IconButton(
              icon: Icon(Icons.crop_free, color: Colors.white,),
              onPressed: () {

              }
          ),
          new IconButton(
              icon: Icon(Icons.settings, color: Colors.white,),
              onPressed: () {

              }
          )
        ],
      ),
      body: Container(
        alignment: Alignment.center,
        child: Text('暂无消息', style: TextStyle(color: Colors.grey, fontSize: 26.0),),
      ),
    );
  }

}