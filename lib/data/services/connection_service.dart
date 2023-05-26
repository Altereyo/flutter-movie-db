import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

class ConnectionService extends GetxService {
  StreamSubscription<ConnectivityResult>? connectionStreamSubscription;

  Future<void> initConnectionListener() async {
    // we are not disposing listener anywhere, because it should work always, but we have method in service to do this
    connectionStreamSubscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) async {
      final bool connectionExists = (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.ethernet ||
          result == ConnectivityResult.wifi ||
          result == ConnectivityResult.vpn);

      if (connectionExists && Get.currentRoute == '/connection_error') {
        // TODO go back from /connection_error
      } else if (!connectionExists && Get.currentRoute != '/connection_error'){
        // TODO go to /connection_error
      }
    });
  }

  void disposeConnectionListener() {
    if (connectionStreamSubscription != null) connectionStreamSubscription!.cancel();
  }
}
