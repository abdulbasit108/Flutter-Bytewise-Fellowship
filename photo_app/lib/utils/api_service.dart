import 'dart:convert';
import 'package:http/http.dart';

import '../model/article_model.dart';

class ApiService {
  final endPointUrl =
      "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=8cb00b6a6786476dbc6ee8a08bc8222e";

  Future<List<Article>> getArticle() async {
    Response res = await get(Uri.parse(endPointUrl));

    Map<String, dynamic> json = jsonDecode(res.body);

    List<dynamic> body = json['articles'];

    List<Article> articles =
        body.map((dynamic item) => Article.fromJson(item)).toList();

    return articles;
  }
}
