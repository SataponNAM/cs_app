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
    // Date formatting
    DateTime postDate =
        DateFormat('dd/MM/yyyy').parse(widget.newsItem.PostDate);
    String formattedDate = DateFormat('d MMMM yyyy', 'th').format(postDate);
    int thaiYear = postDate.year + 543;
    String thaiFormattedDate = formattedDate.replaceFirst(
        postDate.year.toString(), thaiYear.toString());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[500],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image Carousel with Padding
              Padding(
                padding: const EdgeInsets.all(16),
                child: _buildImageCarousel(),
              ),

              // Content
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      widget.newsItem.Title ?? 'No Title',
                      style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.deepPurple.shade800,
                              ),
                    ),

                    const SizedBox(height: 16),

                    // Date
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_today,
                          color: Colors.grey.shade600,
                          size: 18,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          thaiFormattedDate,
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Colors.grey.shade700,
                                  ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // Content
                    Text(
                      widget.newsItem.Message ?? 'No Content',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            height: 1.6,
                            color: Colors.grey.shade800,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageCarousel() {
    if (imgUrl.isEmpty) {
      return Container(
        height: 300,
        color: Colors.grey.shade200,
        child: Center(
          child: Icon(
            Icons.image_not_supported,
            color: Colors.grey.shade500,
            size: 50,
          ),
        ),
      );
    }

    if (imgUrl.length == 1) {
      return _buildSingleImage(imgUrl[0]);
    }

    return CarouselSlider(
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
    );
  }

  Widget _buildSingleImage(String url) {
    return Container(
      width: double.infinity,
      height: 400, // Increased height
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.network(
          url,
          fit: BoxFit.contain, // Changed to cover to fill the entire container
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Container(
              color: Colors.grey.shade200,
              child: Center(
                child: CircularProgressIndicator(
                  color: Colors.deepPurple.shade300,
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                      : null,
                ),
              ),
            );
          },
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: Colors.grey.shade200,
              child: Center(
                child: Icon(
                  Icons.error_outline,
                  color: Colors.red.shade300,
                  size: 50,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> getImageUrl() async {
    List<String> tempUrls = [];

    // Check if newsItem is Map or Object
    String? baseImgUrl;
    if (widget.newsItem is Map) {
      baseImgUrl = widget.newsItem['img_url'];
    } else {
      baseImgUrl = widget.newsItem.img_url;
    }

    if (baseImgUrl == null || baseImgUrl.isEmpty) {
      return;
    }

    for (String imgName in widget.imageName) {
      var imgurl = "$baseImgUrl/$imgName";
      tempUrls.add(imgurl);
    }

    setState(() {
      imgUrl = tempUrls;
    });
  }
}
