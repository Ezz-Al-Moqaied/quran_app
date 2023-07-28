import 'package:flutter/material.dart';
import 'package:quran_application/HomePage.dart';
import 'package:quran_application/apiFetch.dart';
import 'package:quran/quran.dart' as Quran;

class SearchBar extends SearchDelegate {
  QuranApi quran = QuranApi();

  Future<void> fetchData() async {
    await quran.fetchData();
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = "";
        },
        icon: const Icon(
          Icons.close,
          size: 14,
        ),
        splashRadius: 10,
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(
        Icons.arrow_back,
      ),
      splashRadius: 20,
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    fetchData();
    List surah = quran.ayahs;
    List filter = surah.where((element) => element.contains(query)).toList();
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
          color: Colors.white,
          gradient:
          LinearGradient(colors: [Color(0xffd6c08e), Color(0xffe5dabc)])),
      child: ListView.builder(
          itemCount: query == '' ? surah.length : filter.length,
          itemBuilder: (context, index) {
            return InkWell(
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) {
                        return HomePage(
                            getPageNum: Quran.getSurahPages(index + 1).first - 1);
                      }));
                },
                child: Center(
                  child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 8),
                      child: Text(
                          query == '' ? surah.elementAt(index) : filter[index],
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ))),
                ));
          }),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    throw UnimplementedError();
  }
}
