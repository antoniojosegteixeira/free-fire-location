class FileName {
  static String getFileName() {
    final date = DateTime.now().toUtc();
    String year = date.year.toString();
    String month = date.month.toString().padLeft(2, '0');
    String day = date.day.toString().padLeft(2, '0');
    String hour = date.hour.toString().padLeft(2, '0');
    String minute = (date.minute / 10).floor().toString();

    //focos_abertos_20220608_092000.csv	2022-06-08 09:19	24K
    final String fileName =
        "focos_abertos_$year$month$day" "_" "$hour$minute" "000.csv";
    return fileName;
  }
}
