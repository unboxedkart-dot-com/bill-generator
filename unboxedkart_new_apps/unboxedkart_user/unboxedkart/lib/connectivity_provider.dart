// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:flutter/cupertino.dart';

// class ConnectivityProvider with ChangeNotifier {
//   bool _isOnline;
//   bool get isOnline => _isOnline;

//   ConnectivityProvider() {
//     Connectivity _connectivity = Connectivity();

//     _connectivity.onConnectivityChanged.listen((result) async {
//       if (result == ConnectivityResult.none) {
//         _isOnline = false;
//         notifyListeners();
//       } else {
//         _isOnline = true;
//         notifyListeners();
//       }
//     });
//   }
// }
