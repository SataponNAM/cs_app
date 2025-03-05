import 'package:flutter/material.dart';
import 'package:flutter_app/models/news_model.dart';
import 'package:flutter_app/pages/news/news_detail_page.dart';
import 'package:flutter_app/services/http_service.dart';
import 'package:intl/intl.dart';

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
          return Center(
            child: CircularProgressIndicator(
              color: Colors.deepPurple[500],
            ),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline,
                  color: Colors.red,
                  size: 80,
                ),
                const SizedBox(height: 16),
                Text(
                  "Error loading news",
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 18,
                  ),
                ),
                Text(
                  "${snapshot.error}",
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.newspaper,
                  color: Colors.grey[400],
                  size: 80,
                ),
                const SizedBox(height: 16),
                Text(
                  "No news available",
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          );
        } else {
          List<News> newsList = snapshot.data!;

          return RefreshIndicator(
            color: Colors.deepPurple[500],
            onRefresh: () async {
              setState(() {
                futureNews = httpService.fetchNews(strUrl: baseUrl);
              });
            },
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: _buildHeaderImage(),
                ),
                ..._buildNewsSections(newsList),
              ],
            ),
          );
        }
      },
    );
  }

  // รูป banner
  Widget _buildHeaderImage() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Image.network(
          'http://202.44.40.179/Data_From_Chiab/Image/img/welcome-cis.jpg',
          fit: BoxFit.fitWidth,
          width: double.infinity,
          height: 200,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Center(
              child: CircularProgressIndicator(
                color: Colors.deepPurple[500],
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                    : null,
              ),
            );
          },
          errorBuilder: (context, error, stackTrace) => Container(
            color: Colors.grey[200],
            child: Icon(
              Icons.image_not_supported,
              color: Colors.grey[600],
              size: 80,
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildNewsSections(List<News> newsList) {
    Map<String, List<News>> categorizedNews = {};

    for (var item in newsList) {
      String type = item.type ?? 'Uncategorized';
      if (type == '0') continue;
      if (!categorizedNews.containsKey(type)) {
        categorizedNews[type] = [];
      }
      categorizedNews[type]!.add(item);
    }

    List<Widget> sections = [];
    categorizedNews.forEach((type, items) {
      sections.add(SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            type,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple[700],
            ),
          ),
        ),
      ));

      sections.add(
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => _buildNewsItem(items[index]),
            childCount: items.take(3).length,
          ),
        ),
      );
    });

    return sections;
  }

  Widget _buildNewsItem(News item) {
    return FutureBuilder<List<String>>(
      future: httpService.fetchImageList(item.img_url),
      builder: (context, snapshot) {
        String imageUrl = snapshot.hasData && snapshot.data!.isNotEmpty
            ? '${item.img_url}/${snapshot.data![0]}'
            : '';

        DateTime postDate = DateFormat('dd/MM/yyyy').parse(item.PostDate);
        String formattedDate = DateFormat('d MMMM yyyy', 'th').format(postDate);
        int thaiYear = postDate.year + 543;
        String thaiFormattedDate = formattedDate.replaceFirst(
            postDate.year.toString(), thaiYear.toString());

        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NewsDetailPage(
                  newsItem: item,
                  imageName: (snapshot.data ?? []).cast<String>(),
                ),
              ),
            );
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    bottomLeft: Radius.circular(15),
                  ),
                  child: imageUrl.isNotEmpty
                      ? Image.network(
                          imageUrl,
                          width: 120,
                          height: 120,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.image_not_supported),
                        )
                      : Container(
                          width: 120,
                          height: 120,
                          color: Colors.grey[200],
                          child: Icon(
                            Icons.image_not_supported,
                            color: Colors.grey[600],
                          ),
                        ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.Title,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.deepPurple[800],
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          thaiFormattedDate,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}