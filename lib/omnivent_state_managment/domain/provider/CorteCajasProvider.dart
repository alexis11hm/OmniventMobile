import 'package:flutter/cupertino.dart';
import 'package:omnivent_app_wireframe/omnivent_state_managment/domain/model/CorteCajaModel.dart';

class CorteCajasProvider extends ChangeNotifier{

  List<CorteCajaModel> _cortesCaja = new List();
  List<CorteCajaModel> _cortesCajaBuscar = new List();
  int _cargarInformacion =  1;

  List<CorteCajaModel> get cortesCaja => this._cortesCaja;

  set cortesCaja(List<CorteCajaModel> cortesCaja) {
    this._cortesCaja = cortesCaja;
    notifyListeners();
  }

  List<CorteCajaModel> get cortesCajaBuscar => this._cortesCajaBuscar;

  set cortesCajaBuscar(List<CorteCajaModel> cortesCajaBuscar) {
    this._cortesCajaBuscar = cortesCajaBuscar;
  }

  int get cargarInformacion => this._cargarInformacion;

  set cargarInformacion(int cargarInformacion) {
    this._cargarInformacion = cargarInformacion;
  }

}