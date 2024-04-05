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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['task'] = this.task;
    data['note'] = this.note;
    data['isCompleted'] = this.isCompleted;
    data['date'] = this.date;
    data['time'] = this.time;
    data['color'] = this.color;
    data['isPinned'] = this.isPinned;
    return data;
  }
}
