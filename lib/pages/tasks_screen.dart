import 'package:flutter/material.dart';
class TaskItem
{
  String title;
  String course;
  String due;
  String status;

  TaskItem({
    required this.title,
    required this.course,
    required this.due,
    required this.status,
  });
}


class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});
  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen>
{
  List<TaskItem> tasks = [
    TaskItem(
      title: 'Data Structures Assignment',
      course: 'CSE 2103',
      due: 'Due Thursday',
      status: 'NOT STARTED!',
    ),

    TaskItem(
      title: 'DLD Project Submission',
      course: 'CSE 2106',
      due: 'Due Friday',
      status: 'In progress',
    ),


    TaskItem(
      title: 'Statistics',
      course: 'CSE 2109',
      due: 'Tomorrow',
      status: 'DONE!',
    ),


    TaskItem(
      title: 'Physics',
      course: 'CSE 2109',
      due: 'Tomorrow',
      status: 'DONE!',
    ),

    TaskItem(
      title: 'Chemistry',
      course: 'CSE 2109',
      due: 'Tomorrow',
      status: 'DONE!',
    ),

    TaskItem(
      title: 'Algorithm',
      course: 'CSE 2109',
      due: 'Tomorrow',
      status: 'DONE!',
    ),

    TaskItem(
      title: 'Muhehe',
      course: 'CSE 2109',
      due: 'Tomorrow',
      status: 'DONE!',
    ),


  ];


  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        title:const Text('Tasks'),
      ),

      body: ListView.builder(
          itemCount: tasks.length,
          itemBuilder:(context,index){
            TaskItem task = tasks[index];
            
            return Card(
              margin: const EdgeInsets.all(10),
              child: ListTile(
                leading: const Icon(Icons.assessment),
                contentPadding: const EdgeInsets.all(10),
                title: Text(
                    task.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(task.course),
                    Text(task.due),
                  ],
                ),
                trailing: Text(
                    task.status,
                    style: const TextStyle(
                      color:Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                ),
              ),
            );
          },
        ),
    );
  }
}

