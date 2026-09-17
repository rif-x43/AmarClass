import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SimpleCalendar(),
    );
  }
}

class HomePage extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}


class SimpleCalendar extends StatefulWidget {
  const SimpleCalendar({super.key});

  @override
  State<SimpleCalendar> createState() => _SimpleCalendarState();
}

class _SimpleCalendarState extends State<SimpleCalendar> {
  DateTime today = DateTime.now();
  DateTime? selectDate;


  Map<DateTime, List<String>> taskTitles = {};
  Map<DateTime, List<String>> taskDescs = {};

 
  final titleController = TextEditingController();
  final descController = TextEditingController();

  @override
  void initState() {
    super.initState();
    selectDate = today;
  }

  
  DateTime justDate(DateTime d) {
    return DateTime(d.year, d.month, d.day);
  }

  
  void openBox({int? index, String? oldTitle, String? oldDesc}) {
    if (index != null) {
      titleController.text = oldTitle ?? '';
      descController.text = oldDesc ?? '';
    } else {
      titleController.clear();
      descController.clear();
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(index == null ? 'Add Task' : 'Edit Task'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(hintText: 'Title '),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: descController,
                decoration: const InputDecoration(hintText: 'Description '),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (titleController.text.isNotEmpty && selectDate != null) {
                  DateTime dKey = justDate(selectDate!);

                  setState(() {
                    if (taskTitles[dKey] == null) {
                      taskTitles[dKey] = [];
                      taskDescs[dKey] = [];
                    }

                    if (index == null) {
                      
                      taskTitles[dKey]!.add(titleController.text);
                      taskDescs[dKey]!.add(descController.text);
                    } else {
                     
                      taskTitles[dKey]![index] = titleController.text;
                      taskDescs[dKey]![index] = descController.text;
                    }
                  });

                  Navigator.pop(context);
                }
              },
              child: Text(index == null ? 'Save' : 'Update'),
            ),
          ],
        );
      },
    );
  }

  
  void deleteTask(DateTime dKey, int index) {
    setState(() {
      taskTitles[dKey]!.removeAt(index);
      taskDescs[dKey]!.removeAt(index);

      if (taskTitles[dKey]!.isEmpty) {
        taskTitles.remove(dKey);
        taskDescs.remove(dKey);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    DateTime? dKey = selectDate != null ? justDate(selectDate!) : null;
    List<String> titles = (dKey != null ? taskTitles[dKey] : null) ?? [];
    List<String> descs = (dKey != null ? taskDescs[dKey] : null) ?? [];

    return Scaffold(
      appBar: AppBar(title: const Text('Noob Task Calendar')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TableCalendar(
              firstDay: DateTime(2020),
              lastDay: DateTime(2030),
              focusedDay: today,
              selectedDayPredicate: (d) => isSameDay(selectDate, d),
              onDaySelected: (s, f) {
                setState(() {
                  selectDate = s;
                  today = f;
                });
              },
              eventLoader: (d) {
                return taskTitles[justDate(d)] ?? [];
              },
              headerStyle: const HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
              ),
            ),

            const Divider(thickness: 2),

            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Tasks:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  IconButton(
                    icon: const Icon(Icons.add_circle, color: Colors.blue, size: 32),
                    onPressed: () => openBox(),
                  ),
                ],
              ),
            ),
            titles.isEmpty
                ? const Padding(
                    padding: EdgeInsets.all(30.0),
                    child: Text('Zero Task!'),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: titles.length,
                    itemBuilder: (context, i) {
                      return Card(
                        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                        child: ListTile(
                          title: Text(titles[i], style: const TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Text(descs[i]),
                         
                          onLongPress: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return Wrap(
                                  children: [
                                    ListTile(
                                      leading: const Icon(Icons.edit, color: Colors.green),
                                      title: const Text('Edit'),
                                      onTap: () {
                                        Navigator.pop(context);
                                        openBox(index: i, oldTitle: titles[i], oldDesc: descs[i]);
                                      },
                                    ),
                                    ListTile(
                                      leading: const Icon(Icons.delete, color: Colors.red),
                                      title: const Text('Delete'),
                                      onTap: () {
                                        Navigator.pop(context);
                                        deleteTask(dKey!, i);
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }
}