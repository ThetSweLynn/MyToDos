class Reminder {
  int? id;
  String? task;
  String? note;
  int? isCompleted;
  String? date;
  String? time;
  int? color;
  int? isPinned; //boolean

  Reminder(
      {this.id,
      this.task,
      this.note,
      this.isCompleted,
      this.date,
      this.time,
      this.color,
      this.isPinned});

  Reminder.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    task = json['task'].toString();
    note = json['note'].toString();
    isCompleted = json['isCompleted'];
    date = json['date'];
    time = json['time'];
    color = json['color'];
    isPinned = json['isPinned'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['task'] = task;
    data['note'] = note;
    data['isCompleted'] = isCompleted;
    data['date'] = date;
    data['time'] = time;
    data['color'] = color;
    data['isPinned'] = isPinned;
    return data;
  }
}
