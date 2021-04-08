import 'dart:convert';
import 'dart:io';

import 'package:web_socket_channel/io.dart';

class MasterWebsocketHandler {
  static final MasterWebsocketHandler _singleton =
      new MasterWebsocketHandler._internal();

  static WebSocket websocketInstance;
  static IOWebSocketChannel websocketChannel;

  factory MasterWebsocketHandler() {
    return _singleton;
  }

  MasterWebsocketHandler._internal();

  connect() async {
    websocketInstance = await WebSocket.connect("ws://localhost:3000/");
    websocketChannel = IOWebSocketChannel(websocketInstance);
    websocketChannel.sink.add('TEST|INFO|' + jsonEncode({"hey": "hello"}));
    websocketChannel.stream.listen((event) {
      print(event);
    });
  }
}
