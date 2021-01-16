import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:todoapp/db_helper.dart';
import 'package:todoapp/new_task.dart';
import 'package:todoapp/task_model.dart';
import 'package:todoapp/task_widget.dart';
import 'package:todoapp/todo_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      child: MaterialApp(
          home: new SplashScreen(
        seconds: 5,
        navigateAfterSeconds: new TabBarPage(),
        routeName: "/",
        title: new Text(
          'TODO APP',
          style: new TextStyle(
              fontWeight: FontWeight.bold, fontSize: 30.0, color: Colors.white),
        ),
        // image: new Image.network(
        //     'https://flutter.io/images/catalog-widget-placeholder.png'),
        backgroundColor: Colors.black,
        loaderColor: Colors.white,
      )),
      create: (BuildContext context) => TodoProvider(),
    );
  }
}

class TabBarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        drawer: Drawer(),
        appBar: AppBar(
          title: Text('Todo'),
          bottom: TabBar(
            tabs: [
              Tab(
                text: 'All Tasks',
              ),
              Tab(
                text: 'Complete Tasks',
              ),
              Tab(
                text: 'InComplete Tasks',
              )
            ],
          ),
        ),
        body: Container(
          child: TabBarView(
              children: [AllTasks(), CompleteTasks(), InCompleteTasks()]),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return NewTask();
            }));
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}

class AllTasks extends StatefulWidget {
  @override
  _AllTasksState createState() => _AllTasksState();
}

class _AllTasksState extends State<AllTasks> {
  _refreshTaskList() async {
    List<Task> tasks = await DBHelper.dbHelper.fetchAllTasks();
    setState(() {
      context.read<TodoProvider>().setTasks(tasks);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _refreshTaskList();
  }

  myFun() {
    setState(() {});
    _refreshTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => TodoProvider(),
        child: SingleChildScrollView(
          child: Column(
            children: context.watch<TodoProvider>().tasks == null
                ? []
                : context
                    .watch<TodoProvider>()
                    .tasks
                    .map((e) => TaskWidget(e, myFun()))
                    .toList(),
          ),
        ));
  }
}

class CompleteTasks extends StatefulWidget {
  @override
  _CompleteTasksState createState() => _CompleteTasksState();
}

class _CompleteTasksState extends State<CompleteTasks> {
  _refreshTaskList() async {
    List<Task> tasks = await DBHelper.dbHelper.fetchAllTasks();
    setState(() {
      context.read<TodoProvider>().setTasks(tasks);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _refreshTaskList();
  }

  myFun() {
    setState(() {});
    _refreshTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TodoProvider(),
      child: SingleChildScrollView(
        child: Column(
          children: context.watch<TodoProvider>().tasks == null
              ? []
              : context
                  .watch<TodoProvider>()
                  .tasks
                  .where((element) => element.isComplete == true)
                  .map((e) => TaskWidget(e, myFun()))
                  .toList(),
        ),
      ),
    );
  }
}

class InCompleteTasks extends StatefulWidget {
  @override
  _InCompleteTasksState createState() => _InCompleteTasksState();
}

class _InCompleteTasksState extends State<InCompleteTasks> {
  _refreshTaskList() async {
    List<Task> tasks = await DBHelper.dbHelper.fetchAllTasks();
    setState(() {
      context.read<TodoProvider>().setTasks(tasks);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _refreshTaskList();
  }

  myFun() {
    setState(() {});
    _refreshTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TodoProvider(),
      child: SingleChildScrollView(
        child: Column(
          children: context.watch<TodoProvider>().tasks == null
              ? []
              : context
                  .watch<TodoProvider>()
                  .tasks
                  .where((element) => element.isComplete == false)
                  .map((e) => TaskWidget(e, myFun()))
                  .toList(),
        ),
      ),
    );
  }
}
