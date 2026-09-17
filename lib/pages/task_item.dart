class TaskItem {
  String title;
  String course;
  String due;
  String status;
  bool isDone= false;

  TaskItem({
    required this.title,
    required this.course,
    required this.due,
    required this.status,
  });
}