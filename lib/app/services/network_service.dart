import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:kelola_barang/app/services/sync_service.dart';

class NetworkService extends GetxService {
  static NetworkService get to => Get.find<NetworkService>();

  final Connectivity _connectivity = Connectivity();
  final RxBool isConnected = true.obs;

  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  @override
  void onInit() {
    super.onInit();
    initConnectivity();
    // Get.put(SyncService(), permanent: true);
    // _connectivitySubscription = _connectivity.onConnectivityChanged.listen(
    //   _updateConnectionStatus,
    // );
  }

  Future<void> initConnectivity() async {
    late List<ConnectivityResult> result;
    try {
      result = await _connectivity.checkConnectivity();
    } catch (e) {
      debugPrint('Connectivity Error: $e');
      return;
    }
    _updateConnectionStatus(result);
  }

  void _updateConnectionStatus(List<ConnectivityResult> result) {
    bool hasConnection = !result.contains(ConnectivityResult.none);

    if (isConnected.value == hasConnection) return;

    isConnected.value = hasConnection;

    if (hasConnection) {
      debugPrint("Internet Nyala: Waktunya sinkronisasi background!");
      // Get.find<SyncService>().syncAllPendingData();
    } else {
      debugPrint("Internet Mati: Masuk mode offline.");
    }
  }

  @override
  void onClose() {
    _connectivitySubscription.cancel();
    super.onClose();
  }
}
