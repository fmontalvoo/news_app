import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TabsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => _NavegacionModel(),
        child: Scaffold(
          body: _Pages(),
          bottomNavigationBar: _Navigation(),
        ));
  }
}

class _Pages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final navegacionModel = Provider.of<_NavegacionModel>(context);
    return PageView(
      // physics: BouncingScrollPhysics(),
      controller: navegacionModel.getPageController,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        Container(color: Colors.blue),
        Container(color: Colors.red),
      ],
    );
  }
}

class _Navigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final navegacionModel = Provider.of<_NavegacionModel>(context);
    return BottomNavigationBar(
        currentIndex: navegacionModel.getPaginaIndex,
        onTap: (value) => navegacionModel.setPaginaIndex = value,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline), title: Text('Para ti')),
          BottomNavigationBarItem(
              icon: Icon(Icons.public), title: Text('Encabezados')),
        ]);
  }
}

class _NavegacionModel with ChangeNotifier {
  int _paginaIndex = 0;
  PageController _pageController = PageController();

  set setPaginaIndex(int index) {
    this._paginaIndex = index;
    this._pageController.animateToPage(this._paginaIndex,
        duration: Duration(milliseconds: 500), curve: Curves.decelerate);
    notifyListeners();
  }

  int get getPaginaIndex => this._paginaIndex;

  PageController get getPageController => this._pageController;
}
