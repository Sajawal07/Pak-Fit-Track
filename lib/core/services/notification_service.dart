import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../../data/models/notification_log.dart';
import '../../data/repositories/notification_repository.dart';
import '../../providers/auth_provider.dart';
import '../../main.dart';
import 'daily_report_data_service.dart';

class NotificationService {
  NotificationService(this._ref);

  final Ref _ref;
  bool _authReadyListenerAttached = false;

  static final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();
  static bool _initialized = false;
  Timer? _dailyCheckTimer;

  /// Initialize the notification plugin and schedule the daily summary.
  Future<void> init() async {
    if (_initialized) return;

    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation(_guessTimeZone()));

    const androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const initSettings = InitializationSettings(
      android: androidSettings,
    );

    await _plugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: _onNotificationTap,
    );

    await _plugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();

    _initialized = true;

    await _scheduleDailyProgressNotification();
    _startDailyCheckTimer();
    _attachAuthReadyListener();
  }

  /// Defer daily report until Firebase auth session is restored — prevents
  /// generating a zero-value report for uid `"guest"` on cold start at 9 PM.
  void _attachAuthReadyListener() {
    if (_authReadyListenerAttached) return;
    _authReadyListenerAttached = true;

    _ref.listen(authBootstrapCompleteProvider, (prev, ready) {
      if (ready == true) {
        triggerDailyReportIfNeeded();
      }
    }, fireImmediately: true);
  }

  Future<void> _scheduleDailyProgressNotification() async {
    try {
      await _plugin.zonedSchedule(
        0,
        '📊 Daily Progress Report',
        'Open Pak Fit Track to view your fitness summary.',
        _next9PM(),
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'daily_progress',
            'Daily Progress Report',
            channelDescription: 'Sends your daily fitness summary at 9 PM',
            importance: Importance.high,
            priority: Priority.high,
            icon: '@mipmap/ic_launcher',
            styleInformation: BigTextStyleInformation(''),
          ),
        ),
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
        matchDateTimeComponents: DateTimeComponents.time,
      );
      debugPrint('[NotificationService] Scheduled daily 9 PM reminder');
    } catch (e) {
      debugPrint('[NotificationService] Error scheduling: $e');
    }
  }

  tz.TZDateTime _next9PM() {
    final now = tz.TZDateTime.now(tz.local);
    var scheduled =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, 21, 0, 0);
    if (scheduled.isBefore(now)) {
      scheduled = scheduled.add(const Duration(days: 1));
    }
    return scheduled;
  }

  void _startDailyCheckTimer() {
    _dailyCheckTimer?.cancel();
    _dailyCheckTimer = Timer.periodic(const Duration(minutes: 30), (_) {
      final now = DateTime.now();
      if (now.hour == 21 && now.minute < 30) {
        _generateAndSendDailyReport();
      }
    });
  }

  Future<void> _generateAndSendDailyReport() async {
    try {
      if (!_ref.read(authBootstrapCompleteProvider)) {
        debugPrint('[NotificationService] Auth not ready — deferring daily report');
        return;
      }

      final prefs = _ref.read(sharedPreferencesProvider);
      final auth = _ref.read(firebaseAuthProvider);
      final uid = resolveActiveUid(prefs: prefs, auth: auth);
      if (uid.isEmpty) {
        debugPrint('[NotificationService] No active session — skipping daily report');
        return;
      }

      final notifRepo = _ref.read(notificationRepositoryProvider);
      final existing = await notifRepo.getNotifications(uid);
      final today = DateTime.now();
      final alreadySent = existing.any((n) =>
          n.type == 'daily_progress' &&
          n.uid == uid &&
          n.loggedAt.year == today.year &&
          n.loggedAt.month == today.month &&
          n.loggedAt.day == today.day);
      if (alreadySent) return;

      final dataService = _ref.read(dailyReportDataServiceProvider);
      var snapshot = await dataService.gatherForUid(uid);
      if (snapshot == null) {
        debugPrint('[NotificationService] No profile for uid=$uid — skipping');
        return;
      }

      if (!snapshot.hasAnyTrackedData) {
        await Future.delayed(const Duration(seconds: 2));
        snapshot = await dataService.gatherForUid(uid);
        if (snapshot == null || !snapshot.hasAnyTrackedData) {
          debugPrint(
              '[NotificationService] No tracked data yet for uid=$uid — skipping');
          return;
        }
      }

      final bodyText = _formatReportBody(snapshot);
      final stepsGoalAchieved = snapshot.steps >= snapshot.stepGoal;
      final titleEmoji = stepsGoalAchieved ? '🎉' : '📊';
      final title = stepsGoalAchieved
          ? '$titleEmoji Goal Achieved! Great Job Today!'
          : '$titleEmoji Your Daily Progress Report';

      await _showNotification(title: title, body: bodyText);

      final log = NotificationLog()
        ..uid = uid
        ..title = title
        ..body = bodyText
        ..type = 'daily_progress'
        ..loggedAt = DateTime.now()
        ..isRead = false;
      await notifRepo.saveNotification(log);

      debugPrint('[NotificationService] Daily report sent for uid=$uid');
    } catch (e) {
      debugPrint('[NotificationService] Error generating daily report: $e');
    }
  }

  String _formatReportBody(DailyReportSnapshot s) {
    final sb = StringBuffer();
    sb.writeln('⏰ Snapshot at 9 PM (so far today)');

    sb.writeln('👣 Steps: ${s.steps} / ${s.stepGoal}');
    if (s.steps >= s.stepGoal) {
      sb.writeln('   ✅ Step goal achieved! Zabardast!');
    } else {
      sb.writeln('   ❌ ${s.stepGoal - s.steps} steps remaining');
    }

    sb.writeln('🔥 Burned (total): ${s.totalBurn} kcal');
    sb.writeln('   ❤️ BMR: ${s.bmr} kcal');
    sb.writeln('   🏋️ Exercise: ${s.exerciseBurn} kcal');
    sb.writeln('   🚶 Steps: ${s.stepsBurn} kcal');
    sb.writeln('🍽️ Eaten: ${s.eaten} / ${s.calorieTarget} kcal');
    sb.writeln(
        '💧 Water: ${s.waterGlasses} / ${s.waterGoalGlasses} glasses');

    final net = s.eaten - s.totalBurn;
    final netLabel =
        net > 0 ? 'Surplus' : (net < 0 ? 'Deficit' : 'Balanced');
    sb.writeln('⚖️ Net balance: ${net.abs()} kcal ($netLabel)');

    if (s.latestWeight != null && s.goalWeight != null) {
      final diff = s.latestWeight! - s.goalWeight!;
      if (diff > 0) {
        sb.writeln(
            '⚖️ Weight: ${s.latestWeight!.toStringAsFixed(1)} kg (${diff.toStringAsFixed(1)} kg to goal)');
      } else if (diff == 0) {
        sb.writeln(
            '⚖️ Weight: ${s.latestWeight!.toStringAsFixed(1)} kg — 🎯 Goal Reached!');
      } else {
        sb.writeln(
            '⚖️ Weight: ${s.latestWeight!.toStringAsFixed(1)} kg — 🎯 Below goal!');
      }
    }

    if (s.broke7DayRecord) {
      sb.writeln(
          '\n🏆 New 7-day record! You beat your best day this week. Zabardast!');
    } else if (s.steps >= s.stepGoal) {
      sb.writeln(
          '\n💪 Shandar! Keep this energy tomorrow! / شاندار! کل بھی ایسے ہی رہنا!');
    } else if (s.bestPrev7DaySteps > 0) {
      sb.writeln(
          '\n📈 This week best: ${s.bestPrev7DaySteps} steps. You’re close — keep going!');
    } else {
      sb.writeln('\n🌟 Kal aur behtar karein! / Tomorrow, do even better!');
    }

    return sb.toString().trim();
  }

  Future<void> _showNotification({
    required String title,
    required String body,
  }) async {
    const details = NotificationDetails(
      android: AndroidNotificationDetails(
        'daily_progress',
        'Daily Progress Report',
        channelDescription: 'Your daily fitness summary',
        importance: Importance.high,
        priority: Priority.high,
        icon: '@mipmap/ic_launcher',
        styleInformation: BigTextStyleInformation(''),
      ),
    );

    await _plugin.show(
      DateTime.now().millisecondsSinceEpoch ~/ 1000,
      title,
      body,
      details,
    );
  }

  Future<void> showReminder({
    required String title,
    required String body,
  }) async {
    await _showNotification(title: title, body: body);

    try {
      final prefs = _ref.read(sharedPreferencesProvider);
      final auth = _ref.read(firebaseAuthProvider);
      final uid = resolveActiveUid(prefs: prefs, auth: auth);
      if (uid.isNotEmpty) {
        final log = NotificationLog()
          ..uid = uid
          ..title = title
          ..body = body
          ..type = 'reminder'
          ..loggedAt = DateTime.now()
          ..isRead = false;
        await _ref.read(notificationRepositoryProvider).saveNotification(log);
      }
    } catch (_) {}
  }

  static void _onNotificationTap(NotificationResponse response) {
    debugPrint(
        '[NotificationService] Notification tapped: ${response.payload}');
  }

  String _guessTimeZone() {
    try {
      final offset = DateTime.now().timeZoneOffset;
      if (offset.inHours == 5) return 'Asia/Karachi';
      return 'Asia/Karachi';
    } catch (_) {
      return 'Asia/Karachi';
    }
  }

  Future<void> triggerDailyReportIfNeeded() async {
    if (!_ref.read(authBootstrapCompleteProvider)) return;
    final now = DateTime.now();
    if (now.hour >= 21) {
      await _generateAndSendDailyReport();
    }
  }

  void dispose() {
    _dailyCheckTimer?.cancel();
  }
}

final notificationServiceProvider = Provider<NotificationService>((ref) {
  final service = NotificationService(ref);
  ref.onDispose(service.dispose);
  return service;
});
