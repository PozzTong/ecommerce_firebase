import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotifiedPage extends StatelessWidget {
  const NotifiedPage({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments;
    final String label = arguments['label'];
    return Scaffold(
      appBar: AppBar(
        title: Text(label.toString().split("|")[0]),
      ),
    );
  }
}
