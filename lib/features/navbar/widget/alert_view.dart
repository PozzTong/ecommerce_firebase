import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../feature.dart';

class AlertTimer extends StatefulWidget {
  const AlertTimer({super.key});
  @override
  State<AlertTimer> createState() => _AlertTimerState();
}

class _AlertTimerState extends State<AlertTimer> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<NotificationController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              controller.showNotification(title: 'Title', body: 'Body');
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
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text('data'),
                      Text('data'),
                    ],
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      backgroundColor: Colors.blue,
                    ),
                    onPressed: () {},
                    child: Text('+ Add Task'),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
