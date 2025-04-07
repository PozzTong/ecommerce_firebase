import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../feature.dart';

class BioView extends StatefulWidget {
  const BioView({super.key});

  @override
  State<BioView> createState() => _BioViewState();
}

class _BioViewState extends State<BioView> {
  TextEditingController controller = TextEditingController();
  // String enteredNumber = "";
  // final BioController bioController = Get.find<BioController>();
  final BioController bioController = Get.put(BioController());

  Color? color, colors;
  @override
  void initState() {
    bioController.authorized();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    colors = isDarkMode ? Colors.white : Colors.black;
    color = isDarkMode ? Colors.black : Colors.white;
    return GetBuilder<BioController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Enter Your Pin',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                pin(size, controller, colors!),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: controller.authenticate,
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Authenticate'),
                      SizedBox(width: 8),
                      Icon(Icons.perm_device_information),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: controller.ondelete,
                  child: const Text('Delete'),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget pin(Size size, BioController controller, Color color) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      width: size.width,
      child: Column(
        children: [
          Text(
            controller.enteredNumber.padRight(4, '_'),
            style: const TextStyle(fontSize: 32, letterSpacing: 10),
          ),
          const SizedBox(height: 20),
          ...[
            ['1', '2', '3'],
            ['4', '5', '6'],
            ['7', '8', '9'],
            ['0']
          ].map((row) => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: row.map((nu) {
                  return _buildNumberButton(nu, controller, color);
                }).toList(),
              )),
        ],
      ),
    );
  }

  Widget _buildNumberButton(
      String number, BioController controller, Color color) {
    return GestureDetector(
      onTap: () =>
          controller.onNumberPressed(number), // Use the controller here
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.all(8),
        height: 70,
        width: 70,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: color),
        ),
        child: Text(
          number,
          style: TextStyle(
            fontSize: 24,
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
