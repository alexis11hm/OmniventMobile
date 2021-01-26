import 'package:flutter/cupertino.dart';

class HomeProvider extends ChangeNotifier{

  int _paginaPrincipal = 1;

  int get paginaPrincipal => this._paginaPrincipal;

  set paginaPrincipal(int paginaPrincipal) {
    this._paginaPrincipal = paginaPrincipal;
    notifyListeners();
  }

}