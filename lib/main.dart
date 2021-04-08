import 'package:flutter/material.dart';
import 'ws.dart';

void main() {
  var ws = new MasterWebsocketHandler();
  ws.connect();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final title = 'WebSocket Demo';

    return MaterialApp(
      title: title,
      home: Center(
        child: Text('hello'),
      ),
    );
  }
}
