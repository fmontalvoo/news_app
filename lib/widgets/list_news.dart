import 'package:flutter/material.dart';
import 'package:news_app/models/article_model.dart';

import 'package:provider/provider.dart';

import 'package:news_app/models/news_model.dart';
import 'package:news_app/services/news_service.dart';

class ListNews extends StatelessWidget {
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
              return _newsCard(articulos[index]);
            },
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _newsCard(Article articulo) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                articulo.source.name,
                style: TextStyle(color: Colors.redAccent),
              )
            ],
          ),
          Text(
            articulo.title,
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700),
          ),
          SizedBox(height: 10.0),
          ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50.0),
                bottomRight: Radius.circular(50.0)),
            child: Container(
              child: articulo.urlToImage != null
                  ? FadeInImage(
                      image: NetworkImage(articulo.urlToImage),
                      placeholder: AssetImage('assets/img/giphy.gif'))
                  : Image(image: AssetImage('assets/img/no-image.png')),
            ),
          ),
          SizedBox(height: 10.0),
          Text(
            articulo.description ?? 'No description',
            style: TextStyle(fontSize: 14.0),
          ),
          SizedBox(height: 10.0),
          Divider()
        ],
      ),
    );
  }
}
