import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final networkServiceProvider = Provider<NetworkService>((ref) {
  final service = NetworkService();
  ref.onDispose(service.dispose);
  return service;
});

final isOnlineProvider = StreamProvider<bool>((ref) {
  final network = ref.watch(networkServiceProvider);
  return network.onConnectivityChanged.map((status) => status != ConnectivityResult.none);
});

class NetworkService {
  final Connectivity _connectivity = Connectivity();
  final _controller = StreamController<ConnectivityResult>.broadcast();

  NetworkService() {
    _connectivity.onConnectivityChanged.listen((List<ConnectivityResult> results) {
      if (results.isNotEmpty) {
        _controller.add(results.first);
      } else {
        _controller.add(ConnectivityResult.none);
      }
    });
  }

  Stream<ConnectivityResult> get onConnectivityChanged => _controller.stream;

  Future<bool> get isOnline async {
    final results = await _connectivity.checkConnectivity();
    if (results.isEmpty) return false;
    return results.first != ConnectivityResult.none;
  }

  void dispose() {
    _controller.close();
  }
}
