import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_boss/model/company.dart';
import 'package:flutter_boss/config/config.dart';
import 'package:flutter_boss/pages/company_detail_page.dart';
import 'package:flutter_boss/widgets/company_item.dart';

class CompanyPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CompanyPageState();
  }

}

// AutomaticKeepAliveClientMixin 保持状态
class _CompanyPageState extends State<CompanyPage> with AutomaticKeepAliveClientMixin {
  List<Company> companyList =  List<Company>();
  
  // Future是什么意思
  Future<List<Company>> _fetchCompanyList() async {
    final response = await http.get('${Config.BASE_URL}/company/list/1');
    List<Company> companyList = List<Company>();
    if (response.statusCode == 200) {
      Map<String, dynamic> result = json.decode(response.body);
      for (dynamic data in result['data']['companies']) {
        Company companyData = Company.fromJson(data);
        companyList.add(companyData);
      }
    }
    return companyList;
  }

  @override
  bool get wantKeepAlive => true;

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
      body: new Center(
        child: FutureBuilder(
          future: _fetchCompanyList(),
          builder: (context, AsyncSnapshot snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return new CircularProgressIndicator();
              default:
                if (snapshot.hasError) {
                  return new Text('Error: ${snapshot.error}');
                } else {
                  return _createListView(context, snapshot);
                }
            }
          }
        ),
      )
    );
  }

}

Widget _createListView(BuildContext context, AsyncSnapshot snapshot) {
  List<Company> companyList = snapshot.data;
  return ListView.builder(
    key: new PageStorageKey('company-list'),
    itemCount: companyList.length,
    itemBuilder: (BuildContext context, int index) {
      return new CompanyItem(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) => CompanyDetailPage(company: companyList[index], heroLogo: 'heroLogo${index}',)
          ));
        },
        heroLogo: 'heroLogo${index}',
        company: companyList[index]
      );
    },
  );
}