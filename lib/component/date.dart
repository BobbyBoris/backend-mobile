class DateData {
  final String datetime;

  DateData(this.datetime);

  factory DateData.fromJson(Map<String, dynamic> parsedJson) {
    final datetime = parsedJson['datetime'] as String;
    return DateData(datetime);
  }
}
