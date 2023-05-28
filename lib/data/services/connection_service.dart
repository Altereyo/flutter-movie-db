import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

class ConnectionService extends GetxService {
  StreamSubscription<ConnectivityResult>? connectionStreamSubscription;

  @override
  void onInit() {
    super.onInit();
    initConnectionListener();
  }

  Future<bool> isConnected () async {
    final result = await Connectivity().checkConnectivity();
    return (result == ConnectivityResult.mobile ||
        result == ConnectivityResult.ethernet ||
        result == ConnectivityResult.wifi ||
        result == ConnectivityResult.vpn);
  }

  Future<void> initConnectionListener() async {
    // we are not disposing listener anywhere, because it should work always, but we have method in service to do this
    connectionStreamSubscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) async {
      final bool isConnected = await this.isConnected();

      if (isConnected && Get.currentRoute == '/connection_error') {
        Get.offAllNamed('/home');
      } else if (!isConnected && Get.currentRoute != '/connection_error'){
        Get.toNamed('/connection_error');
      }
    });
  }

  void disposeConnectionListener() {
    if (connectionStreamSubscription != null) connectionStreamSubscription!.cancel();
  }
}
