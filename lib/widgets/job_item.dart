
import 'package:flutter/material.dart';
import 'package:flutter_boss/model/job.dart';

class JobItem extends StatelessWidget {
  final Job job;

  JobItem({Key key, this.job, this.onPressed}) : super(key: key);
  VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: EdgeInsets.only(bottom: 10.0),
        padding: EdgeInsets.all(18.0),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Text(job.title, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 18.0, color: Colors.black, fontWeight: FontWeight.bold),)
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Text(job.salary, style: TextStyle(fontSize: 16.0, color: Color(0xFF53BFA5))),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: Text('${job.company}  ${job.category}', style: TextStyle(fontSize: 13.0, color: Color(0xFF434343))),
            ),
            _buildTags(context, job.info),
            Padding(
              padding: EdgeInsets.only(top: 12.0),
              child: new Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: NetworkImage(job.head),
                    radius: 15,
                  ),
                  new Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Text('${job.publish[0]} · ${job.publish[1]}', style: TextStyle(fontSize: 12.0, color: Color(0xFF5B5B5B))),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget _buildTags(BuildContext context, List<String> info) {
  List<Widget> tags = [];
  for(var item in info) {
    tags.add(Container(
      margin: EdgeInsets.only(right: 8.0),
      padding: EdgeInsets.only(left: 9.0, top: 3.0, right: 9.0, bottom: 3.0),
      child: Text(item, style: TextStyle(color: Color(0xFF525252),fontSize: 13.0),),
      decoration: BoxDecoration(
          color: Color(0XFFF8F8F8),
          borderRadius: BorderRadius.all(Radius.circular(2.0))
      ),
    ));
  }
  return Row(children: tags);
}