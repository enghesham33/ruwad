class AppAssets {
  // =================== APP images ===============//
  static final String APP_ICON = 'quran.png'.imagesPath;
  static final String NO_DATA = 'empty.png'.imagesPath;
}

extension on String{
  String get imagesPath => "assets/images/$this";
}