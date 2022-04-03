
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:timezone/timezone.dart' as tz;

class LocalNotifications {

  final FlutterLocalNotificationsPlugin _plugin = 
    FlutterLocalNotificationsPlugin();

  initialize() async {
    AndroidInitializationSettings _androidInit = 
      const AndroidInitializationSettings('@mipmap/pie');
    
    InitializationSettings _initSetting = InitializationSettings(
      android: _androidInit,
    );

    await _plugin.initialize(_initSetting);
  }

  dailyNotification(int hour, int minute) async {
    final String currentTime = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(currentTime));

    tz.TZDateTime utcTime = tz.TZDateTime.now(tz.local);


    tz.TZDateTime scheduleDate = tz.TZDateTime(
      tz.local,
      utcTime.year,
      utcTime.month,
      utcTime.day,
      hour,
      minute
    );

    if(scheduleDate.isBefore(utcTime)){
      scheduleDate = scheduleDate.add(const Duration(days: 1));
    }

    var bigImage = const BigPictureStyleInformation(
      DrawableResourceAndroidBitmap('@mipmap/big'),
      largeIcon: DrawableResourceAndroidBitmap('@mipmap/pie'),
      contentTitle: 'Es Hora de registrar Gastos',
      summaryText: 'No olvides registrar los gastos de tu día',
      htmlFormatContent: true,
      htmlFormatTitle: true
    );

    var _androidDetails = AndroidNotificationDetails(
      '1', 
      'name',
      styleInformation: bigImage
    );

    var _platform = NotificationDetails(
      android: _androidDetails
    );

    await _plugin.zonedSchedule(
      1, 
      'LLego el momento', 
      'No olvides registrar tus gastos', 
      scheduleDate, 
      _platform, 
      uiLocalNotificationDateInterpretation: 
        UILocalNotificationDateInterpretation.absoluteTime, 
      androidAllowWhileIdle: true,
      matchDateTimeComponents: DateTimeComponents.time
    );
  }

  


  cancelNotification() async {
    await _plugin.cancelAll();
  }
}