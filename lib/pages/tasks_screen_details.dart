//import 'package:amarclass/pages/tasks_screen.dart';
import 'package:flutter/material.dart';
import 'package:amarclass/pages/task_item.dart';
class TaskDetailsScreen extends StatelessWidget {
  const TaskDetailsScreen({
    super.key,
    required this.task,
  });



  final TaskItem task;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Details'),
      ),
      body: Column(
        children:[
          Text(task.title),
          Text(task.course),
          Text(task.due),
          Text(task.status),


          ElevatedButton(
            onPressed: () {

                task.isDone = true;
                task.status = 'DONE!';
            },
            child: const Text('Complete Task'),
          ),
        ],
      ),
    );
  }
}