import 'package:flutter/material.dart';
//import 'tasks_screen_details.dart';
import 'task_item.dart';
/*class TaskItem
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

*/
class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});
  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen>
{
  List<TaskItem> tasks = [];
  /*
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
      status: 'In Progress',
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

    TaskItem(
      title: 'Bangla',
      course: 'HUM 1101',
      due: 'Tomorrow',
      status: 'DONE!',
    ),


  ];

*/


  void addTask()
  {
    TextEditingController titleController = TextEditingController();
    TextEditingController courseController = TextEditingController();
    TextEditingController dueController = TextEditingController();

    showDialog(
      context: context,
      builder: (context){
        return AlertDialog(
          title: const Text('Add Task'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: 'Task Title',
                ),
              ),
              TextField(
                controller: courseController,
                decoration: const InputDecoration(
                  labelText: 'Course',
                ),
              ),
              TextField(
                controller: dueController,
                decoration: const InputDecoration(
                  labelText: 'Due',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (titleController.text.isEmpty ||
                    courseController.text.isEmpty ||
                    dueController.text.isEmpty) {
                  return;
                }

                setState(() {
                  tasks.add(
                    TaskItem(
                      title: titleController.text,
                      course: courseController.text,
                      due: dueController.text,
                      status: 'NOT STARTED!',
                    ),
                  );
                });

                Navigator.pop(context);
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }


  void editTask(int index) {
    TextEditingController titleController =
    TextEditingController(text: tasks[index].title);
    TextEditingController courseController =
    TextEditingController(text: tasks[index].course);
    TextEditingController dueController =
    TextEditingController(text: tasks[index].due);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Task'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: 'Task Title',
                ),
              ),
              TextField(
                controller: courseController,
                decoration: const InputDecoration(
                  labelText: 'Course',
                ),
              ),
              TextField(
                controller: dueController,
                decoration: const InputDecoration(
                  labelText: 'Due',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {

                setState(() {
                  tasks[index].title = titleController.text;
                  tasks[index].course = courseController.text;
                  tasks[index].due = dueController.text;
                });
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }


  void deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }



  void markDone(int index,bool value)
  {
    setState(() {
      tasks[index].isDone = value;
      if(value){
        tasks[index].status = 'DONE!';
      }
      else{
        tasks[index].status = 'NOT STARTED!';
      }
    });
  }



  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks'),
        actions: [
          IconButton(
            onPressed: addTask,
            icon: const Icon(Icons.add),
          ),
        ],
      ),

      body: tasks.isEmpty
          ? const Center(
        child: Text(
          'No tasks yet',
          style: TextStyle(
            fontSize: 18,
          ),
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.only(bottom: 100),
        itemCount: tasks.length,
        itemBuilder: (context,index){
          TaskItem task = tasks[index];
          return Card(
            margin: const EdgeInsets.all(8),
            child: ListTile(
              contentPadding: const EdgeInsets.all(10),

              leading: Checkbox(
                value: task.isDone,
                onChanged: (value) {
                  markDone(
                    index,
                    value ?? false,
                  );

                },
              ),
              title: Text(
                task.title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  decoration: task.isDone
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),


              subtitle: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Text(task.course),
                  Text(task.due),
                  Text(
                    task.status,
                    style: TextStyle(
                      color: task.isDone
                          ? Colors.green : Colors.orange,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),


              // edit+del
              trailing: PopupMenuButton<String>(
                onSelected: (value) {
                  if (value == 'edit') {
                    editTask(index);
                  }
                  else if (value == 'delete') {
                    deleteTask(index);
                  }
                },
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: 'edit',
                    child: Row(
                      children: [
                        Icon(Icons.edit),
                        SizedBox(width: 8),
                        Text('Edit'),
                      ],
                    ),
                  ),
                  const PopupMenuItem(
                    value: 'delete',
                    child: Row(
                      children: [
                        Icon(Icons.delete),
                        SizedBox(width: 8),
                        Text('Delete'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}



