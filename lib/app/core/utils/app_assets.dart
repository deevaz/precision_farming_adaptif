abstract class AppAssets {
  AppAssets._();

  static final AppImages _images = AppImages._();
  static AppImages get images => _images;

  static final AppPngIcons _pngIcons = AppPngIcons._();
  static AppPngIcons get pngIcons => _pngIcons;

  static final AppSvgIcons _svgIcons = AppSvgIcons._();
  static AppSvgIcons get svgIcons => _svgIcons;
}

class AppImages {
  AppImages._();

  String get person => 'assets/images/img_people.png';
  String get stockIn => 'assets/images/img_stok_masuk.png';
  String get stockOut => 'assets/images/img_stok_keluar.png';
  String get supplier => 'assets/images/img_supplier.png';
  String get placeholder => 'assets/images/img_placeholder.png';
  String get feedback => 'assets/images/img_feedback.png';
}

class AppPngIcons {
  AppPngIcons._();
  String get logo => 'assets/icons/ic_barangku.png';
}

class AppSvgIcons {
  AppSvgIcons._();
  String get google => 'assets/icons/svg/ic_google.svg';
}
