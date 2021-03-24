import 'package:flutter/cupertino.dart';

import 'package:omnivent_app_wireframe/omnivent_state_managment/domain/model/ProductoModel.dart';


class ProductosProvider extends ChangeNotifier{

  List<ProductoModel> _productos = new List();
  List<ProductoModel> _productosBuscar = new List();
  List<String> _familias = ['General','Abarrotes','Botanas'];
  int _cargarInformacion =  1;
  int _colorFoco = -1; 

  List<ProductoModel> get productos => this._productos;

  set productos(List<ProductoModel> productos) {
    this._productos = productos;
    notifyListeners();
  }

  List<ProductoModel> get productosBuscar => this._productosBuscar;

  set productosBuscar(List<ProductoModel> productosBuscar) {
    this._productosBuscar = productosBuscar;
  }

  List<String> get familias => this._familias;

  set familias(List<String> familias) {
    this._familias = familias;
  }

  int get cargarInformacion => this._cargarInformacion;

  set cargarInformacion(int cargarInformacion) {
    this._cargarInformacion = cargarInformacion;
  }

  int get colorFoco => this._colorFoco;

  set colorFoco(int colorFoco) {
    this._colorFoco = colorFoco;
    notifyListeners();
  }

}