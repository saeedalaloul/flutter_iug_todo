import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/db_helper.dart';
import 'package:todoapp/task_model.dart';
import 'package:todoapp/todo_provider.dart';

class TaskWidget extends StatefulWidget {
  Task task;
  Function function;
  TaskWidget(this.task, [this.function]);

  @override
  _TaskWidgetState createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ChangeNotifierProvider(
      create: (BuildContext context) => TodoProvider(),
      child: Card(
          margin: EdgeInsets.all(10),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      DBHelper.dbHelper.deleteTask(widget.task.id);
                      context.read<TodoProvider>().deleteTask(widget.task);
                      setState(() {});
                      if (widget != null && widget.function != null)
                        widget.function();
                    }),
                Text(widget.task.taskName),
                Checkbox(
                    value: widget.task.isComplete,
                    onChanged: (value) {
                      this.widget.task.isComplete =
                          !this.widget.task.isComplete;
                      DBHelper.dbHelper.updateTask(widget.task);
                      context.read<TodoProvider>().updateTask(widget.task);
                      setState(() {});
                      if (widget != null && widget.function != null)
                        widget.function();
                    }),
                Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage("assets/image.jpg"),
                  )),
                )
              ],
            ),
          )),
    );
  }
}

class TestPage extends StatelessWidget {
  bool randomCondition = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Test"),
      ),
      body: Container(
        child: Center(
          child: randomCondition
              ? Container(child: Text("true"))
              : Container(child: Text("false")),
        ),
      ),
    );
  }
}
