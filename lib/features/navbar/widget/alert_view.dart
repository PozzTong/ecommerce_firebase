import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:ecomerce_app/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../feature.dart';

class AlertTimer extends StatefulWidget {
  const AlertTimer({super.key});
  @override
  State<AlertTimer> createState() => _AlertTimerState();
}

class _AlertTimerState extends State<AlertTimer> {
  final DateSelectedController controller = Get.find<DateSelectedController>();
  DateTime selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetBuilder<NotificationController>(
      builder: (controller) {
        return GetBuilder<DateSelectedController>(
          builder: (taskController) {
            return Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  onPressed: () {
                    // controller.showNotification(title: 'Title', body: 'Body');
                  },
                  icon: Icon(
                    FontAwesomeIcons.moon,
                  ),
                ),
                // title: Text('AlertTimer'),
                actions: [
                  CircleAvatar(
                    backgroundImage: AssetImage(
                      'assets/images/profile.png',
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                ],
              ),
              body: RefreshIndicator(
                onRefresh: () async {
                  await taskController.initData();
                },
                child: Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                DateFormat.yMMMMd().format(DateTime.now()),
                                style: subHeading,
                              ),
                              Text(
                                'Today',
                                style: heading,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 50,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                backgroundColor: Colors.blue,
                              ),
                              onPressed: () {
                                Get.toNamed(RouteHelper.addTask);
                              },
                              child: Text(
                                '+ Add Task',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      DatePicker(
                        DateTime.now(),
                        height: size.width * 0.28,
                        width: size.width * 0.2,
                        inactiveDates: [],
                        initialSelectedDate: DateTime.now(),
                        selectionColor: Colors.blue,
                        selectedTextColor: Colors.white,
                        dateTextStyle: GoogleFonts.lato(
                          textStyle: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            color: Colors.grey,
                          ),
                        ),
                        dayTextStyle: GoogleFonts.lato(
                          textStyle: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 10,
                            color: Colors.grey,
                          ),
                        ),
                        monthTextStyle: GoogleFonts.lato(
                          textStyle: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 10,
                            color: Colors.grey,
                          ),
                        ),
                        onDateChange: (date) {
                          setState(() {
                            selectedDate = date;
                          });
                        },
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: taskController.taskList.length,
                          itemBuilder: (context, index) {
                            final task = taskController.taskList[index];
                            // print(task.toJson());
                            if (task.repeat == 'Daily') {
                              scheduleTaskNotification(task, controller);
                              return todoWidget(
                                index,
                                taskController,
                                task,
                                size,
                              );
                            } else if (task.repeat == 'Weekly') {
                              String cleanedTime = task.data!.trim();
                              DateTime now = DateTime.now();
                              String combinedTime =
                                  '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')} $cleanedTime';
                              DateTime date =
                                  DateFormat('yyyy-MM-dd').parse(combinedTime);
                              String formattedDate =
                                  DateFormat('EEEE/dd/yyyy').format(date);
                              String week = formattedDate.split("/")[0];
                              String selecteDate = DateFormat('EEEE/dd/yyyy')
                                  .format(selectedDate);
                              String weekly = selecteDate.split('/')[0];
                              if (week == weekly) {
                                scheduleTaskNotification(task, controller);
                                return todoWidget(
                                  index,
                                  taskController,
                                  task,
                                  size,
                                );
                              }
                            } else if (task.repeat == 'Monthly') {
                              String cleanedTime = task.data!.trim();
                              DateTime now = DateTime.now();
                              String combinedTime =
                                  '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')} $cleanedTime';
                              DateTime date =
                                  DateFormat("yyyy-MM-dd").parse(combinedTime);
                              int day = date.day;
                              int selecteDay = selectedDate.day;
                              if (selecteDay == day) {
                                scheduleTaskNotification(task, controller);
                                return todoWidget(
                                  index,
                                  taskController,
                                  task,
                                  size,
                                );
                              }
                            } else if (task.repeat == 'None') {
                              scheduleTaskNotification(task, controller);
                              taskController.markTaskComplete(task.id!);
                            }
                            if (task.data ==
                                DateFormat.yMd().format(selectedDate)) {
                              return todoWidget(
                                index,
                                taskController,
                                task,
                                size,
                              );
                            } else {
                              return Container();
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  void scheduleTaskNotification(
      TaskModel task, NotificationController controller) {
    if (task.startTime != null && task.startTime!.isNotEmpty) {
      try {
        String cleanedTime = task.startTime!.trim();
        DateTime now = DateTime.now();
        String combinedTime =
            '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')} $cleanedTime';
        DateTime date = DateFormat("yyyy-MM-dd hh:mm a").parse(combinedTime);
        int hour = date.hour;
        int minute = date.minute;
        controller.scheduledNotification(hour, minute, task);
      } catch (e) {
        print("Error parsing time '${task.startTime}': $e");
      }
    } else {
      print("Invalid startTime: ${task.startTime}");
    }
  }

  Widget todoWidget(int index, DateSelectedController taskController,
      TaskModel task, Size size) {
    return AnimationConfiguration.staggeredList(
      duration: Duration(milliseconds: 300),
      position: index,
      child: SlideAnimation(
        curve: Curves.easeInOut,
        child: FlipAnimation(
          curve: Curves.easeInOut,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Slidable(
              key: const ValueKey(0),
              closeOnScroll: true,
              endActionPane: ActionPane(
                // dismissible: DismissiblePane(onDismissed: () {
                // }), // scroll to close
                motion: const DrawerMotion(),
                // extentRatio: 0.25,
                openThreshold: 0.2,
                closeThreshold: 0.2,
                children: [
                  SlidableAction(
                    spacing: 4,
                    flex: 1,
                    padding: EdgeInsets.all(8),
                    borderRadius: BorderRadius.circular(10),
                    // spacing: 4,
                    onPressed: (_) {
                      setState(() {
                        taskController.delete(taskController.taskList[index]);
                      });
                    },
                    backgroundColor: Colors.redAccent,
                    // foregroundColor: Colors.white,
                    icon: Icons.delete_outline,
                    label: 'Delete',
                  ),
                  SlidableAction(
                    spacing: 4,
                    flex: 1,
                    padding: EdgeInsets.all(8),
                    borderRadius: BorderRadius.circular(10),
                    onPressed: (_) {
                      showBottomSheet(context);
                      // taskController.markTaskComplete(task.id!);
                      // setState(() {
                      //   taskController.initData();
                      // });
                    },
                    backgroundColor: Colors.blueAccent,
                    icon: Icons.delete_outline,
                    label: 'Show Bts',
                  ),
                ],
              ),
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(8.0),
                // height: size.width * 0.35,
                width: size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: task.color == 0
                      ? Colors.blue
                      : task.color == 1
                          ? Colors.amber
                          : Colors.red,
                ),

                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            task.title!,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 17,
                            ),
                          ),
                          Row(
                            children: [
                              Icon(Icons.access_time_rounded),
                              Text(
                                ' ${task.startTime} - ${task.endTime}',
                              ),
                            ],
                          ),
                          Text(
                            '${task.note} ${task.repeat}',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(4),
                      height: size.width * 0.2,
                      width: 2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                    ),
                    RotatedBox(
                      quarterTurns: 3,
                      child: Text(
                        task.isComplete == 1 ? 'COMPLETE' : 'TODO',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  TextStyle get subHeading {
    return GoogleFonts.lato(
      fontSize: 24,
      fontWeight: FontWeight.bold,
    );
  }

  TextStyle get heading {
    return GoogleFonts.lato(
      fontSize: 30,
      fontWeight: FontWeight.bold,
    );
  }

  showBottomSheet(
    BuildContext context,
  ) {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.only(top: 4),
        height: MediaQuery.of(context).size.height * 0.24,
        child: Column(
          children: [
            Container(
              height: 6,
              width: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.red,
              ),
            )
          ],
        ),
      ),
    );
  }
}
