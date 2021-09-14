import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_bloc_ui/src/domain/models/usecase.dart';
import 'package:firebase_bloc_ui/src/domain/usecases/disable_network.dart';
import 'package:firebase_bloc_ui/src/domain/usecases/enable_network.dart';

class NetworkImpl {
  final EnableNetwork enableNetwork;
  final DisableNetwork disableNetwork;

  NetworkImpl({
    required this.enableNetwork,
    required this.disableNetwork,
  });

  void listenNetworkChanges() {
    Connectivity().onConnectivityChanged.listen((event) {
      if (event == ConnectivityResult.none) {
        disableNetwork.call(NoParams());
      } else {
        enableNetwork.call(NoParams());
      }
    });
  }
}
