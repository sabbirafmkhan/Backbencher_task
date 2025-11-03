import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;

class AlarmHelper {
  static final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  static void initialize() {
    tz.initializeTimeZones();
    var initializationSettingsAndroid = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );
    _plugin.initialize(initializationSettings);
  }

  static Future<void> scheduleAlarm(DateTime time) async {
    var androidDetails = AndroidNotificationDetails(
      'alarmChannel',
      'Alarm Notifications',
      importance: Importance.max,
      priority: Priority.high,
    );
    var platformDetails = NotificationDetails(android: androidDetails);

    await _plugin.zonedSchedule(
      time.millisecondsSinceEpoch ~/ 1000,
      'Alarm',
      "It's time for your scheduled alarm!",
      tz.TZDateTime.from(time, tz.local),
      platformDetails,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.wallClockTime,
      matchDateTimeComponents: DateTimeComponents.dateAndTime,
    );
  }
}
