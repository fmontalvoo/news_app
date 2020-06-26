import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:news_app/widgets/news_card.dart';
import 'package:news_app/services/news_service.dart';
import 'package:news_app/models/news_model.dart';

class Tab1Page extends StatefulWidget {
  @override
  _Tab1PageState createState() => _Tab1PageState();
}

class _Tab1PageState extends State<Tab1Page>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(context);

    return FutureBuilder(
        future: newsService.getTopHeadLines(),
        builder: (context, AsyncSnapshot<News> snapshot) {
          if (snapshot.hasData) {
            final articulos = snapshot.data.articles;
            return ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: articulos.length,
              itemBuilder: (context, index) {
                return NewsCard(articulo: articulos[index]);
              },
            );
          }
          return Center(child: CircularProgressIndicator());
        });
  }

  @override
  bool get wantKeepAlive => true;
}
