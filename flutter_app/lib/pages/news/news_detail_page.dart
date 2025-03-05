import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:intl/intl.dart';

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
    // แปลงวันที่
    DateTime postDate = DateFormat('dd/MM/yyyy').parse(widget.newsItem.PostDate);
    String formattedDate = DateFormat('d MMMM yyyy', 'th').format(postDate);
    int thaiYear = postDate.year + 543; // Convert to Thai year (Buddhist Era)
    String thaiFormattedDate = formattedDate.replaceFirst(postDate.year.toString(), thaiYear.toString());
    
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (imgUrl.isNotEmpty)
                imgUrl.length == 1
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          imgUrl[0],
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
                widget.newsItem.Title ?? 'No Title',
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Text(
                widget.newsItem.Message ?? 'No Content',
                style: TextStyle(fontSize: 18),
              ),

              const SizedBox(height: 30),
              Row(
                children: [
                  Icon(Icons.calendar_today, color: const Color.fromARGB(255, 121, 121, 121),),
                  SizedBox(width: 10,),
                  Text(
                    thaiFormattedDate,
                    style: TextStyle(fontSize: 18, color: const Color.fromARGB(255, 121, 121, 121)),
                  ),
                ],
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> getImageUrl() async {
    print("get img url");
    print("length ${widget.imageName.length}");

    List<String> tempUrls = [];

    // ตรวจสอบว่า widget.newsItem เป็น Map หรือ Object
    String? baseImgUrl;
    if (widget.newsItem is Map) {
      baseImgUrl = widget.newsItem['img_url'];
    } else {
      baseImgUrl = widget.newsItem.img_url;
    }

    if (baseImgUrl == null || baseImgUrl.isEmpty) {
      //print("Error: img_url is null or empty");
      return;
    }

    for (String imgName in widget.imageName) {
      var imgurl = "$baseImgUrl/$imgName";
      //print("get img url: $imgurl");
      tempUrls.add(imgurl);
    }

    setState(() {
      imgUrl = tempUrls;
    });
  }
}
