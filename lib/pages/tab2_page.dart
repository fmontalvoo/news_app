import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:news_app/theme/theme.dart';
import 'package:news_app/widgets/news_card.dart';
import 'package:provider/provider.dart';

import 'package:news_app/models/news_model.dart';
import 'package:news_app/services/news_service.dart';

class Tab2Page extends StatefulWidget {
  @override
  _Tab2PageState createState() => _Tab2PageState();
}

class _Tab2PageState extends State<Tab2Page> {
  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            _ListaCategoria(),
            Divider(),
            Expanded(
              child: FutureBuilder(
                  future: newsService.getNewsByCategory(),
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
                  }),
            )
          ],
        ),
      ),
    );
  }
}

class _ListaCategoria extends StatefulWidget {
  @override
  __ListaCategoriaState createState() => __ListaCategoriaState();
}

class __ListaCategoriaState extends State<_ListaCategoria> {
  final categories = [
    {"icon": FontAwesomeIcons.building, "name": "Business"},
    {"icon": FontAwesomeIcons.tv, "name": "Entertainment"},
    {"icon": FontAwesomeIcons.addressCard, "name": "General"},
    {"icon": FontAwesomeIcons.headSideVirus, "name": "Health"},
    {"icon": FontAwesomeIcons.vials, "name": "Science"},
    {"icon": FontAwesomeIcons.volleyballBall, "name": "Sports"},
    {"icon": FontAwesomeIcons.memory, "name": "Technology"},
  ];

  String _category = 'Business';

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.0,
      width: double.infinity,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                _iconButton(context, categories[index]['icon'],
                    categories[index]['name']),
                SizedBox(height: 5.0),
                Text(categories[index]['name'])
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _iconButton(BuildContext context, IconData icon, String name) {
    final newsService = Provider.of<NewsService>(context);

    return GestureDetector(
      child: Container(
        width: 40.0,
        height: 40.0,
        margin: EdgeInsets.symmetric(horizontal: 5.0),
        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
        child: Icon(
          icon,
          color: _category == name ? tema.accentColor : Colors.black45,
        ),
      ),
      onTap: () {
        setState(() {
          _category = name;
          newsService.setCategory = _category;
        });
      },
    );
  }
}
