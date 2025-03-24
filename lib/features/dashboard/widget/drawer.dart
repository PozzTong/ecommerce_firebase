import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/core.dart';

class Drawers extends StatefulWidget {
  const Drawers({
    super.key,
  });

  @override
  State<Drawers> createState() => _DrawersState();
}

class _DrawersState extends State<Drawers> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Log Out Method
  Future<void> logOut() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    try {
      await _auth.signOut();

      Get.offAllNamed(
        RouteHelper.loginScreen,
      );
      await sharedPreferences.remove(SharedPreferenceHelper.rememberMeKey);
      await sharedPreferences.remove(SharedPreferenceHelper.accessTokenKey);
    } catch (e) {
      // Handle error

      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error logging out: $e')),
      );
    }
  }

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
                      logOut();
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
