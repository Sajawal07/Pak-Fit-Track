import 'package:isar/isar.dart';

part 'notification_log.g.dart';

@collection
class NotificationLog {
  Id id = Isar.autoIncrement;

  String uid = '';
  String title = '';
  String body = '';
  String type = 'general'; // daily_progress, reminder, achievement, general
  DateTime loggedAt = DateTime.now();
  bool isRead = false;
}
