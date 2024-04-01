import 'dart:core';

import 'package:intl/intl.dart';

import 'yq_text_util.dart';

/// 一些常用格式参照。可以自定义格式，例如：'yyyy/MM/dd HH:mm:ss'，'yyyy/M/d HH:mm:ss'。
/// 格式要求
/// year -> yyyy/yy   month -> MM/M    day -> dd/d
/// hour -> HH/H      minute -> mm/m   second -> ss/s
class YQDateFormats {
  static String full = 'yyyy-MM-dd HH:mm:ss';
  static String y_mo_d_h_m = 'yyyy-MM-dd HH:mm';
  static String y_mo_d = 'yyyy-MM-dd';
  static String y_mo = 'yyyy-MM';
  static String mo_d = 'MM-dd';
  static String mo_d_h_m = 'MM-dd HH:mm';
  static String h_m_s = 'HH:mm:ss';
  static String h_m = 'HH:mm';
  static String m_s = 'mm:ss';

  static String zh_full = 'yyyy年MM月dd日 HH时mm分ss秒';
  static String zh_y_mo_d_h_m = 'yyyy年MM月dd日 HH时mm分';
  static String zh_y_mo_d = 'yyyy年MM月dd日';
  static String zh_y_mo = 'yyyy年MM月';
  static String zh_mo_d = 'MM月dd日';
  static String zh_mo_d_h_m = 'MM月dd日 HH时mm分';
  static String zh_h_m_s = 'HH时mm分ss秒';
  static String zh_h_m = 'HH时mm分';
}

///时间转换工具
class YQTimeUtil {
  static DateTime? getDateTime(String dateStr, {bool? isUtc}) {
    DateTime? dateTime = DateTime.tryParse(dateStr);
    if (isUtc != null) {
      if (isUtc) {
        dateTime = dateTime!.toUtc();
      } else {
        dateTime = dateTime!.toLocal();
      }
    }
    return dateTime;
  }

  static DateTime getDateTimeByMs(int ms, {bool isUtc = false}) {
    return DateTime.fromMillisecondsSinceEpoch(ms, isUtc: isUtc);
  }

  static int? getDateMsByTimeStr(String dateStr, {bool? isUtc}) {
    DateTime? dateTime = getDateTime(dateStr, isUtc: isUtc);
    return dateTime?.millisecondsSinceEpoch;
  }

  static int getNowDateMs() {
    return DateTime.now().millisecondsSinceEpoch;
  }

  //将 unix 时间戳转换为特定时间文本，如年月日
  static String convertTime(int timestamp) {
    return convertTime3(getDateTimeByMs(timestamp));
  }

  //将时间转换为特定时间文本，如年月日
  static String convertTime2(String time) {
    DateTime msgTime = DateTime.parse(time);
    return convertTime3(msgTime);
  }

  static String convertTime3(DateTime msgTime) {
    DateTime nowTime = DateTime.now();
    if (nowTime.year == msgTime.year) {
      //同一年
      if (nowTime.month == msgTime.month) {
        //同一月
        if (nowTime.day == msgTime.day) {
          //同一天 时:分
          return DateFormat(YQDateFormats.h_m).format(msgTime).toString();
        } else {
          if (nowTime.day - msgTime.day == 1) {
            //昨天
            return "昨天";
          } else if (nowTime.day - msgTime.day < 7) {
            return getWeekday(msgTime);
          }
        }
      } else {
        return DateFormat(YQDateFormats.mo_d_h_m).format(msgTime).toString();
      }
    }
    return DateFormat(YQDateFormats.y_mo_d).format(msgTime).toString();
  }

  //获取当前时间
  static String getCurrentDate({String format = "yyyy-MM-dd HH:mm:ss"}) {
    return DateFormat(format).format(DateTime.now()).toString();
  }

  static String timestampConvertTime(int timestamp,
      {String format = "yyyy-MM-dd HH:mm:ss"}) {
    return DateFormat(format).format(getDateTimeByMs(timestamp)).toString();
  }

  static String timestampConvertTime5(int timestamp) {
    DateTime msgTime = getDateTimeByMs(timestamp);
    //大于 60 分钟
    if (timestamp.abs() > 60 * 60 * 1000) {
      return DateFormat(YQDateFormats.h_m_s).format(msgTime).toString();
    } else {
      return DateFormat(YQDateFormats.m_s).format(msgTime).toString();
    }
  }

  static String converTimeT(String strTime,
      {String oldFormat = "yyyy-MM-dd'T'HH:mm:ss",
      String newFormat = "MM-dd HH:mm"}) {
    //将yyyy-MM-dd'T'HH:mm:ss格式转换为DateTime
    DateTime timeWithT = DateFormat(oldFormat, "en_US").parse(strTime);
    //将DateTime转换为MM-dd HH:mm格式
    var strLastTime = DateFormat(newFormat).format(timeWithT);
    return strLastTime.toString();
  }

  static String converTime(String strTime,
      {String oldFormat = "yyyy-MM-dd HH:mm:ss",
      String newFormat = "MM-dd HH:mm"}) {
    //将yyyy-MM-dd HH:mm:ss格式转换为DateTime
    DateTime timeWith = DateFormat(oldFormat).parse(strTime);
    //将DateTime转换为MM-dd HH:mm格式
    var strLastTime = DateFormat(newFormat).format(timeWith);
    return strLastTime.toString();
  }

  ///是否需要显示时间，相差 5 分钟
  static bool needShowTime(int sentTime1, int sentTime2) {
    return (sentTime1 - sentTime2).abs() > 5 * 60 * 1000;
  }

  ///判读相差多少分钟
  static bool needShowTime2(String? sentTime1, String? sentTime2, int differ) {
    if (YQTextUtil.isEmpty(sentTime1) || YQTextUtil.isEmpty(sentTime2)) {
      return false;
    }
    DateTime time1 = DateTime.parse(sentTime1!);
    DateTime time2 = DateTime.parse(sentTime2!);
    int minutes = time2.difference(time1).inMinutes; // 15414648 分钟
    return minutes.abs() > differ;
  }

  static int needShowTime3(String? sentTime1, String? sentTime2) {
    if (YQTextUtil.isEmpty(sentTime1) || YQTextUtil.isEmpty(sentTime2)) {
      return -1;
    }
    DateTime time1 = DateTime.parse(sentTime1!);
    DateTime time2 = DateTime.parse(sentTime2!);
    int minutes = time2.difference(time1).inMinutes; // 15414648 分钟
    return minutes;
  }

  ///判断两个时间相差多少天
  static int differenceDays(String startTime) {
    if (YQTextUtil.isEmpty(startTime)) {
      return 0;
    }
    DateTime startDate = DateTime.parse(startTime);
    DateTime endDate = DateTime.now(); // 结束日期
    int days = endDate.difference(startDate).inDays;
    return days;
  }

  ///在之前——时间比较
  static bool timeIsBefore(String startTime, String endTime,
      {String format = "HH:mm"}) {
    DateTime startDate = DateFormat(format).parse(startTime);
    DateTime endDate = DateFormat(format).parse(endTime);
    return startDate.isBefore(endDate);
  }

  ///在之后——时间比较
  static bool timeIsAfter(String startTime, String endTime,
      {String format = "HH:mm"}) {
    DateTime startDate = DateFormat(format).parse(startTime);
    DateTime endDate = DateFormat(format).parse(endTime);
    return startDate.isAfter(endDate);
  }

  ///相等——时间比较
  static bool timeIsAtSameMomentAs(String startTime, String endTime,
      {String format = "HH:mm"}) {
    DateTime startDate = DateFormat(format).parse(startTime);
    DateTime endDate = DateFormat(format).parse(endTime);
    return startDate.isAtSameMomentAs(endDate);
  }

  /// 根据时间戳获取星期日期。
  static String? getWeekdayByMs(int milliseconds,
      {bool isUtc = false, bool en = false, bool short = false}) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(milliseconds);
    return getWeekday(dateTime, en: en, short: short);
  }

  static String getWeekday(DateTime dateTime,
      {bool en = false, bool short = false}) {
    String weekday = "";
    switch (dateTime.weekday) {
      case 1:
        weekday = en ? "Monday" : "星期一";
        break;
      case 2:
        weekday = en ? "Tuesday" : "星期二";
        break;
      case 3:
        weekday = en ? "Wednesday" : "星期三";
        break;
      case 4:
        weekday = en ? "Thursday" : "星期四";
        break;
      case 5:
        weekday = en ? "Friday" : "星期五";
        break;
      case 6:
        weekday = en ? "Saturday" : "星期六";
        break;
      case 7:
        weekday = en ? "Sunday" : "星期日";
        break;
      default:
        break;
    }
    if (short) {
      weekday = en ? weekday.substring(0, 3) : weekday.replaceAll('星期', '周');
    }
    return weekday;
  }

//获取年龄
  static String getAge(String? time) {
    if (YQTextUtil.isEmpty(time)) return "0";
    int age = 0;
    DateTime brt = DateTime.parse(time.toString());
    DateTime dateTime = DateTime.now();
    int yearNow = dateTime.year; //当前年份
    int monthNow = dateTime.month; //当前月份
    int dayOfMonthNow = dateTime.day; //当前日期

    int yearBirth = brt.year;
    int monthBirth = brt.month;
    int dayOfMonthBirth = brt.day;
    age = yearNow - yearBirth; //计算整岁数

    if (age > 0 && monthNow <= monthBirth) {
      if (monthNow == monthBirth) {
        if (dayOfMonthNow < dayOfMonthBirth) age--; //当前日期在生日之前，年龄减一
      } else {
        age--; //当前月份在生日之前，年龄减一
      }
    }
    return age.toString();
  }

  ///根据日期，返回星座
  static String getConstellation(String? time, {String format = "yyyy-MM-dd"}) {
    if (YQTextUtil.isEmpty(time)) return "";
    final String capricorn = '摩羯座'; //Capricorn 摩羯座（12月22日～1月20日）
    final String aquarius = '水瓶座'; //Aquarius 水瓶座（1月21日～2月19日）
    final String pisces = '双鱼座'; //Pisces 双鱼座（2月20日～3月20日）
    final String aries = '白羊座'; //3月21日～4月20日
    final String taurus = '金牛座'; //4月21～5月21日
    final String gemini = '双子座'; //5月22日～6月21日
    final String cancer = '巨蟹座'; //Cancer 巨蟹座（6月22日～7月22日）
    final String leo = '狮子座'; //Leo 狮子座（7月23日～8月23日）
    final String virgo = '处女座'; //Virgo 处女座（8月24日～9月23日）
    final String libra = '天秤座'; //Libra 天秤座（9月24日～10月23日）
    final String scorpio = '天蝎座'; //Scorpio 天蝎座（10月24日～11月22日）
    final String sagittarius = '射手座'; //Sagittarius 射手座（11月23日～12月21日）
    // DateTime birthday = DateFormat(format).parse(time);
    DateTime birthday = DateTime.parse(time.toString());
    int month = birthday.month;
    int day = birthday.day;
    String constellation = '';

    switch (month) {
      case DateTime.january:
        constellation = day < 21 ? capricorn : aquarius;
        break;
      case DateTime.february:
        constellation = day < 20 ? aquarius : pisces;
        break;
      case DateTime.march:
        constellation = day < 21 ? pisces : aries;
        break;
      case DateTime.april:
        constellation = day < 21 ? aries : taurus;
        break;
      case DateTime.may:
        constellation = day < 22 ? taurus : gemini;
        break;
      case DateTime.june:
        constellation = day < 22 ? gemini : cancer;
        break;
      case DateTime.july:
        constellation = day < 23 ? cancer : leo;
        break;
      case DateTime.august:
        constellation = day < 24 ? leo : virgo;
        break;
      case DateTime.september:
        constellation = day < 24 ? virgo : libra;
        break;
      case DateTime.october:
        constellation = day < 24 ? libra : scorpio;
        break;
      case DateTime.november:
        constellation = day < 23 ? scorpio : sagittarius;
        break;
      case DateTime.december:
        constellation = day < 22 ? sagittarius : capricorn;
        break;
    }

    return constellation;
  }

  /// Return whether it is leap year.
  /// 是否是闰年
  static bool isLeapYearByYear(int year) {
    return year % 4 == 0 && year % 100 != 0 || year % 400 == 0;
  }

  /// 是否同年.
  static bool yearIsEqual(DateTime dateTime, DateTime locDateTime) {
    return dateTime.year == locDateTime.year;
  }

  /// 是否是本周.
  static bool isWeek(int ms, {bool isUtc = false, int? locMs}) {
    if (ms == null || ms <= 0) {
      return false;
    }
    DateTime _old = DateTime.fromMillisecondsSinceEpoch(ms, isUtc: isUtc);
    DateTime _now;
    if (locMs != null) {
      _now = getDateTimeByMs(locMs, isUtc: isUtc);
    } else {
      _now = isUtc ? DateTime.now().toUtc() : DateTime.now().toLocal();
    }

    DateTime old =
        _now.millisecondsSinceEpoch > _old.millisecondsSinceEpoch ? _old : _now;
    DateTime now =
        _now.millisecondsSinceEpoch > _old.millisecondsSinceEpoch ? _now : _old;
    return (now.weekday >= old.weekday) &&
        (now.millisecondsSinceEpoch - old.millisecondsSinceEpoch <=
            7 * 24 * 60 * 60 * 1000);
  }
}
/*
*
* Flutter DateTime日期转换
1.日期转换成时间戳

var now=new DateTime.now();

print(now.millisecondsSinceEpoch); //单位毫秒，13位时间戳

2.时间戳转换成日期

var now=new DateTime.now();

var a=now.millisecondsSinceEpoch; // 时间戳

print(DateTime.fromMillisecondsSinceEpoch(a));

3.创建指定时间

DateTime assignDay = new DateTime(2020,10,10);

print(assignDay);   // 2020-10-10 00:00:00.000

4.计算时间跨度

// 例如计算1天14小时45分的跨度

Duration timeRemaining = new Duration(days:1, hours:14, minutes:45);

print(timeRemaining);  // 38:45:00.000000

5.字符串转DateTime

DateTime.parse('2019-11-08') 或者 DateTime.parse('2019-11-08 12:30:05')

6.在之前——时间比较

var today = DateTime.now();

var date = DateTime.parse("2019-06-20 15:32:41");

today.isBefore(date);

7.在之后——时间比较

var today = DateTime.now();

var date = DateTime.parse("2019-06-20 15:32:41");

today.isAfter(date);

8.相等——时间比较

var today = DateTime.now();

var date = DateTime.parse("2019-06-20 15:32:41");

today.isAtSameMomentAs(date);

9.时间增加

var today = DateTime.now();   // 2019-11-08 02:54:53.218443

var fiftyDaysFromNow = today.add(new Duration(days: 5));

print('today加5天：$fiftyDaysFromNow');  // today加5天：2019-11-13 02:54:53.218443

10.时间减少

var today = DateTime.now();   // 2019-11-08 02:54:53.218443

var fiftyDaysAgo = today.add(new Duration(days: 5));

print('today加5天：$fiftyDaysAgo ');  // today减5天：2019-11-03 02:54:53.218443

11.时间差(小时数)

var day1 = new DateTime(2019, 6, 20, 17, 30, 20);
var day2 = new DateTime(2019, 7, 21, 0,  0, 0);

print('比较两个时间 差 小时数：${day1.difference(day2)}');  //  比较两个时间 差 小时数：-726:29:40.000000

12.获取年、月、日、星期、时、分、秒、毫秒、微妙

year、month、day、weekday、hour、minute、second、millisecond、microsecond

var today = DateTime.now();

print(today.year);

13.获取本地时区简码

DateTime today = DateTime.now();
print('本地时区简码：${today.timeZoneName}');  //  本地时区简码：GMT

14.返回UTC与本地时差(小时数）

DateTime today = DateTime.now();

print('返回UTC与本地时差 小时数：${today.timeZoneOffset}');


*
* */
