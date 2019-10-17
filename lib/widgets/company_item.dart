import 'package:flutter/material.dart';
import 'package:flutter_boss/model/company.dart';

class CompanyItem extends StatelessWidget {
  final Company company;
  final String heroLogo;

  VoidCallback onPressed;
  VoidCallback onHotPressed;

  CompanyItem({Key key, this.company, this.onPressed, this.onHotPressed, @required this.heroLogo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: EdgeInsets.only(bottom: 8.0),
        padding: EdgeInsets.only(left: 18.0, top: 20.0, right: 10.0),
        color: Colors.white,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Hero(
              tag: heroLogo,
              child: Container(
                margin: EdgeInsets.only(right: 10.0),
                width: 50.0,
                height: 50.0,
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(3.0)),
                  child:Image.network(company.logo, width: 50.0,),
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFFF2F5FA), width: 1.0, style: BorderStyle.solid),
                  borderRadius: BorderRadius.all(Radius.circular(3.0))
                ),
              )
            ),
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('${company.company}', style: TextStyle(fontSize: 16.0, color: Colors.black, fontWeight: FontWeight.w500), maxLines: 1, overflow: TextOverflow.ellipsis,),
                  Padding(
                    padding: EdgeInsets.only(top: 4.0, bottom: 10.0),
                    child: Text('广州市 天河区', style: TextStyle(color: Colors.black38),),
                  ),
                  _buildTags(context, company.info),
                  Container(
                    margin: EdgeInsets.only(top: 10.0),
                    height: 1.0,
                    color: Color(0xFFE9E9E9),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 12.0, bottom: 12.0),
                    child: Row(
                      // 怎么添加事件
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Row(
                            children: <Widget>[
                              Text("热招", style: TextStyle(color: Color(0xFF5B5B5B),fontSize: 12.0)),
                              Padding(
                                  padding: EdgeInsets.only(left: 6.0),
                                  child:Text(company.hot, style: TextStyle(color: Color(0xFF53BFA5),fontSize: 12.0))
                              ),
                              Expanded(
                                flex: 1,
                                child: Text("等21个职位", style: TextStyle(color: Color(0xFF5B5B5B),fontSize: 12.0),maxLines: 1,overflow: TextOverflow.ellipsis,),
                              )
                            ],
                          )
                        ),
                        Icon(Icons.arrow_forward_ios, color: Colors.black12, size: 12.0,)
                      ],
                    ),
                  )
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