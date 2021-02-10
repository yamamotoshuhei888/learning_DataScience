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

  // Listの宣言
  // List<task>を宣言することによってTaskオブジェクトのみを格納するオブジェクトを作成する
  // []という形でデフォルトを空と宣言しておかないとエラーになる。
  List<Task> tasks = [];

  // Input fieldで使用するControllerの定義
  final TextEditingController eCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose(){
    eCtrl.dispose();
    super.dispose();
  };

  // 現在時刻のフォーマット化するための関数を定義
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

  //タスクの削除を行う処理
  void removeListItem(Task task) async {
    setState(() => tasks.remove(task));
  }

  @override
  wodget build(BuildContext context) {
    return SafeArea(
      child: Scafold(
        resizeToAvoidBottunInset: false,
        appBar: AppBar(
          title: Text('Tasks'),
          centerTitle: true,
          actions: <Widget>[
            // 次回で作成する
            // Padding(
            //   padding: EdgeInset.all(8.0),
            //   child: IconButton(
            //     icon: Icon(Icons.check_box),
            //     onPressed: (){
            //       Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //           builder: (context) => completedTask(
            //             task: task,
            //           )
            //         )
            //       )
            //     }
            //   )
            // )
          ],
        ),
      ),
    ),
// Stackを使用することによってZ軸上にWidgetを重ねる
    body: Stack(
      children: <Widget>[
        AppBackgroundPage(),
        // Columnを使用することで二つのwidgetを重ねて配置
        Column(
          children: <Widget>[
            // INputboxWidgetを呼び出し
            buildInputContainer(),
            Expanded(
              child: ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (BuildContext context, int i) {
                  // List 一つのデザインを定義する
                  // 好みで変更して良い。
                  return buildListItem(tasks, i);
                },
              ),
            )
          ],
        ),
      ],
    );
  }

  // List itemの定義
  Dismissible buildListItem(List<Task> tasks, int i) {
    return Dismissible(
      key: ObjectKey(tasks[i]),
      //Slidableを使うことによってWodgetを左右にスライドすることが可能になる。
      child: Slidable(
        actionPane: SlidableDrawerActionPane(),
        child: Column(
          children: <Widget>[
            ListTile(
              subtitle: tasks[i].status == 'false'
                  ? Text(tasks[i].addedDate)
                  : Text(tasks[i].completedDate),
                title: Text(
                  tasks[i].title,
                  style: TextStyle(
                    color:
                    tasks[i].status == 'false' ? Color.black : Colors.grey,
                    decoration: tasks[i].status == 'false'
                      ? TextDecoration.none
                      : TextDecoration.lineThrough),
                  ),
                  leading: Icon(Icons.list),
                  trailing: IconButton(
                    icon: Icon(
                      (tasks[i].status == 'false')
                        ? Icons.check_box_outline_blank
                        : Icons.check_box,
                        color: Colors.greenAccent,
                    ),
                    onPressed: () {
                      updateItems(tasks[i], i);
                    },
                  ),
                ),
              Divider(height: 0)
          ],
        ),
        // 右にスライドした際に行う処理を記載する。
        // 今回はチェックとアンチェックを行う処理をここで記述する。
        actions: <Widget>[
          tasks[i].status == 'false' ? IconSlideAcion(
            caption: 'Complete',
            color: Colors.greenAccent,
            icon: Icons.check,
            onTap: () {
              updateItems(tasks[i], i);
            },
          )
        ],
        // 右にスライドした際に行う処理を記載するその２
        //  ここでは削除を行う処理を記載
        secondaryActions: <Widget>[
          IconSlideAcion(
            caption: 'Delete',
            color: Colors.red,
            icon: Icons.delete,
            onTap: () {
              removeListItem(tasks[i]);
            },
          )
        ],
      ),
    );
  }

  // Input Field Container　の追加
  // インプットボックスの定義を行う。
  Padding buildInputContainer(){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(8.0),
              height: MediaQuery.of(context).size.height * 0.1,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                  BorderRadius.horizontal(left: Radius.circular(8.0))
              ),
              child: TextField(
                controller: eCtrl,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Enter your task",
                  errorText: _validate ? "The input is empty." : null,
                  contentPadding: EdgeInsets.all(8),
                ),
                onTap: () => setStateE(() => _validate = false),
      // Keyboardの完了が押された際にアイテムを追加する。
      // 必要なければ省略しても良い。
                onSubmitted: (text) {
                  if (text.isEmpty) {
                    setState((){
                      _validate = true;
                    });
                  } else {
                    addListItem(text);
                  }
                },
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.1,
              // MediaQuery: デバイスの画面サイズを得る。
            child: RaisedButton(
              color: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius:
                  BorderRadius.horizontal(right: Radius.circular(8.0)),
              ),
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.add, color: Colors.white),
              ),
              onPressed: () {
                if (eCtrl.text.isEmpty) {
                  setState(() => _validate = true);
                } else {
                  addListItem(eCtrl.text);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

}
