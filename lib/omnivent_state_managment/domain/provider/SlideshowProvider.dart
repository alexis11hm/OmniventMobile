import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SlideshowProvider extends ChangeNotifier {
  double _paginaActual = 0;
  double _bulletPrimario = 18.0;
  double _bulletSecundario = 12.0;
  Color _colorPrimario = Colors.blueGrey;
  Color _colorSecundario = Colors.orange;

  double get paginaActual => this._paginaActual;

  set paginaActual(double pagina) {
    this._paginaActual = pagina;
    print(pagina);
    notifyListeners();
  }

  double get bulletPrimario => this._bulletPrimario;

  set bulletPrimario(double primario) {
    this._bulletPrimario = primario;
  }

  double get bulletSecundario => this._bulletSecundario;

  set bulletSecundario(double secundario) {
    this._bulletSecundario = secundario;
  }

  Color get colorPrimario => this._colorPrimario;

  set colorPrimario(Color color) {
    this._colorPrimario = color;
  }

  Color get colorSecundario => this._colorSecundario;

  set colorSecundario(Color color) {
    this._colorSecundario = color;
  }

}