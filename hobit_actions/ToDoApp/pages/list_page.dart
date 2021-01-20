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

class _ListPageState extends State<ListPage> {
  bool _validate = false;

  List<Task> tasks = [];

  final TextEditingController eCtrl = TextEditingController();

  @override
  wodget build(BuildContext context) {
    return SafeArea(
      child: Scafold(
        resizeToAvoidBottunInset: false,
        appBar: AppBar(
          title: Text('Tasks'),
          centerTitle: true,
          actions: <Widget>[

          ],
        ),
      ),
    ),
// Stackを使用することによってZ軸上にWidgetを重ねる
    body: Stack();
  }
}

// 現在自国のフォーマット化するための関数を定義
String createDateFormat(now) {
  var formatter = DataFormat('yyyy/MM/dd/HH:mm');
  String formatted = fomatter.format(now);
  return formatted;
}

// Validateの後に行われる処理
// Listに新しいTaskが追加される処理
void addListItem(String text) {
  _validate = false;
  final Task newItem = Task(
    title: text,
    status: 'false',
    addedDate: createDataFormat(DateTime.now()),
    completeDate: '');
  //　Taskの0番目にこの入力したタスクを追加
  tasks.insert(0, newItem);
  // 入力内容の初期化
  eCtrl.clear();
  // SetStateを行うことによってWidgetの内容を更新
  setState(() {});
}

// Taskのアップデートを行う
void updateItems(Task task, int i) {
  if (task.status == 'false'){
    final updatedTask = Task(
      title: task.title,
      status: 'true',
      addedDate: task.addedDate,
      completedDate: cteateDateformat(DateTime.now())),
    // tasks のi 番目のタスクと新しいタスクと入れ替える。
    tasks[i] = updatedTask;
  } else if (task.status == 'ture'){
    final updateedTask = Task(
      title: task.title,
      status: 'false',
      addedDate: task.addedDate,
      copletedDate: '');
    tasks[i] = updatedTask;
  }
  // 状況を更新
  setState(() {});
}

void removeListItem(Task task) async {
  setState(() => tasks.remove(task));
}
