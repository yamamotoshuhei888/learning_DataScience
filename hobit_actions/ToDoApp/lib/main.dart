import 'package:flutter/material.dart';
import 'package:ToDoApp/pages/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To Do List App',
      debugShowCheckedModeBanner: false,
      color: Colors.blue, //好きな色を選択
      // home: MyHomePage(title: 'Task List'),
      home: HomePage(),

      // theme: ThemeData(
      //   primarySwatch: Colors.blue,
      // ),

    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
            key: listPageKey,
          )
        ],
      ),
    );
  }
}
