import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:todo_list_app/db/task.dart';
import 'package:todo_list_app/pages/app_background.dart';
import 'package:todo_list_app/pages/completed_task_page.dart';

var listPageKey = Globalkey<_ListPageState>();

class ListPage extends StatefulWidget{
  const ListPage({Key key}) : super(key: key);

  @override
  _ListPagesState createState() => _StatePageState();
}
