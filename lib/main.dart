import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otp_page/views/numbers_screen.dart';
import 'package:otp_page/views/otp_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'OTP Demo',
      themeMode: ThemeMode.system,
      theme: ThemeData(primarySwatch: Colors.blue),
      darkTheme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => FirstPage()),
      ],
    );
  }
}

