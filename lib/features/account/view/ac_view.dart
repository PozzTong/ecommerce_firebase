import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_windowmanager_plus/flutter_windowmanager_plus.dart';

import '../../feature.dart';
import '/core/core.dart';

class AcView extends StatefulWidget {
  const AcView({super.key});
  @override
  State<AcView> createState() => _AcViewState();
}

class _AcViewState extends State<AcView> {
  final DrawersController controller = Get.put(DrawersController());
  final AcController acController = Get.put(AcController());
  Color? color, colors;

  @override
  void initState() {
    super.initState();
    acController.fetchUser();
    WidgetsBinding.instance.addPostFrameCallback((timeStam) async {
      await FlutterWindowManagerPlus.addFlags(
        FlutterWindowManagerPlus.FLAG_SECURE,
      );
    });
  }

  @override
  void dispose() {
    FlutterWindowManagerPlus.clearFlags(
      FlutterWindowManagerPlus.FLAG_SECURE,
    );
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    colors = isDarkMode ? Colors.white : Colors.black;
    color = isDarkMode ? Colors.black : Colors.white;
    return Scaffold(
      appBar: AppBar(
          // backgroundColor: Colors.amber,
          // actions: [IconButton(onPressed: (){}, icon:Icon(Icons.edit))],
          ),
      body: Obx(
        () {
          if (acController.user.isEmpty) {
            return Center(child: CircularProgressIndicator());
          }

          final user = acController.user.first;
          return SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.all(8.0),
                      height: 80,
                      width: 80,
                      child: CircleAvatar(
                        child: Image.asset('assets/images/profile.png'),
                      ),
                    ),
                    Expanded(
                        child: ListTile(
                      title: Text('${user.lastName} ${user.firstName}'),
                      subtitle: Text(
                        acController.user.first.position,
                      ),
                      titleTextStyle: GoogleFonts.lato(
                        fontSize: 25,
                        color: colors,
                        fontWeight: FontWeight.bold,
                      ),
                      subtitleTextStyle: GoogleFonts.lato(
                        fontSize: 15,
                        color: colors,
                      ),
                    )),
                  ],
                ),
                items(
                  icon: Icons.phone_outlined,
                  text: acController.user.first.phone,
                  ontap: () {},
                  color: Colors.blue,
                  colors: colors!,
                ),
                items(
                  icon: Icons.email_outlined,
                  text: acController.user.first.email,
                  ontap: () {},
                  color: Colors.blue,
                  colors: colors!,
                ),
                Container(
                  width: size.width,
                  height: 1,
                  color: colors,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Obx(() {
                            return acController.isBalanceVisible.value
                                ? GestureDetector(
                                    onTap: () {
                                      acController.hideBalance();
                                    },
                                    child: Text(
                                      '\$1000',
                                      style: GoogleFonts.lato(
                                        color: colors,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                  )
                                : GestureDetector(
                                    onTap: () {
                                      acController.authenticate();
                                    },
                                    child: Text(
                                      '*****',
                                      style: GoogleFonts.lato(
                                        color: colors,
                                        fontSize: 18,
                                      ),
                                    ),
                                  );
                          }),
                          Text(
                            'Wallet',
                            style: GoogleFonts.lato(
                              fontSize: 15,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 80,
                      width: 1,
                      color: colors,
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            '12',
                            style: GoogleFonts.lato(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Order',
                            style: GoogleFonts.lato(
                              fontSize: 15,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  width: size.width,
                  height: 1,
                  color: colors,
                ),
                items(
                  ontap: () {
                    Get.toNamed(RouteHelper.favShoe);
                  },
                  icon: Icons.favorite_outline,
                  text: 'Your Favorite',
                  color: Colors.blue,
                  colors: colors!,
                ),
                items(
                  icon: Icons.account_balance_wallet_outlined,
                  text: 'Payment',
                  ontap: () {
                    Get.toNamed(RouteHelper.payMent);
                  },
                  color: Colors.blue,
                  colors: colors!,
                ),
                items(
                  icon: Icons.people_alt_outlined,
                  text: 'Tell Your Friend',
                  ontap: () {},
                  color: Colors.blue,
                  colors: colors!,
                ),
                items(
                  icon: Icons.bookmark_outline,
                  text: 'Promotions',
                  ontap: () {},
                  color: Colors.blue,
                  colors: colors!,
                ),
                items(
                  icon: Icons.settings_outlined,
                  text: 'Setting',
                  ontap: () {},
                  color: Colors.blue,
                  colors: colors!,
                ),
                Divider(),
                items(
                  icon: Icons.logout_outlined,
                  text: 'Log Out',
                  ontap: () {
                    dialog(
                        title: 'Log Out',
                        subtitle: 'Are you sure?',
                        onConfirm: () {
                          controller.logOut();
                        });
                  },
                  color: Colors.red,
                  colors: Colors.red,
                ),
                SizedBox(
                  height: 80,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<dynamic> dialog({
    required String title,
    required String subtitle,
    required Function onConfirm,
  }) {
    return Get.defaultDialog(
      contentPadding: EdgeInsets.all(8),
      radius: 5,
      title: title,
      middleText: subtitle,
      confirm: GestureDetector(
        onTap: () {
          onConfirm();
          Get.back(); // Close the dialog after confirming
        },
        child: Container(
          alignment: Alignment.center,
          height: 40,
          width: 70,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.blueAccent,
          ),
          child: Text(
            'Confirm',
            style: GoogleFonts.lato(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
      cancel: GestureDetector(
        onTap: () {
          Get.back(); // Close the dialog without confirming
        },
        child: Container(
          alignment: Alignment.center,
          height: 40,
          width: 70,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: Colors.red,
            ),
          ),
          child: Text(
            'Cancel',
            style: GoogleFonts.lato(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }

  Widget items({
    required IconData icon,
    required String text,
    required Function ontap,
    required Color color,
    required Color colors,
  }) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Row(
        children: [
          IconButton(
            onPressed: () => ontap(),
            icon: Icon(
              icon,
              color: color,
              size: 26,
            ),
          ),
          Text(
            text,
            style: GoogleFonts.lato(color: colors),
          ),
        ],
      ),
    );
  }
}
