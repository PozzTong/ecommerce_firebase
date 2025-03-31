class TaskModel {
  int? id;
  String? title;
  String? note;
  String? data;
  String? startTime;
  String? endTime;
  int? remind;
  String? repeat;
  int? color;
  int? isComplete;
  TaskModel({
    this.id,
    this.title,
    this.note,
    this.data,
    this.startTime,
    this.endTime,
    this.remind,
    this.repeat,
    this.color,
    this.isComplete,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'],
      title: json['title'],
      note: json['note'],
      data: json['data'],
      startTime: json['startTime'],
      endTime: json['endTime'],
      remind: json['remind'],
      repeat: json['repeat'],
      color: json['color'],
      isComplete: json['isComplete'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'note': note,
      'data': data,
      'startTime': startTime,
      'endTime': endTime,
      'remind': remind,
      'repeat': repeat,
      'color': color,
      'isComplete': isComplete,
    };
  }
}
