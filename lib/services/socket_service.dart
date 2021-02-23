import 'package:flutter/material.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

enum ServerStatus { Online, Offline, Conectando }

class SocketService with ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.Conectando;
  IO.Socket _socket;

  ServerStatus get serverStatus => this._serverStatus;

  IO.Socket get socket => this._socket;
  Function get emit => this._socket.emit;

  SocketService() {
    this._initConfig();
  }

  void _initConfig() {
    // Dart client
    this._socket = IO.io('http://192.168.0.13:3000/', {
      'transports': ['websocket'],
      'autoConnect': true
    });

    this._socket.on('connect', (_) {
      this._serverStatus = ServerStatus.Online;
      notifyListeners();
    });

    this._socket.on('disconnect', (_) {
      this._serverStatus = ServerStatus.Offline;
      notifyListeners();
    });

    // IO.Socket socket = IO.io('http://192.168.0.13:3000/', {
    //   'transports': ['websocket'],
    //   'autoConnect': true,
    // });
    // socket.onConnect((_) {
    //   print('connect');
    // });

    // socket.onDisconnect((_) => print('disconnect'));
  }
}
