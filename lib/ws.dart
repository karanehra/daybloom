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

  getChannel() {
    return websocketChannel;
  }

  getStream() {
    return websocketChannel.stream;
  }

  connect() async {
    if (websocketChannel == null) {
      websocketInstance = await WebSocket.connect("ws://localhost:3000/");
      websocketChannel = IOWebSocketChannel(websocketInstance);
    }
  }

  send(dynamic object) {
    websocketChannel.sink.add(jsonEncode(object));
  }
}
