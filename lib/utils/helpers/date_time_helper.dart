class DateTimeHelper {
  static DateTime format() {
    DateTime date = DateTime.now().toLocal();
    DateTime dateTomorrow = date.add(Duration(days: 1));

    String resultToday = getDate(fullDateTime: date) + " 08:00:00.000";
    String resultTomorrow = getDate(
          fullDateTime: dateTomorrow,
        ) +
        " 08:00:000";

    if (date.hour > 8) {
      return DateTime.parse(resultTomorrow).toUtc();
    }
    return DateTime.parse(resultToday).toUtc();
  }

  static String getDate({DateTime fullDateTime}) {
    String month = fullDateTime.month.toString();
    String day = fullDateTime.day.toString();
    String _month;
    String _day;
    if (month.length == 2) {
      _month = month;
    } else {
      _month = "0$month";
    }
    if (day.length == 2) {
      _day = day;
    } else {
      _day = "0$day";
    }

    String result = "${fullDateTime.year}-$_month-$_day";
    return result;
  }
}
