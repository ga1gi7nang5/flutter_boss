import 'dart:convert';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:extended_text/extended_text.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_boss/pages/gallery_page.dart';
import 'package:flutter_boss/widgets/welfare_item.dart';
import 'package:flutter_boss/config/config.dart';
import 'package:flutter_boss/model/company.dart';
import 'package:flutter_boss/model/company_detail.dart';
import 'package:flutter_boss/widgets/scroll_img_item.dart';
class CompanyDetailPage extends StatefulWidget {
  final Company company;
  final String heroLogo;

  CompanyDetailPage({Key key, @required this.company, @required this.heroLogo}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CompanyDetailPageState();
  }


}

class _CompanyDetailPageState extends State<CompanyDetailPage> with SingleTickerProviderStateMixin {

  ScrollController _scrollController;
  bool _isShow = false;
  bool _showMoreInc = false;

  _scrollListener() {
    setState(() {
      if (_scrollController.offset < 56 && _isShow) {
        _isShow = false;
      } else if (_scrollController.offset >= 56 && _isShow == false) {
        _isShow = true;
      }
    });
  }

  // Future是什么意思
  Future<CompanyDetail> _fetchCompany() async {
    final response = await http.get('${Config.BASE_URL}/companyDetail/5da57a226c5cd1746106846f');
    CompanyDetail companyDetail;
    if (response.statusCode == 200) {
      companyDetail = CompanyDetail.fromJson(json.decode(response.body)['data']['companyDetail']);
    }
    return companyDetail;
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Center(
      child: Scaffold(
        backgroundColor: new Color.fromARGB(255, 68, 76, 96),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.1), BlendMode.dstATop),
              fit: BoxFit.cover,
              image: NetworkImage(widget.company.logo),
              alignment: Alignment.topLeft
            )
          ),
          child: _companyDetailView(context, () {
            setState(() {
              _showMoreInc = true;
            });
          }),
        ),
      )
    );
  }

  Widget _companyDetailView(BuildContext context, VoidCallback _onIncPressed) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        CustomScrollView(
          controller: _scrollController,
          slivers: <Widget>[
            SliverAppBar(
              elevation: 0.0,
              pinned: true,
              backgroundColor: Color.fromARGB(_isShow == true ? 255 : 0, 68, 76, 96),
              centerTitle: false,
              title: Text(widget.company.company, style: TextStyle(fontSize: 16.0, color: Color.fromARGB(_isShow == true ? 255 : 0, 255, 255, 255)),),
              actions: <Widget>[
                new IconButton(
                  icon: new Icon(
                    Icons.more_horiz,
                    color: Colors.white,
                  ),
                  onPressed: () {},
                )
              ],
            ),
            SliverList(
              delegate: SliverChildListDelegate(<Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: 20.0, left: 25.0, bottom: 10.0),
                            child: Text(widget.company.company, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25.0),),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 2.0, left: 25.0),
                            child: _buildTags(widget.company.info),
                          ),

                        ],
                      ),
                    ),
                    new Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 25.0, right: 30.0,),
                        child: Hero(
                          tag: widget.heroLogo,
                          child: ClipRRect(
                            borderRadius: new BorderRadius.circular(8.0),
                            child: Image.network(widget.company.logo, width: 70, height: 70,),
                          ),
                        )
                      ),
                    ),
                  ],
                ),
                FutureBuilder(
                  future: _fetchCompany(),
                  builder:  (context, snapshot) {
                    if (snapshot.hasData) {
                      return _companyBody(context, snapshot, _showMoreInc, _onIncPressed);
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                    return Center(child: CircularProgressIndicator());
                  },
                )
              ]),
            ),
          ],
        )
      ],
    );
  }

}

// 主体
Widget _companyBody(BuildContext context, AsyncSnapshot snapshot, bool _showMoreInc, VoidCallback _onIncPressed) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Padding(
        padding: EdgeInsets.only(top: 30.0, left: 25.0, right: 20.0),
        child: _createWorkHours()
      ),
      _createWelfareItem(),
      Padding(
        padding: EdgeInsets.only(left: 25.0, bottom: 20.0),
        child: Text("公司介绍", style: new TextStyle(color: Colors.white, fontSize: 20.0),),
      ),
      Padding(
        padding: EdgeInsets.only(left: 25.0, bottom: 10.0, right: 25.0),
        child: _createInc(snapshot.data.inc, _showMoreInc, _onIncPressed)
      ),
      Padding(
        padding: EdgeInsets.only(top: 20.0, left: 25.0, bottom: 20.0),
        child: Text("公司照片", style: new TextStyle(color: Colors.white, fontSize: 20.0),),
      ),
      Container(
        margin: EdgeInsets.only(left: 20.0, top: 20.0, right: 0.0, bottom: 50.0),
        height: 120.0,
        child: _createImgList(context, snapshot),
      )
    ],
  );
}

// 上班时间
Widget _createWorkHours() {
  return Wrap(
    spacing: 40.0,
    runSpacing: 16.0,
    direction: Axis.horizontal,
    children: <Widget>[
      Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(Icons.access_alarm, color: Colors.white, size: 18.0,),
          Padding(
            padding: EdgeInsets.only(right: 6.0),
          ),
          Text('上午09:30-下午06:00', style: new TextStyle(color: Colors.white, fontSize: 16.0),),
        ],
      ),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(
            Icons.account_balance_wallet,
            color: Colors.white,
            size: 18.0,
          ),
          Padding(
            padding: EdgeInsets.only(right: 6.0),
          ),
          Text(
            '双休',
            style: new TextStyle(color: Colors.white, fontSize: 16.0),
          ),
        ],
      ),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(
            Icons.movie,
            color: Colors.white,
            size: 18.0,
          ),
          Padding(
            padding: EdgeInsets.only(right: 6.0),
          ),
          Text(
            '弹性工作',
            style: new TextStyle(color: Colors.white, fontSize: 16.0),
          ),
        ],
      ),
    ],
  );
}

// 公司福利
Widget _createWelfareItem() {
  return Padding(
    padding: const EdgeInsets.only(top: 30.0, bottom: 10.0,),
    child: Container(
      margin: EdgeInsets.only(left: 20.0, top: 0.0, right: 0.0, bottom: 20.0),
      height: 58.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          WelfareItem(iconData: Icons.flip, title: "五险一金"),
          WelfareItem(iconData: Icons.security, title: "补充医疗"),
          WelfareItem(iconData: Icons.access_alarm, title: "定期体检"),
          WelfareItem(iconData: Icons.face, title: "年终奖"),
          WelfareItem(iconData: Icons.brightness_5, title: "带薪年假"),
        ],
      ),
    ),
  );
}

// 公司介绍
Widget _createInc(String text, bool isExpanded, VoidCallback _onPressed) {
  return new ExtendedText(text,
    style: TextStyle(color: Colors.white, height: 1.8),
    overFlowTextSpan: OverFlowTextSpan(
      children: <TextSpan>[
        TextSpan(text: '  \u2026  '),
        TextSpan(
            text: "查看更多",
            style: TextStyle(color: Colors.black38, height: 1.8),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                _onPressed();
              })
      ]
    ),
    maxLines: isExpanded == true ? null : 3,
  );
}

// 公司照片
Widget _createImgList(BuildContext context, AsyncSnapshot snapshot) {
  List imgList = snapshot.data.companyImgsResult;
  return ListView.builder(
    key: new PageStorageKey('img-list'),
    scrollDirection: Axis.horizontal,
    itemCount: imgList.length,
    itemBuilder: (BuildContext context, int index) {
      return ScrollImageItem(
        onPressed: () {
          Navigator.of(context).push(PageRouteBuilder<Null>(pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return AnimatedBuilder(
              animation: animation,
              builder: (BuildContext context, Widget child) {
                return Opacity(
                  opacity: animation.value,
                  child: GalleryPage(url: imgList, heroTag: 'heroTag${index}'),
                );
              },
            );
          }));
        },
        url: imgList[index],
        heroTag: 'heroTag${index}',
      );
    });
}
Widget _buildTags(List<String> info) {
  List<Widget> tags = [];
  int infoLength = info.length;
  for (int i = 0; i < infoLength; i++) {
    tags.add(Text(info[i], style: TextStyle(color: Colors.white,fontSize: 13.0),));
    if (i < infoLength - 1) {
      tags.add(Padding(
        padding: EdgeInsets.only(left: 3.0, right: 3.0),
        child:Text("·", style: TextStyle(color: Colors.white,fontSize: 12.0),)
      ));
    }
  }
  return Row(children: tags);
}
