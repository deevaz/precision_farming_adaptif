import 'package:get/get.dart';

abstract class AppLocalizations {
  AppLocalizations._();

  // --- AUTH & LOGIN ---
  static String login() => 'login'.tr;
  static String register() => 'register'.tr;
  static String registerAccount() => 'register-account'.tr;
  static String email() => 'email'.tr;
  static String password() => 'password'.tr;
  static String username() => 'username'.tr;
  static String forgotPassword() => 'forgot-password'.tr;
  static String forgotPasswordQuestion() => 'forgot-password?'.tr;
  static String resetPassword() => 'reset-password'.tr;
  static String confirmPassword() => 'confirm-password'.tr;
  static String changePassword() => 'change-password'.tr;
  static String oldPassword() => 'old-password'.tr;
  static String newPassword() => 'new-password'.tr;
  static String invalidCredentials() => 'invalid-credentials'.tr;
  static String deskripsiJudul() => 'deskripsi-judul'.tr;
  static String deksripsiKetentuan() => 'deksripsi-ketentuan'.tr;
  static String deskripsiLogin() => 'deskripsi-login'.tr;

  // --- PRODUCT & INVENTORY ---
  static String product() => 'product'.tr;
  static String productName() => 'product-name'.tr;
  static String productDetail() => 'product-detail'.tr;
  static String item() => 'item'.tr;
  static String itemName() => 'item-name'.tr;
  static String itemCode() => 'item-code'.tr;
  static String category() => 'category'.tr;
  static String allCategory() => 'all-category'.tr;
  static String stock() => 'stock'.tr;
  static String initialStock() => 'initial-stock'.tr;
  static String totalStock() => 'total-stock'.tr;
  static String stockIn() => 'stock-in'.tr;
  static String stockOut() => 'stock-out'.tr;
  static String purchasePrice() => 'purchase-price'.tr;
  static String sellingPrice() => 'selling-price'.tr;
  static String retailPrice() => 'retail-price'.tr;
  static String buyPrice() => 'buy-price'.tr;
  static String sellPrice() => 'sell-price'.tr;
  static String profit() => 'profit'.tr;
  static String expired() => 'expired'.tr;

  // --- SUPPLIER & BUYER ---
  static String supplier() => 'supplier'.tr;
  static String supplierName() => 'supplier-name'.tr;
  static String addSupplier() => 'add-supplier'.tr;
  static String buyer() => 'buyer'.tr;
  static String customer() => 'customer'.tr;
  static String selectBuyer() => 'select-buyer'.tr;

  // --- HISTORY & DATA ---
  static String history() => 'history'.tr;
  static String historyDetail() => 'history-detail'.tr;
  static String entryDate() => 'entry-date'.tr;
  static String exitDate() => 'exit-date'.tr;
  static String totalData() => 'total-data'.tr;
  static String totalPrice() => 'total-price'.tr;
  static String note() => 'note'.tr;
  static String search() => 'search'.tr;

  // --- PROFILE & SETTINGS ---
  static String profile() => 'profile'.tr;
  static String editProfile() => 'edit-profile'.tr;
  static String accountName() => 'account-name'.tr;
  static String bankAccount() => 'bank-account'.tr;
  static String setting() => 'setting'.tr;
  static String changeLanguage() => 'change-language'.tr;
  static String logout() => 'logout'.tr;
  static String helpCenter() => 'help-center'.tr;
  static String bugReport() => 'send-bug-report'.tr;

  // --- BUTTONS & ACTIONS ---
  static String save() => 'save'.tr;
  static String edit() => 'edit'.tr;
  static String delete() => 'delete'.tr;
  static String cancel() => 'cancel'.tr;
  static String close() => 'close'.tr;
  static String send() => 'send'.tr;
  static String yes() => 'yes'.tr;
  static String no() => 'no'.tr;
  static String printPdf() => 'print-pdf'.tr;
  static String addPicture() => 'add-picture'.tr;

  // --- REFRESHER (Header & Footer) ---
  static String pullToRefresh() => 'pull_to_refresh'.tr;
  static String releaseToRefresh() => 'release_to_refresh'.tr;
  static String refreshing() => 'refreshing'.tr;
  static String refreshCompleted() => 'refresh_completed'.tr;
  static String releaseToLoadMore() => 'release_to_load'.tr;
  static String pullToLoadMore() => 'pull_to_load'.tr;
  static String refreshFailed() => 'refresh_failed'.tr;
  static String pullToLoad() => 'pull_to_load'.tr;
  static String loadFailed() => 'load_failed'.tr;
  static String loading() => 'loading'.tr;
  static String noMoreData() => 'no_more_data'.tr;

  // --- STATUS & MESSAGES ---
  static String success() => 'success'.tr;
  static String failed() => 'failed'.tr;
  static String error() => 'error'.tr;
  static String empty() => 'empty'.tr;
  static String itemSaved() => 'item-saved'.tr;
  static String loginSuccess() => 'login-success'.tr;
  static String logoutSuccess() => 'logout-success'.tr;
  static String pleaseWait() => 'please-wait'.tr;

  // --- CALENDAR & CHART ---
  static String selectDateRange() => 'select-date-range'.tr;
  static String today() => 'today'.tr;
  static String yesterday() => 'yesterday'.tr;
  static String thisMonth() => 'this-month'.tr;
  static String stockInOutChart() => 'stock-in-out-chart'.tr;

  // --- SHOWCASE ---
  static String showcaseFilterTitle() => 'showcase-filter-title'.tr;
  static String showcaseFilter() => 'showcase-filter'.tr;
  static String showcaseInfoTitle() => 'showcase-info-title'.tr;
  static String showcaseStockInTitle() => 'showcase-stock-in-title'.tr;
}
