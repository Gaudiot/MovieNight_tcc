String intToRuntime(int runtime) {
  return "${runtime ~/ 60}h${(runtime % 60).toString().padLeft(2, '0')}m";
}

String dateTimeToYear(DateTime date) {
  return date.year.toString();
}
