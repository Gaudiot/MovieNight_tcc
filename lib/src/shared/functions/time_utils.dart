import "package:movie_night_tcc/src/core/design/app_strings.dart";

class DateInfo {
  final int value;
  final String label;

  DateInfo({
    required this.value,
    required this.label,
  });
}

class TimeUtils {
  const TimeUtils._();

  static String intToRuntime(int runtime) {
    return "${runtime ~/ 60}h${(runtime % 60).toString().padLeft(2, '0')}m";
  }

  static String dateTimeToYear(DateTime date) {
    return date.year.toString();
  }

  static List<DateInfo> runtimeToDateInfo(int runtime) {
    final minutes = runtime % 60;
    final hours = (runtime ~/ 60) % 24;
    final days = (runtime ~/ (60 * 24)) % 30;
    final months = (runtime ~/ (60 * 24 * 30)) % 12;
    final years = runtime ~/ (60 * 24 * 30 * 12);

    final List<DateInfo> dateInfos = [];

    if (years > 0) {
      dateInfos
          .add(DateInfo(value: years, label: AppStrings.profile.years(years)));
    }

    if (months > 0) {
      dateInfos.add(
        DateInfo(value: months, label: AppStrings.profile.months(months)),
      );
    }

    if (days > 0) {
      dateInfos
          .add(DateInfo(value: days, label: AppStrings.profile.days(days)));
    }

    dateInfos
        .add(DateInfo(value: hours, label: AppStrings.profile.hours(hours)));

    dateInfos.add(
      DateInfo(value: minutes, label: AppStrings.profile.minutes(minutes)),
    );

    return dateInfos;
  }
}
