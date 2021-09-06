import 'dart:math';

import 'package:behtarino/Common/Extentions/StringExtentions.dart';
import 'package:behtarino/Common/Helper/LocalStorage.dart';
import 'package:behtarino/Common/Helper/Msacontext.dart';
import 'package:behtarino/Common/Socket/MqttServer.dart';
import 'package:behtarino/Common/Widgets/Appbar.dart';
import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class Chat extends StatefulWidget {
  const Chat({Key? key, this.token}) : super(key: key);
  final String? token;
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  mttq m = mttq();
  MqttServerClient? client;
  @override
  void initState() {
    super.initState();
    (() async {
      client = await m.mainMqtt();
      var mytoken = await localStorageGet("Token");
      var topic = 'challenge/user/${widget.token}/${mytoken}/';

      client!.subscribe(topic, MqttQos.atMostOnce);
      client!.updates!.listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
        final recMess = c![0].payload as MqttPublishMessage;
        final pt =
            MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
        recievemessage(pt);
      });
    }());
  }

  void publishMessage(String message, {String? OtpToken, String? USER_TOKEN}) {
    // var topic = 'challenge/user/${USER_TOKEN}/${OtpToken}/';

    // client.subscribe(topic, MqttQos.atMostOnce);
    final MqttClientPayloadBuilder builder = MqttClientPayloadBuilder();
    builder.addString(message);
    client!.publishMessage('challenge/user/${USER_TOKEN}/${OtpToken}/',
        MqttQos.exactlyOnce, builder.payload!);
  }

  var rng = new Random();
  List<Widget> messages = [];
  void recievemessage(String message, {bool? mymessage}) {
    var index = rng.nextDouble();
    messages.add(
      Padding(
        key: Key(index.toString()),
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onLongPress: () {
            messages.remove(
                messages.firstWhere((x) => x.key == Key(index.toString())));
            setState(() {});
          },
          child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              alignment: Alignment.centerLeft,
              width: MediaQuery.of(context).size.width / 2,
              decoration: BoxDecoration(
                  color: Colors.blue[100],
                  border: Border.all(
                      color: Colors.white, // Set border color
                      width: 3.0), // Set border width
                  borderRadius: BorderRadius.all(
                      Radius.circular(10.0)), // Set rounded corner radius
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 10,
                        color: Colors.black,
                        offset: Offset(1, 3))
                  ] // Make rounded corner of border
                  ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(message),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
    setState(() {});
  }

  void sendmessage(String message) {
    var index = rng.nextDouble();
    messages.add(
      Padding(
        key: Key(index.toString()),
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onLongPress: () {
            messages.remove(
                messages.firstWhere((x) => x.key == Key(index.toString())));
            setState(() {});
          },
          child: Align(
            alignment: Alignment.centerRight,
            child: Container(
              alignment: Alignment.centerRight,
              width: MediaQuery.of(context).size.width / 2,
              decoration: BoxDecoration(
                  color: Colors.blue[50],
                  border: Border.all(
                      color: Colors.white!, // Set border color
                      width: 3.0), // Set border width
                  borderRadius: BorderRadius.all(
                      Radius.circular(10.0)), // Set rounded corner radius
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 10,
                        color: Colors.black,
                        offset: Offset(1, 3))
                  ] // Make rounded corner of border
                  ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(message),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
    setState(() {});
  }

  final _chatController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MsaAppbar(
        left: IconButton(
          onPressed: () {
            Navigator.of(Msacontext()).pop();
          },
          icon: Icon(
            Icons.arrow_back,
            size: 29,
          ),
          color: Colors.white,
        ),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height - 160,
            child: SingleChildScrollView(
              child: Column(children: messages),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
              height: 60,
              width: double.infinity,
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: Colors.lightBlue,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: TextField(
                      controller: _chatController,
                      textAlign: TextAlign.right,
                      decoration: InputDecoration(
                          hintText: "پیام خود را ارسال کنید",
                          hintStyle: TextStyle(color: Colors.black54),
                          border: InputBorder.none),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      sendMessage();
                    },
                    child: Icon(
                      Icons.send,
                      color: Colors.white,
                      size: 18,
                    ),
                    backgroundColor: Colors.blue,
                    elevation: 0,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void sendMessage() async {
    if (!_chatController.text.isNullOrEmpty()) {
      var mytoken = await localStorageGet("Token");
      sendmessage(_chatController.text);
      publishMessage(_chatController.text,
          USER_TOKEN: widget.token, OtpToken: mytoken);
    }
  }
}
