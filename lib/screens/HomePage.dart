import 'package:arabic_numbers/arabic_numbers.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:quran_application/module/quran.dart';
import 'package:quran_application/serives/shared_preferences.dart';
import '../serives/apiFetch.dart';
import 'package:quran/quran.dart' as Quran;

class HomePage extends StatefulWidget {
  late int getPageNum;

  HomePage({required this.getPageNum});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  QuranModule quran = QuranModule();
  QuranApi api = QuranApi();
  late int pageNumber = 0;
  bool isLoading = true;

  savePage(int pageNumber) async {
    await SharedPreferencesHelper.setPageNumber(pageNumber);
  }

  getPageNumber() {
    widget.getPageNum = SharedPreferencesHelper.getPageNumber;
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getPageNumber();
    api.fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 126, 113, 82),
            title: const Text("Quran"),
            toolbarHeight: 50,
            centerTitle: true,
            actions: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      elevation: 0, backgroundColor: Colors.transparent),
                  onPressed: () async {
                    await SharedPreferencesHelper.setPageNumber(pageNumber);
                  },
                  child: const Icon(Icons.bookmark_add_outlined)),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      elevation: 0, backgroundColor: Colors.transparent),
                  onPressed: () async {
                    SharedPreferencesHelper.getPageNumber;
                    int save = SharedPreferencesHelper.getPageNumber;
                    if (save == 0) {
                      print('save is null');
                    } else {
                      Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) {
                          return HomePage(
                            getPageNum: save - 1,
                          );
                        },
                      ));
                    }
                  },
                  child: const Icon(Icons.bookmark_sharp)),
            ],
          ),
          body: PageView.builder(
              scrollBehavior: const MaterialScrollBehavior(),
              controller: PageController(initialPage: widget.getPageNum),
              reverse: true,
              itemCount: 604,
              itemBuilder: (context, index) {
                pageNumber = index + 1;
                return Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                    index % 2 == 0
                        ? const Color(0xffd6c08e)
                        : const Color(0xffe5dabc),
                    index % 2 == 0
                        ? const Color(0xffe5dabc)
                        : const Color(0xffd6c08e)
                  ])),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 3,
                      ),
                      index % 2 == 1
                          ? Container(
                              width: 2,
                              color: Colors.black,
                            )
                          : Container(),
                      const SizedBox(
                        width: 2,
                      ),
                      index % 2 == 1
                          ? Container(
                              width: 1,
                              color: Colors.black,
                            )
                          : Container(),
                      const SizedBox(
                        width: 2,
                      ),
                      index % 2 == 1
                          ? Container(
                              width: 0.5,
                              color: Colors.black,
                            )
                          : Container(),
                      Expanded(
                        child: Column(
                          children: [
                            Expanded(
                              child: PhotoView(
                                backgroundDecoration: const BoxDecoration(
                                    color: Colors.transparent),
                                imageProvider: AssetImage(
                                  quran.QuranPages(pageNumber),
                                ),
                              ),
                            ),
                            Text(
                              ArabicNumbers().convert(pageNumber),
                              style: const TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      index % 2 == 0
                          ? Container(
                              width: 0.5,
                              color: Colors.black,
                            )
                          : Container(),
                      const SizedBox(
                        width: 2,
                      ),
                      index % 2 == 0
                          ? Container(
                              width: 1,
                              color: Colors.black,
                            )
                          : Container(),
                      const SizedBox(
                        width: 2,
                      ),
                      index % 2 == 0
                          ? Container(
                              width: 2,
                              color: Colors.black,
                            )
                          : Container(),
                    ],
                  ),
                );
              })),
    );
  }
}

class SearchBar extends SearchDelegate {
  QuranApi q = QuranApi();

  Future<void> g() async {
    await q.fetchData();
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
    return Container(
        decoration: const BoxDecoration(
            gradient:
                LinearGradient(colors: [Color(0xffd6c08e), Color(0xffe5dabc)])),
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 15,
            ),
            Text(
              query,
            ),
          ],
        ));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    g();
    List surah = q.pageAyah;
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
                    print(Quran.getSurahPages(index + 1).first.toInt());
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
}
