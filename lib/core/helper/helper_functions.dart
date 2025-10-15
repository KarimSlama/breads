import 'package:breads/core/helper/extensions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppHelperFunctions {
  static void showSnackBar(String message, context) {
    ScaffoldMessenger.of(context!).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  static void showAlertDialog(String title, String message, context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () => context.pop(),
                child: Text('Ok'),
              ),
            ],
          );
        });
  }

  static String truncateText(String text, int maxLength) {
    if (text.length <= maxLength) {
      return text;
    } else {
      return '${text.substring(0, maxLength)}...';
    }
  }

  static bool isDark(context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  static Size screenSize(context) {
    return MediaQuery.of(context).size;
  }

  static double screenHeight(context) {
    return MediaQuery.of(context).size.height;
  }

  static double screenWidth(context) {
    return MediaQuery.of(context).size.width;
  }

  static String formatDateTime(String isoDate) {
    try {
      final dateTime = DateTime.parse(isoDate);
      final dateFormat = DateFormat('MMMM d, y');
      final timeFormat = DateFormat('h:mm a');

      return '${dateFormat.format(dateTime)} - ${timeFormat.format(dateTime)}';
    } catch (e) {
      return isoDate;
    }
  }

  static List<T> removeDuplicates<T>(List<T> list) {
    return list.toSet().toList();
  }

  static List<Widget> wrapWidget(List<Widget> widgets, int rowSize) {
    final wrappedList = <Widget>[];
    for (var i = 0; i < widgets.length; i += rowSize) {
      final rowChildren = widgets.sublist(
          i, i + rowSize > widgets.length ? widgets.length : i + rowSize);
      wrappedList.add(
        Row(
          children: rowChildren,
        ),
      );
    }
    return wrappedList;
  }
}
