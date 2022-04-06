import 'dart:io'; //InternetAddress utility
import 'dart:async'; //For StreamController/Stream

import 'package:connectivity/connectivity.dart';

class Connection {
  ///untuk membuat singletoon instance
  static final Connection _singleton = Connection._internal();

  ///untuk membuat singletoon instance
  Connection._internal();

  ///untuk memanggil instance yang sudah di buat
  static Connection get i => _singleton;

  ///status koneksi berubah sesuai dengan perubahan status keneksi atau pengecekan
  bool hasConnection = false;

  ///membuat instanse stream, hanya sekali dibuat
  StreamController connectionChangeController = StreamController.broadcast();

  ///stream status koneksi, bisa di gunakan untuk subsribe stream
  Stream get connectionChange => connectionChangeController.stream;

  ///peckage yang digunakan untk mengecek koneksi
  final Connectivity _connectivity = Connectivity();

  /// Digunakan sebagai inialisasi awal dan pengecekan awal
  void initialize() {
    _connectivity.onConnectivityChanged.listen(_connectionChange);
    checkConnection();
  }


  ///digunakan untuk menghapus stream yang sudah di buat
  void dispose() {
    connectionChangeController.close();
  }

  ///ubah status koneksi jika tatus koneksi di phone berubah
  void _connectionChange(ConnectivityResult result) {
    checkConnection();
  }

  ///fungsi digunakan untuk mengecek koneksi interet
  ///bisa difunakan disetiap lokasi jika intanse di panggil
  ///@authr Nur Syahfei
  ///
  /// @return bool true sebagai terkoneksid dan false sebagai tidak terkoneksi
  Future<bool> checkConnection() async {
    bool previousConnection = hasConnection;

    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        hasConnection = true;
      } else {
        hasConnection = false;
      }
    } on SocketException catch (_) {
      hasConnection = false;
    }

    if (previousConnection != hasConnection) {
      connectionChangeController.add(hasConnection);
    }

    return hasConnection;
  }
}
