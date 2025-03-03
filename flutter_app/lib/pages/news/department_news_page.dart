import 'package:flutter/material.dart';
import 'package:flutter_app/models/news_model.dart';
import 'package:flutter_app/pages/news/news_detail_page.dart';
import 'package:flutter_app/services/http_service.dart';

class DepartmentNewsPage extends StatefulWidget {
  const DepartmentNewsPage({super.key});

  @override
  State<DepartmentNewsPage> createState() => _DepartmentNewsPageState();
}

class _DepartmentNewsPageState extends State<DepartmentNewsPage> {
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
    return const Placeholder();
  }
}