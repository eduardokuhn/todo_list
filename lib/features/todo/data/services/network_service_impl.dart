import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:injectable/injectable.dart';

enum NetworkStatus { offline, online }

abstract class INetworkService {
  late NetworkStatus networkStatus;
}

@Singleton(as: INetworkService)
class NetworkServiceImpl implements INetworkService {
  @override
  NetworkStatus networkStatus = NetworkStatus.offline;

  final StreamController<NetworkStatus> _networkStatusController =
      StreamController<NetworkStatus>();

  NetworkServiceImpl() {
    _init();

    Connectivity().onConnectivityChanged.listen((status) {
      networkStatus = _getNetworkStatus(status);
      _networkStatusController.add(_getNetworkStatus(status));
    });
  }

  void _init() {
    Connectivity()
        .checkConnectivity()
        .then((value) => networkStatus = _getNetworkStatus(value));
  }

  NetworkStatus _getNetworkStatus(ConnectivityResult status) {
    return status == ConnectivityResult.mobile ||
            status == ConnectivityResult.wifi
        ? NetworkStatus.online
        : NetworkStatus.offline;
  }
}
