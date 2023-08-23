import 'package:flutter/widgets.dart';

final RouteObserver<ModalRoute> routeObserver = RouteObserver<ModalRoute>();

class FormatDate {
  static String formatDateYear(String date) {
    List<String> dateList = date.split("-");
    return "${dateList[0]}";
  }

  static String formatDate(String dateTime) {
    String month = "";
    List<String> dateTimeList = dateTime.split(" ");
    List<String> dateList = dateTimeList[0].split("-");
    switch (dateList[1]) {
      case "01":
        month = "January";
        break;
      case "02":
        month = "February";
        break;
      case "03":
        month = "March";
        break;
      case "04":
        month = "April";
        break;
      case "05":
        month = "May";
        break;
      case "06":
        month = "June";
        break;
      case "07":
        month = "July";
        break;
      case "08":
        month = "August";
        break;
      case "09":
        month = "September";
        break;
      case "10":
        month = "October";
        break;
      case "11":
        month = "November";
        break;
      case "12":
        month = "December";
        break;
    }
    return "$month ${dateList[2]}, ${dateList[0]}";
  }
}
