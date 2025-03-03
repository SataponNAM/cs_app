import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_app/pages/news/news_detail_page.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> news = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchNews();
  }

  Future<void> fetchNews() async {
    final url = Uri.parse('http://202.44.40.179:3000/posts');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        setState(() {
          news = jsonDecode(response.body);
          isLoading = false;
        });
      } else {
        print('Failed to load news: ${response.body}');
        setState(() => isLoading = false);
      }
    } catch (e) {
      print('Error fetching news: $e');
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    Container(
                      padding: EdgeInsets.all(15),
                        child: Image.network(
                            'http://202.44.40.179/Data_From_Chiab/Image/img/welcome-cis.jpg')
                    ),
                    ..._buildNewsSections()
                  ],
                ),
              ),
            ],
          );
  }

  List<Widget> _buildNewsSections() {
    Map<String, List<dynamic>> categorizedNews = {};

    for (var item in news) {
      String type = item['type'] ?? 'Uncategorized';
      if (type == '0') continue; // Skip items with type '0'
      if (!categorizedNews.containsKey(type)) {
        categorizedNews[type] = [];
      }
      categorizedNews[type]!.add(item);
    }

    List<Widget> sections = [];
    categorizedNews.forEach((type, items) {
      sections.add(Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          type,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ));
      sections
          .addAll(items.take(3).map((item) => _buildNewsItem(item)).toList());
    });

    return sections;
  }

  Widget _buildNewsItem(dynamic item) {
    String baseUrl = item['img_url'] ?? '';

    return FutureBuilder<List<String>>(
      future: fetchImageList(baseUrl),
      builder: (context, snapshot) {
        List<String>? imageName = snapshot.data;
        String? imageUrl = (imageName != null && imageName.isNotEmpty)
            ? baseUrl + '/' + imageName[0]
            : null; // ไม่มีรูปก็ไม่แสดง

        return Container(
          //height: 150,
          padding: EdgeInsets.only(top: 10, bottom: 10),
          child: Center(
            child: ListTile(
              leading: imageUrl != null
                  ? Image.network(
                      imageUrl,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.image_not_supported),
                    )
                  : const SizedBox(
                      width: 100, height: 100), // ถ้าไม่มีรูป ให้เว้นที่ว่าง
              title: Text(
                item['Title'] ?? 'No Title',
                style: const TextStyle(fontSize: 16),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NewsDetailPage(
                              newsItem: item,
                              imageName: imageName ?? [],
                            )));
              },
            ),
          ),
        );
      },
    );
  }

  Future<List<String>> fetchImageList(String baseUrl) async {
    if (baseUrl.isEmpty) return []; // ถ้าไม่มี URL, ไม่ต้องโหลดอะไรเลย

    try {
      final response = await http.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
        var document = parse(response.body);
        List<String> fileNames = [];

        document.querySelectorAll('a').forEach((element) {
          String? href = element.attributes['href'];

          if (href != null && RegExp(r'\.(png|jpg|jpeg)$').hasMatch(href)) {
            fileNames.add(href);
          }
        });

        return fileNames.isNotEmpty
            ? fileNames
            : []; // ไม่มีรูปให้คืนค่าเป็น `''`
      } else {
        print('Error: HTTP ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Error fetching image list: $e');
      return [];
    }
  }
}
