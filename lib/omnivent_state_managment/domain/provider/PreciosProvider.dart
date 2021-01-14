import 'package:flutter/cupertino.dart';
import 'package:omnivent_app_wireframe/omnivent_state_managment/domain/model/PrecioModel.dart';



class PreciosProvider extends ChangeNotifier{

  List<PrecioModel> _precios = new List();
  List<PrecioModel> _preciosBuscar = new List();
  int _cargarInformacion =  1;

  List<PrecioModel> get precios => this._precios;

  set precios(List<PrecioModel> precios) {
    this._precios = precios;
    notifyListeners();
  }

  List<PrecioModel> get preciosBuscar => this._preciosBuscar;

  set preciosBuscar(List<PrecioModel> preciosBuscar) {
    this._preciosBuscar = preciosBuscar;
  }

  int get cargarInformacion => this._cargarInformacion;

  set cargarInformacion(int cargarInformacion) {
    this._cargarInformacion = cargarInformacion;
  }

}