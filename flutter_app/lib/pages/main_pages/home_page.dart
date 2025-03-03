import 'package:flutter/material.dart';
import 'package:flutter_app/models/news_model.dart';
import 'package:flutter_app/pages/news/news_detail_page.dart';
import 'package:flutter_app/services/http_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HttpService httpService = HttpService();
  static const String baseUrl = 'http://202.44.40.179:3000/posts';

  late Future<List<News>> futureNews;

  @override
  void initState() {
    super.initState();
    futureNews = httpService.fetchNews(strUrl: baseUrl);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<News>>(
      future: futureNews,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("No news available"));
        } else {
          List<News> newsList = snapshot.data!;
          
          return Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(15),
                      child: Image.network(
                        'http://202.44.40.179/Data_From_Chiab/Image/img/welcome-cis.jpg',
                      ),
                    ),
                    ..._buildNewsSections(newsList),
                  ],
                ),
              ),
            ],
          );
        }
      },
    );
  }

  List<Widget> _buildNewsSections(List<News> newsList) {
    Map<String, List<News>> categorizedNews = {};

    for (var item in newsList) {
      print(item.type);
      String type = item.type ?? 'Uncategorized';
      if (type == '0') continue;
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
      sections.addAll(items.take(3).map((item) => _buildNewsItem(item))); // เอามาแสดง 3 ข่าว
    });

    return sections;
  }

  Widget _buildNewsItem(News item) {
    return FutureBuilder<List<String>>(
      future: httpService.fetchImageList(item.img_url),
      builder: (context, snapshot) {
        String imageUrl = snapshot.hasData && snapshot.data!.isNotEmpty
            ? '${item.img_url}/${snapshot.data![0]}'
            : ''; // Set empty string if null

        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NewsDetailPage(
                    newsItem: item, imageName: (snapshot.data ?? []).cast<String>()),
              ),
            );
          },
          child: Card(
            margin: const EdgeInsets.all(10),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (imageUrl.isNotEmpty)
                    Image.network(
                      imageUrl,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.image_not_supported),
                    )
                  else
                    const Icon(Icons.image_not_supported, size: 100),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.Title,
                          style: const TextStyle(fontSize: 15),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          item.PostDate,
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
