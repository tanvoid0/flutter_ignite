import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_ignite/utils/pen.dart';
import 'package:get/get.dart';

class ConnectivityService extends GetxService {
  StreamSubscription<List<ConnectivityResult>>? subscription;
  final connected = false.obs;

  ConnectivityService() {
    // TODO: _subscribe();
  }

  _subscribe() {
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> connectivityResult) async {
      // This condition is for demo purposes only to explain every connection type.
      // Use conditions which work for your requirements.
      if (connectivityResult.contains(ConnectivityResult.mobile) ||
          // Mobile network available.
          connectivityResult.contains(ConnectivityResult.wifi) ||
          // Wi-fi is available.
          // Note for Android:
          // When both mobile and Wi-Fi are turned on system will return Wi-Fi only as active network type
          connectivityResult.contains(ConnectivityResult.ethernet) ||
          // Ethernet connection available.
          connectivityResult.contains(ConnectivityResult.vpn)) {
        // Vpn connection active.
        // Note for iOS and macOS:
        // There is no separate network interface type for [vpn].
        // It returns [other] on any device (also simulator)
        // Get.snackbar("Internet Available", "Connection has been established");
        Pen.write("Internet connected");
        connected(true);
      } else if (connectivityResult.contains(ConnectivityResult.bluetooth)) {
        // Bluetooth connection available.
      } else if (connectivityResult.contains(ConnectivityResult.other)) {
        // Connected to a network which is not in the above mentioned networks.
      } else if (connectivityResult.contains(ConnectivityResult.none)) {
        // No available network types
        Pen.write("Internet disconnected");
        connected(false);
        Get.snackbar("No Internet Connection", "Please reconnect");
      }
    });
  }

  initConnection() async {
    final res = await Connectivity().checkConnectivity();
    connected((res.contains(ConnectivityResult.none)) &&
        (!res.contains(ConnectivityResult.bluetooth)));
  }

  @override
  void onClose() {
    subscription?.cancel();
  }
}
