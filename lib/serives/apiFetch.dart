import 'dart:convert';

import 'package:flutter/services.dart';

class QuranApi {
  late List<dynamic> ayahs = [];
  late List<dynamic> pageAyah = [];
  late List<dynamic> pageNum = [];

  Future<List<dynamic>> fetchData() async {
    String result = await rootBundle.loadString("assets/api/data.json");
    if (result.isNotEmpty) {
      ayahs = jsonDecode(result);
      for (var i = 0; i < ayahs.length; i++) {
        pageAyah.add(ayahs[i]['sura_name_ar']);
        pageNum.add(ayahs[i]['sura_name_ar']);
      }

      return pageAyah;
    }
    return Future.error('error');
  }
}
