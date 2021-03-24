import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:omnivent_app_wireframe/omnivent_state_managment/domain/storage/secure_storage.dart';
import 'package:omnivent_app_wireframe/omnivent_state_managment/presentation/login/login_screen.dart';

import 'package:omnivent_app_wireframe/omnivent_state_managment/presentation/slideshow/slideshow_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    final secure = SecureStorage();
    final almacenamiento = secure.crearAlmacenamiento();
    almacenamiento.read(key: 'slider').then((s) {
      if (s == null || s.isEmpty) {
        Future.delayed(const Duration(milliseconds: 3000), () {
          Navigator.of(context).pushReplacement(
              CupertinoPageRoute(builder: (_) => SlideshowScreen()));
        });
      }else{
        Future.delayed(const Duration(milliseconds: 3000), () {
          Navigator.of(context).pushReplacement(
              CupertinoPageRoute(builder: (_) => LoginScreen()));
        });
      }
      super.initState();
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          'assets/logo/logo_omnivent.png',
          width: size.width,
        ),
        Text(
          'Version 1.0.0',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
        )
      ],
    ));
  }
}
