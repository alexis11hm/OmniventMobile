import 'package:flutter/cupertino.dart';
import 'package:omnivent_app_wireframe/omnivent_state_managment/presentation/home/operations/operations_screen.dart';

class OperacionesProvider extends ChangeNotifier{

  List<OptionItem> _operaciones = new List();
  List<OptionItem> _operacionesBuscar = new List();
  int _cargarInformacion = 1;

  List<OptionItem> get operaciones => this._operaciones;

  set operaciones(List<OptionItem> operaciones) {
    this._operaciones = operaciones;
    notifyListeners();
  }

  List<OptionItem> get operacionesBuscar => this._operacionesBuscar;

  set operacionesBuscar(List<OptionItem> operacionesBuscar) {
    this._operacionesBuscar = operacionesBuscar;
  }

  int get cargarInformacion => this._cargarInformacion;

  set cargarInformacion(int cargarInformacion) {
    this._cargarInformacion = cargarInformacion;
  }

}