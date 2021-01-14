import 'package:flutter/cupertino.dart';

import 'package:omnivent_app_wireframe/omnivent_state_managment/domain/model/VentaModel.dart';


class VentasProvider extends ChangeNotifier{

  List<VentaModel> _ventas = new List();
  List<VentaModel> _ventasBuscar = new List();
  int _cargarInformacion =  1;

  List<VentaModel> get ventas => this._ventas;

  set ventas(List<VentaModel> ventas) {
    this._ventas = ventas;
    notifyListeners();
  }

  List<VentaModel> get ventasBuscar => this._ventasBuscar;

  set ventasBuscar(List<VentaModel> ventasBuscar) {
    this._ventasBuscar = ventasBuscar;
  }

  int get cargarInformacion => this._cargarInformacion;

  set cargarInformacion(int cargarInformacion) {
    this._cargarInformacion = cargarInformacion;
  }

}