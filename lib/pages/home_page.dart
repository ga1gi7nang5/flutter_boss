import 'package:flutter/material.dart';
import 'package:flutter_boss/model/layout_type.dart';
import 'package:flutter_boss/pages/job_page.dart';
import 'package:flutter_boss/pages/company_page.dart';
import 'package:flutter_boss/pages/chat_page.dart';
import 'package:flutter_boss/pages/mine_page.dart';


class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  LayoutType _layoutSelection = LayoutType.job;

  Color _colorTabMatching({LayoutType layoutSelection}) {
    return _layoutSelection == layoutSelection ? Colors.cyan[300] : Colors.grey;
  }

  BottomNavigationBarItem _buildItem({String icon, LayoutType layoutSelection}) {
    String text = layoutName(layoutSelection);
    return BottomNavigationBarItem(
      icon: Image.asset(icon, width: 30.0, height: 30.0,),
      title: Text(text, style: TextStyle(color: _colorTabMatching(layoutSelection: layoutSelection), fontSize: 12.0),)
    );
  }

  void _onSelectTab (index) {
    List<LayoutType> layoutTypeList = [LayoutType.job, LayoutType.company, LayoutType.chat, LayoutType.mine];
    setState(() {
      _layoutSelection = layoutTypeList[index];
    });
  }

  Widget _buildButtonNavBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: [
        _buildItem(
          icon: _layoutSelection == LayoutType.job ? "images/ic_main_tab_find_pre.png" : "images/ic_main_tab_find_nor.png",
          layoutSelection: LayoutType.job
        ),
        _buildItem(
          icon: _layoutSelection == LayoutType.company ? "images/ic_main_tab_company_pre.png" : "images/ic_main_tab_company_nor.png",
          layoutSelection: LayoutType.company
        ),
        _buildItem(
          icon: _layoutSelection == LayoutType.chat ? "images/ic_main_tab_contacts_pre.png" : "images/ic_main_tab_contacts_nor.png",
          layoutSelection: LayoutType.chat
        ),
        _buildItem(
          icon: _layoutSelection == LayoutType.mine ? "images/ic_main_tab_my_pre.png" : "images/ic_main_tab_my_nor.png",
          layoutSelection: LayoutType.mine
        ),
      ],
      onTap: _onSelectTab,
    );
  }

  Widget _buildBody() {
    LayoutType layoutSelection = _layoutSelection;
    switch (layoutSelection) {
      case LayoutType.job:
        return JobPage();
      case LayoutType.company:
        return CompanyPage();
      case LayoutType.chat:
        return ChatPage();
      case LayoutType.mine:
        return MinePage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
      bottomNavigationBar: _buildButtonNavBar(),
    );
  }
}