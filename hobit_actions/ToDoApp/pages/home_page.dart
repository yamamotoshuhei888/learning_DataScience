import 'package:flutter/material.dart';
import 'app_background.dart';
import 'list_page.dart';

var homePageKey = GlobalKey<_HomePageStatus>();

class HomePage extends StatefulWidget{
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState creatState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: <Widget>[
          AppBackgroundPage(),
          ListPage(
            key: ListPageKey,
          )
        ],
      ),
    );
  }
}
