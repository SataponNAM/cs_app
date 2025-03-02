import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class NewsDetailPage extends StatefulWidget {
  final dynamic newsItem;
  final List<String> imageName;

  const NewsDetailPage(
      {super.key, required this.newsItem, required this.imageName});

  @override
  State<NewsDetailPage> createState() => _NewsDetailPageState();
}

class _NewsDetailPageState extends State<NewsDetailPage> {
  List<String> imgUrl = [];

  @override
  void initState() {
    super.initState();
    getImageUrl();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              if (imgUrl.isNotEmpty)
                imgUrl.length == 1
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          imgUrl.first,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      )
                    : CarouselSlider(
                        options: CarouselOptions(
                          height: 200.0,
                          autoPlay: true,
                          enlargeCenterPage: true,
                        ),
                        items: imgUrl.map((url) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              url,
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          );
                        }).toList(),
                      ),
              const SizedBox(height: 20),
              Text(
                widget.newsItem['Title'] ?? 'No Title',
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Text(
                widget.newsItem['Message'] ?? 'No Content',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> getImageUrl() async {
    print("get img url");
    for (String imgName in widget.imageName) {
      var imgurl = widget.newsItem['img_url'] + '/' + imgName;

      //print(imgurl);
      imgUrl.add(imgurl);
    }
  }
}
