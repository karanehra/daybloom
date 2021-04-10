import 'package:flutter/material.dart';
import 'ws.dart';

MasterWebsocketHandler ws;

void main() async {
  ws = new MasterWebsocketHandler();
  await ws.connect();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  handleButtonPress() {
    print("click");
  }

  @override
  Widget build(BuildContext context) {
    ws.send({"hey": "hello"});
    return MaterialApp(
      home: MyHomePage(title: 'Hello', channel: ws),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  final MasterWebsocketHandler channel;

  MyHomePage({Key key, @required this.title, @required this.channel})
      : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isOnline = false;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: widget.channel.getStream(),
      builder: (context, snapshot) {
        Future.delayed(Duration.zero, () async {
          processSnapshot(snapshot);
        });

        return isOnline ? HomePage() : offlineScreen();
      },
    );
  }

  void processSnapshot(AsyncSnapshot<dynamic> snapshot) {
    setState(() {
      isOnline = snapshot.connectionState == ConnectionState.active;
    });
  }

  Widget offlineScreen() {
    return Text('You are offline');
  }

  // void _sendMessage() {
  //   if (_controller.text.isNotEmpty) {
  //     widget.channel.send(_controller.text);
  //   }
  // }

  // @override
  // void dispose() {
  //   widget.channel.sink.close();
  //   super.dispose();
  // }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ElevatedButton(
        child: Text('Hello'),
        onPressed: null,
      ),
    );
  }
}
