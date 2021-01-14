import 'package:flutter/cupertino.dart';

import 'package:omnivent_app_wireframe/omnivent_state_managment/domain/model/ProductoModel.dart';


class ProductosProvider extends ChangeNotifier{

  List<ProductoModel> _productos = new List();
  List<ProductoModel> _productosBuscar = new List();
  int _cargarInformacion =  1;

  List<ProductoModel> get productos => this._productos;

  set productos(List<ProductoModel> productos) {
    this._productos = productos;
    notifyListeners();
  }

  List<ProductoModel> get productosBuscar => this._productosBuscar;

  set productosBuscar(List<ProductoModel> productosBuscar) {
    this._productosBuscar = productosBuscar;
  }

  int get cargarInformacion => this._cargarInformacion;

  set cargarInformacion(int cargarInformacion) {
    this._cargarInformacion = cargarInformacion;
  }

}