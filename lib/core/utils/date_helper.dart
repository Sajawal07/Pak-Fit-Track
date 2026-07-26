import 'package:intl/intl.dart';

class DateHelper {
  DateHelper._();

  static DateTime get today {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day);
  }

  static DateTime startOfDay(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  static DateTime get todayEnd {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day, 23, 59, 59);
  }

  static String formatDate(DateTime date) {
    final now = today;
    if (date.year == now.year &&
        date.month == now.month &&
        date.day == now.day) {
      return 'Today';
    }
    final yesterday = now.subtract(const Duration(days: 1));
    if (date.year == yesterday.year &&
        date.month == yesterday.month &&
        date.day == yesterday.day) {
      return 'Yesterday';
    }
    return DateFormat('EEE, d MMM').format(date);
  }

  static String formatTime(DateTime dt) => DateFormat('h:mm a').format(dt);

  static String formatShortDate(DateTime date) =>
      DateFormat('d MMM').format(date);

  static String formatFullDate(DateTime date) =>
      DateFormat('EEEE, d MMMM yyyy').format(date);

  static DateTime startOfWeek(DateTime date) {
    final weekday = date.weekday;
    return DateTime(date.year, date.month, date.day - (weekday - 1));
  }

  static List<DateTime> last7Days() {
    return List.generate(
      7,
      (i) => today.subtract(Duration(days: 6 - i)),
    );
  }

  static List<DateTime> last30Days() {
    return List.generate(
      30,
      (i) => today.subtract(Duration(days: 29 - i)),
    );
  }

  static bool isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  static String greetingMessage() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good Morning';
    if (hour < 17) return 'Good Afternoon';
    if (hour < 21) return 'Good Evening';
    return 'Good Night';
  }

  static bool isLateNight(DateTime dt) {
    final hour = dt.hour;
    return hour >= 22 || hour < 4;
  }
}
