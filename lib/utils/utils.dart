class Utils {
  /**
   * 获取当前周次
   */
  static getTodayWeekDay() {
    String _weekDay = "周*";
    int today = DateTime.now().weekday;
    switch (today) {
      case 0:
        _weekDay = "周日";
        break;
      case 1:
        _weekDay = "周一";
        break;
      case 2:
        _weekDay = "周二";
        break;
      case 3:
        _weekDay = "周三";
        break;
      case 4:
        _weekDay = "周四";
        break;
      case 5:
        _weekDay = "周五";
        break;
      case 6:
        _weekDay = "周六";
        break;
    }

    return _weekDay;
  }
}
