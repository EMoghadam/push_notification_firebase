import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:pushmessage/page2.dart';
import 'package:pushmessage/services/local_notif.dart';

Future<void> backgroundHandeler(RemoteMessage message) async {
  print(message.notification!.title);
  print(message.notification!.body);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseMessaging.onBackgroundMessage(backgroundHandeler);
  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SafeArea(child: MyHomePage()),
  ));
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    NotificationServices.initialitz(context);
    onMessage();
    onMessageOpened();
    onMessageWhenAppClose();
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      final gotopage = message!.data["route"];
      if (gotopage == "goto") {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return Page2();
        }));
      }
    });
  }

  onMessageWhenAppClose() async {}

  onMessage() async {
    await FirebaseMessaging.instance.getInitialMessage();
    //app open
    await FirebaseMessaging.onMessage.listen((message) {
      print(message.notification!.title);
      print(message.notification!.body);
      NotificationServices.disply(message);
    });
  }

  //app open in background
  onMessageOpened() async {
    await FirebaseMessaging.instance.getInitialMessage();
    await FirebaseMessaging.onMessageOpenedApp.listen((message) {
      final gotopage = message.data["route"];
      print(gotopage);
      if (gotopage == "goto") {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return Page2();
        }));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.amber,
        alignment: Alignment.center,
        child: const Text(
          "Home Page",
          style: TextStyle(fontSize: 30, color: Colors.black87),
        ),
      ),
    ));
  }
}
