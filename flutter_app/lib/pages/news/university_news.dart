import 'package:flutter/material.dart';
import 'package:flutter_app/models/news_model.dart';
import 'package:flutter_app/pages/news/news_detail_page.dart';
import 'package:flutter_app/services/news_service.dart';
import 'package:intl/intl.dart';

class UniversityNews extends StatefulWidget {
  const UniversityNews({super.key});

  @override
  State<UniversityNews> createState() => _UniversityNewsState();
}

class _UniversityNewsState extends State<UniversityNews> {
  final HttpService httpService = HttpService();
  static const String baseUrl = 'http://202.44.40.179:3000/posts';

  late Future<List<News>> futureNews;

  @override
  void initState() {
    super.initState();
    futureNews = httpService.fetchNews(strUrl: baseUrl).then((newsList) {
      return newsList.where((news) => news.type == "ข่าวคณะและมหาวิทยาลัย").toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.deepPurple.shade800),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'ข่าวคณะและมหาวิทยาลัย',
          style: TextStyle(
            color: Colors.deepPurple.shade800,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<List<News>>(
        future: futureNews,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No news available'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return _buildNewsItem(snapshot.data![index]);
              },
            );
          }
        },
      ),
    );
  }

  Widget _buildNewsItem(News item) {
    // แปลงวันที่
    DateTime postDate = DateFormat('dd/MM/yyyy').parse(item.PostDate);
    String formattedDate = DateFormat('d MMMM yyyy', 'th').format(postDate);
    int thaiYear = postDate.year + 543; // Convert to Thai year (Buddhist Era)
    String thaiFormattedDate = formattedDate.replaceFirst(postDate.year.toString(), thaiYear.toString());
    
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
                          thaiFormattedDate,
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