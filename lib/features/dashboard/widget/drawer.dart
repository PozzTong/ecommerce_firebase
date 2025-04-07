import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../feature.dart';

class Drawers extends StatefulWidget {
  const Drawers({
    super.key,
  });

  @override
  State<Drawers> createState() => _DrawersState();
}

class _DrawersState extends State<Drawers> {
  final DrawersController controller = Get.put(DrawersController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Column(
          children: [
            DrawerHeader(
              child: Text('data'),
            ),
            Expanded(
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      controller.logOut();
                    },
                    child: Text('Log Out!'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
