import 'package:flutter/material.dart';

class CompanyPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CompanyPageState();
  }

}

class _CompanyPageState extends State<CompanyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        elevation: 0.0,
        centerTitle: false,
        title: Text('公司', style:  TextStyle(color: Colors.white, fontSize: 20.0),),
        actions: <Widget>[
          new IconButton(
            icon: Icon(Icons.search, color: Colors.white,),
            onPressed: () {

            }
          ),
          new IconButton(
              icon: Icon(Icons.filter_list, color: Colors.white,),
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