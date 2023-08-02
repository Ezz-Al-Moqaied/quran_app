import 'package:flutter/material.dart';
import 'package:quran_application/screens/HomePage.dart';
import 'package:quran_application/serives/shared_preferences.dart';

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
