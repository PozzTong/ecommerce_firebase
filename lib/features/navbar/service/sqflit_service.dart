import 'package:get/get.dart';

import '../../feature.dart';

class SqflitService extends GetxService {
  @override
  void onInit() {
    getTask();
    super.onInit();
  }

  var taskList = <TaskModel>[].obs;

  Future<int> addTask({TaskModel? task}) async {
    try {
      return await DbHelper.insert(task);
    } catch (e) {
      print("Error inserting task: $e");
      return -1;
    }
  }

  Future<void> getTask() async {
    List<Map<String, dynamic>> tasks = await DbHelper.query();
    taskList.assignAll(tasks.map((data) => TaskModel.fromJson(data)).toList());
  }

  void delete(TaskModel task) {
    DbHelper.delete(task);
  }
  
  void markTaskComplete(int id) async {
    await DbHelper.update(id);
  }
}
