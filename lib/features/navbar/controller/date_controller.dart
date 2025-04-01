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
  @override
  void onInit() {
    super.onInit();
    initData();
    DbHelper.initialDB();
    // notiService.initNotification(); //to fetch
  }

  final SqflitService services = Get.find<SqflitService>();
  final NotiService notiServices = Get.find<NotiService>();

  var isLoading = true.obs;

  var taskList = <TaskModel>[].obs;
  TextEditingController 
      titleController = TextEditingController(),
      noteController = TextEditingController();

  DateTime selectedDate = DateTime.now();

  String endTime = DateFormat('hh:mm a').format(DateTime.now()).toString();
  String startTime = DateFormat('hh:mm a').format(DateTime.now()).toString();
  int selectedReminder = 5, selectedIndex = 0;
  List<int> remindList = [
    5,
    10,
    15,
    20,
  ];
  String selectedRepeat = "None";
  List<String> repeatList = [
    'None',
    'Daily',
    'Weekly',
    'Monthly',
  ];

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

  addTaskToDB() async {
    await DbHelper.initialDB();
    TaskModel newTask = TaskModel(
      title: titleController.text,
      note: noteController.text,
      data: DateFormat.yMd().format(selectedDate),
      startTime: startTime,
      endTime: endTime,
      remind: selectedReminder,
      repeat: selectedRepeat,
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
    selectedReminder = 5;
    selectedIndex = 0;
    selectedRepeat = "None";
    update();
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
