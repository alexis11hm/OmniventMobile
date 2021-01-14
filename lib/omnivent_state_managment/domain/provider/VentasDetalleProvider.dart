import 'package:flutter/cupertino.dart';

import 'package:omnivent_app_wireframe/omnivent_state_managment/domain/model/VentaDetalleModel.dart';


class VentasDetalleProvider extends ChangeNotifier{

  List<VentaDetalleModel> _ventasDetalle = new List();
  List<VentaDetalleModel> _ventasDetalleBuscar = new List();
  int _cargarInformacion =  1;

  List<VentaDetalleModel> get ventasDetalle => this._ventasDetalle;

  set ventasDetalle(List<VentaDetalleModel> ventasDetalle) {
    this._ventasDetalle = ventasDetalle;
    notifyListeners();
  }

  List<VentaDetalleModel> get ventasDetalleBuscar => this._ventasDetalleBuscar;

  set ventasDetalleBuscar(List<VentaDetalleModel> ventasDetalleBuscar) {
    this._ventasDetalleBuscar = ventasDetalleBuscar;
  }

  int get cargarInformacion => this._cargarInformacion;

  set cargarInformacion(int cargarInformacion) {
    this._cargarInformacion = cargarInformacion;
  }

}