import 'package:flutter/cupertino.dart';
import 'package:omnivent_app_wireframe/omnivent_state_managment/domain/model/AlmacenProductoModel.dart';

class AlmacenProductoProvider extends ChangeNotifier{

  List<AlmacenProductoModel> _almacenProductos = new List();
  List<AlmacenProductoModel> _almacenProductosBuscar = new List();
  int _cargarInformacion =  1;

  List<AlmacenProductoModel> get almacenProductos => this._almacenProductos;

  set almacenProductos(List<AlmacenProductoModel> almacenProductos) {
    this._almacenProductos = almacenProductos;
    notifyListeners();
  }

  List<AlmacenProductoModel> get almacenProductosBuscar => this._almacenProductosBuscar;

  set almacenProductosBuscar(List<AlmacenProductoModel> almacenProductosBuscar) {
    this._almacenProductosBuscar = almacenProductosBuscar;
  }

  int get cargarInformacion => this._cargarInformacion;

  set cargarInformacion(int cargarInformacion) {
    this._cargarInformacion = cargarInformacion;
  }

}