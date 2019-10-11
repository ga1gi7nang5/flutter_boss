import 'package:flutter/material.dart';

class JobPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _JobPageState();
  }

}

class _JobPageState extends State<JobPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        elevation: 0.0,
        centerTitle: true,
        title: Text('职位', style:  TextStyle(color: Colors.white, fontSize: 20.0),),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Text('职位界面'),
      ),
    );
  }

}