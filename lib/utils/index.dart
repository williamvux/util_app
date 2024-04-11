String secondsToHms({required int seconds}) {
  return '${(Duration(seconds: seconds))}'.split('.')[0].padLeft(8, '0');
}
