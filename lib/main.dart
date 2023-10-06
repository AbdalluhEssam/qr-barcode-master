import 'dart:io';

import 'package:flutter/material.dart';
import 'package:scannerapp/screens/readqr.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'EZAttend',
      home: ScanScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late bool resultIs = false;

  checkInternet() async {
    try {
      var result = await InternetAddress.lookup("google.com");
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        resultIs = true;
      }
    } on SocketException catch (_) {
      resultIs = false;
    }
  }

  void initState() async {
    await checkInternet();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("EZAttend"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.black,
      ),
      body: resultIs == true
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (ctx) => ScanScreen()));
                        print('Read qr code');
                      },
                      child: Text('Read QR code')),
                ],
              ),
            )
          : Text("جارى الاتصال بالانترنت"),
    );
  }
}
