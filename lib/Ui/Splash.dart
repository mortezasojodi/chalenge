import 'dart:convert';

import 'package:behtarino/Common/Extentions/StringExtentions.dart';
import 'package:behtarino/Common/Helper/LocalStorage.dart';
import 'package:behtarino/Common/Helper/Msacontext.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  bool isLogin = false;
  @override
  void initState() {
    // FlutterVpn.prepare();
    // FlutterVpn.onStateChanged.listen((s) => setState(() => state = s));
    super.initState();
    (() async {
      await checktoken();
      if (isLogin) {
        MsaNavigator(context).pushReplacementNamed("/Home");
      } else {
        MsaNavigator(context).pushReplacementNamed("/FirstLogin");
      }
    }());
  }

  Future<void> checktoken() async {
    try {
      if (await localStorageGet("Token") == null) {
        isLogin = false;
        return;
      }
      var expire = await localStorageGet("TokenExpire");

      if (DateTime.parse(expire!).isBefore(DateTime.now())) {
        isLogin = false;
      }
      isLogin = true;
    } catch (e) {
      isLogin = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
