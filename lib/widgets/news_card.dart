import 'package:flutter/material.dart';
import 'package:news_app/models/article_model.dart';

class NewsCard extends StatelessWidget {
  final Article articulo;

  const NewsCard({Key key, this.articulo}) : super(key: key);
  @override
  Widget build(BuildContext context) {
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
