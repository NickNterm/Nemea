class FiremapHelper {
  static String imageurl() {
    DateTime now = DateTime.now();
    String base = "https://civilprotection.gov.gr/sites/default/files/";
    String year = now.year.toString();
    String year2 = now.year.toString().substring(2);
    String month = now.month.toString().padLeft(2, '0');
    String day = now.day.toString().padLeft(2, '0');
    String result =
        base + year + "-" + month + "/" + year2 + month + day + ".jpg";
    return result;
  }
}
