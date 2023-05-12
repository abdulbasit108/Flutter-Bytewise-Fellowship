import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import '../model/article_model.dart';
import '../utils/api_service.dart';
import '../utils/custom_list_tile.dart';

class NewsFeed extends StatefulWidget {
  @override
  _NewsFeedState createState() => _NewsFeedState();
}

class _NewsFeedState extends State<NewsFeed> {
  ApiService client = ApiService();

  Future<void> _handleRefresh() async {
    await Future.delayed(Duration(seconds: 2));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("News Feed"),
        backgroundColor: Color.fromRGBO(145, 131, 222, 1),
      ),
      body: FutureBuilder(
        future: client.getArticle(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text('');
          }

          List<Article> articles = snapshot.data!;
          return LiquidPullToRefresh(
            onRefresh: _handleRefresh,
            color: Color.fromRGBO(145, 131, 222, 1),
            height: 200,
            animSpeedFactor: 2,
            showChildOpacityTransition: false,
            child: ListView.builder(
              itemCount: articles.length,
              itemBuilder: (context, index) =>
                  customListTile(articles[index], context),
            ),
          );
        },
      ),
    );
  }
}
