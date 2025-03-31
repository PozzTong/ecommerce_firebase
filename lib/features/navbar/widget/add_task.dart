import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../feature.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final DateSelectedController controller = Get.find<DateSelectedController>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DateSelectedController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.arrow_back_ios),
          ),
        ),
        body: Container(
          margin: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 4,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Add Task',
                  style: heading,
                ),
                MyFormField(
                  title: 'Tilte',
                  hint: 'Enter Title Here.',
                  controller: controller.titleController,
                ),
                MyFormField(
                  title: 'Note',
                  hint: 'Enter Note Here.',
                  controller: controller.noteController,
                ),
                MyFormField(
                  title: 'Date',
                  hint: DateFormat.yMd().format(controller.selectedDate),
                  // controller: ,
                  icon: IconButton(
                    onPressed: () {
                      controller.getDateFromUser(context);
                    },
                    icon: Icon(
                      Icons.calendar_month,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: MyFormField(
                        title: 'Start Time',
                        hint: controller.startTime,
                        icon: IconButton(
                          onPressed: () {
                            controller.getPickTimeUser(context,
                                isStartTime: true);
                          },
                          icon: Icon(
                            Icons.access_time_rounded,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: MyFormField(
                        title: 'End Time',
                        hint: controller.endTime,
                        icon: IconButton(
                          onPressed: () {
                            controller.getPickTimeUser(context,
                                isStartTime: false);
                          },
                          icon: Icon(
                            Icons.access_time_rounded,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                MyFormField(
                  title: 'Remind',
                  hint: "${controller.selectedReminder} minutes early",
                  icon: DropdownButton(
                    items: controller.remindList
                        .map<DropdownMenuItem<String>>((int value) {
                      return DropdownMenuItem<String>(
                        value: value.toString(),
                        child: Text(
                          value.toString(),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        controller.selectedReminder = int.parse(newValue!);
                      });
                    },
                    icon: Icon(Icons.keyboard_arrow_down),
                    iconSize: 32,
                    elevation: 4,
                    underline: Container(height: 0),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                MyFormField(
                  title: 'Repeat',
                  hint: "${controller.selectedRepeat} ",
                  icon: DropdownButton(
                    items: controller.repeatList
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        controller.selectedRepeat = newValue!;
                      });
                    },
                    icon: Icon(Icons.keyboard_arrow_down),
                    iconSize: 32,
                    elevation: 4,
                    borderRadius: BorderRadius.circular(15),
                    underline: Container(
                      height: 0,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Color',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          Wrap(
                            children: List<Widget>.generate(3, (int index) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    controller.selectedIndex = index;
                                  });
                                },
                                child: Container(
                                  margin: EdgeInsetsDirectional.all(3),
                                  alignment: Alignment.center,
                                  height: 25,
                                  width: 25,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: index == 0
                                        ? Colors.blue
                                        : index == 1
                                            ? Colors.amber
                                            : Colors.red,
                                  ),
                                  child: Center(
                                    child: controller.selectedIndex == index
                                        ? Icon(
                                            Icons.done,
                                            color: Colors.white,
                                            size: 20,
                                          )
                                        : Container(),
                                  ),
                                ),
                              );
                            }),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            controller.validateDate();
                            setState(() {});
                            // controller.clear();
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            backgroundColor: Colors.blue,
                          ),
                          child: Text(
                            'Create Task',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  TextStyle get heading {
    return GoogleFonts.lato(
      fontSize: 24,
      fontWeight: FontWeight.bold,
    );
  }
}

class MyFormField extends StatelessWidget {
  const MyFormField({
    super.key,
    this.hint,
    required this.title,
    this.controller,
    this.focus = false,
    this.icon,
  });
  final String? hint;
  final String title;
  final TextEditingController? controller;
  final bool focus;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: subHeading,
          ),
          TextFormField(
            readOnly: icon == null ? false : true,
            autofocus: focus,
            controller: controller,
            decoration: InputDecoration(
              suffixIcon: icon,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              hintText: hint,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
        ],
      ),
    );
  }

  TextStyle get subHeading {
    return GoogleFonts.lato(
      fontSize: 14,
      fontWeight: FontWeight.bold,
    );
  }
}
