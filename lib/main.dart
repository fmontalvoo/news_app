import 'package:flutter/material.dart';

import 'package:news_app/theme/theme.dart';
import 'package:news_app/pages/tabs_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: tema,
      home: TabsPage(),
    );
  }
}