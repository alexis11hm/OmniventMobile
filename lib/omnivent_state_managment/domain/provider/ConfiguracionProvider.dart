import 'package:flutter/cupertino.dart';
import 'package:omnivent_app_wireframe/omnivent_state_managment/domain/model/CorteCajaModel.dart';

class ConfiguracionProvider extends ChangeNotifier{

  String _rutaServicio =  '';

  String get rutaServicio => this._rutaServicio;

  set rutaServicio(String rutaServicio) {
    this._rutaServicio = rutaServicio;
    notifyListeners();
  }

  

}