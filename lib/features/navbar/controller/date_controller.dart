import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '/features/feature.dart';

class DateSelectedController extends GetxController {
  NotiService notiService;
  SqflitService service;
  DateSelectedController({
    required this.service,
    required this.notiService,
  });
  NotiService notiServices = Get.find<NotiService>();
  @override
  void onInit() {
    super.onInit();
    initData();
    endTime = DateFormat('hh:mm a').format(DateTime.now()).toString();
    startTime = DateFormat('hh:mm a').format(DateTime.now()).toString();
    DbHelper.initialDB();
  }

  var isLoading = true.obs;

  var taskList = <TaskModel>[].obs;
  TextEditingController titleController = TextEditingController(),
      noteController = TextEditingController();

  DateTime selectedDate = DateTime.now();

  Future<void> deleteTask(TaskModel taskModel) async {
    service.delete(taskModel);
    update();
  }

  String endTime = DateFormat('hh:mm a').format(DateTime.now()).toString();
  String startTime = DateFormat('hh:mm a').format(DateTime.now()).toString();
  int selectedIndex = 0;
  var selectedReminder = 5.obs;
  var selectedRepeat = "None".obs;
  List<int> remindList = [
    5,
    10,
    15,
    20,
  ];
  List<String> repeatList = [
    'None',
    'Daily',
    'Weekly',
    'Monthly',
  ];

  void updateReminder(int value) {
    selectedReminder.value = value;
    update();
  }

  void updateRepeat(String value) {
    selectedRepeat.value = value;
    update();
  }

  void updateIndex(int index) {
    selectedIndex = index;
    update();
  }

  getDateFromUser(BuildContext context) async {
    DateTime? pickerDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015),
      lastDate: DateTime(2030),
    );
    if (pickerDate != null) {
      selectedDate = pickerDate;
    } else {
      if (kDebugMode) {
        print("it's null");
      }
    }
    update();
  }

  Future<void> scheduledNotification(//no need update
      int hour, int minute, TaskModel taskModel) async {
    notiService.scheduledNotification(hour, minute, taskModel);
  }

  Future<void> noti(//no need update
    String? title,
    String? body,
  ) async {
    notiService.showNotification(title: title, body: body);
   
  }

  getPickTimeUser(BuildContext context, {required bool isStartTime}) async {
    var pickTime = await _showTimepicker(context);
    String formartTime = pickTime.format(context);
    if (pickTime == null) {
      print('Time is cancel');
    } else if (isStartTime == true) {
      startTime = formartTime;
    } else if (isStartTime == false) {
      endTime = formartTime;
    }
    update();
  }

  _showTimepicker(BuildContext context) {
    return showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
      context: context,
      initialTime: TimeOfDay(
        hour: int.parse(startTime.split(":")[0]),
        minute: int.parse(startTime.split(":")[1].split(" ")[0]),
      ),
    );
  }

  validateDate() {
    if (titleController.text.isNotEmpty && noteController.text.isNotEmpty) {
      addTaskToDB();
      Get.back();
    } else if (titleController.text.isEmpty || noteController.text.isEmpty) {
      Get.snackbar(
        'Required',
        'Al fields are required !',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.white,
        icon: Icon(
          Icons.warning_amber_rounded,
          color: Colors.red,
        ),
      );
    }
  }

  Future<void> addTaskToDB() async {
    await DbHelper.initialDB();
    TaskModel newTask = TaskModel(
      title: titleController.text.toString(),
      note: noteController.text.toString(),
      data: DateFormat.yMd().format(selectedDate),
      startTime: startTime,
      endTime: endTime,
      remind: selectedReminder.value,
      repeat: selectedRepeat.value,
      color: selectedIndex,
      isComplete: 0,
    );

    int value = await service.addTask(task: newTask);
    initData();
    if (value != -1) {
      print('Task added with values: $value');
      clear();
    }
  }

  void clear() {
    titleController.clear();
    noteController.clear();
    selectedDate = DateTime.now();
    startTime = DateFormat('hh:mm a').format(DateTime.now()).toString();
    endTime = DateFormat('hh:mm a').format(DateTime.now()).toString();
    selectedReminder = 5.obs;
    selectedIndex = 0;
    selectedRepeat = "None".obs;
  }

  Future<void> initData({bool sholdLoad = true}) async {
    isLoading.value = sholdLoad;
    update();

    try {
      await service.getTask();

      isLoading.value = false;
      update();
    } catch (e) {
      print('object$e');
    }
    isLoading.value = false;
    update();
  }
}
