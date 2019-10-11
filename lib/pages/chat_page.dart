import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ChatPageState();
  }

}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        elevation: 0.0,
        centerTitle: true,
        title: Text('聊天', style:  TextStyle(color: Colors.white, fontSize: 20.0),),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Text('暂无消息', style: TextStyle(color: Colors.grey, fontSize: 26.0),),
      ),
    );
  }

}