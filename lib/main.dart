import 'package:flutter/material.dart';
import 'package:quran_application/HomePage.dart';
import 'package:quran_application/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: const Locale('ar'),
      debugShowCheckedModeBanner: false,
      home: HomePage(getPageNum: SharedPreferencesHelper.getPageNumber),
    );
  }
}
