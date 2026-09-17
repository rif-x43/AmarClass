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


  @override
  Widget build(BuildContext context) {
    DateTime? dKey = selectDate != null ? justDate(selectDate!) : null;

    return Scaffold(
      appBar: AppBar(title: const Text('Task Calendar')),
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
                  // IconButton(
                  //   icon: const Icon(Icons.add_circle, color: Colors.blue, size: 32),
                  //   onPressed: () => openBox(),
                  // ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}