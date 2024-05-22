import 'package:flutter/material.dart';
import 'package:get/get.dart';

getSnackBar(
    {required String title,
    required String message,
    required IconData icon,
    int milliseconds = 900}) {
  removeAllGetSnackBars();
  return Get.snackbar(title, message,
      icon: Icon(
        icon,
        color: Colors.white,
      ),
      duration: Duration(milliseconds: milliseconds),
      backgroundColor: Colors.white);
}

getSnackBarError(
    {String title = 'Loading',
    String message = 'Please Wait!',
    int milliseconds = 900}) {
  removeAllGetSnackBars();

  return Get.snackbar(title, message,
      icon: const Icon(
        Icons.front_hand_outlined,
        color: Colors.white,
      ),
      duration: Duration(milliseconds: milliseconds),
      backgroundColor: Colors.white);
}

removeAllGetSnackBars() {
  Get.closeAllSnackbars();
}

// removeAllSnackBars(BuildContext context) {
//   ScaffoldMessenger.of(context).clearSnackBars();
// }

hideCurrentGetSnackBar() {
  Get.closeCurrentSnackbar();
}

hideCurrentSnackBar(BuildContext context) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
}
