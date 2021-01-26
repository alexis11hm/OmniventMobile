

import 'package:flutter_test/flutter_test.dart';
import 'package:omnivent_app_wireframe/omnivent_state_managment/data/service/LoginService.dart';
import 'package:omnivent_app_wireframe/omnivent_state_managment/domain/model/LoginModel.dart';

void main(){

  group('Pruebas unitarias',(){
    test('Validacion para el login',(){
    final loginService = LoginService();
    final login = LoginModel();
    login.usuario = 'consultor1';
    login.password = 'p';
    
    loginService.iniciarSesion(login).then((value) => {
      expect(value.estatus, 200)
    });
  });

  test('Validacion para el login',(){
    final loginService = LoginService();
    final login = LoginModel();
    login.usuario = 'persona';
    login.password = 'z';
    
    loginService.iniciarSesion(login).then((value) => {
      expect(value.estatus, 400)
    });
  });
  });

}