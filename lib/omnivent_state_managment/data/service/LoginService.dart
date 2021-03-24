

import 'dart:io';
import 'dart:convert';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';

import 'package:omnivent_app_wireframe/omnivent_state_managment/domain/model/ResponseModel.dart';

import 'package:omnivent_app_wireframe/omnivent_state_managment/domain/model/LoginModel.dart';


class LoginService{


  Future<ResponseModel> iniciarSesion(LoginModel modelo,String urlBase) async{
      try{
          Response response;
          Dio dio = new Dio();

          //If you dont have SSL certificate, you can allow the request to web service 
          (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
                  (HttpClient client) {
                client.badCertificateCallback =
                    (X509Certificate cert, String host, int port) => true;
                return client;
              };

          final datos = {
            'usuario': modelo.usuario,
            'password': modelo.password
          };

          dio.options.headers['Content-Type'] = 'application/json; charset=utf-8';
          dio.options.baseUrl = urlBase;
          response = await dio.post('Usuarios/Login', data: jsonEncode(datos));
              
          if(response != null){
            if(response.statusCode == 200){
              final Map<String,dynamic> mapa = response.data; 
              return ResponseModel(
                estatus: 200,
                respuesta: mapa['token']
              );
            }else{
                return ResponseModel(
                  estatus: response.statusCode,
                  respuesta: ''
                );
            }
          }else{
            print("Response is null");
          }
      }on DioError catch(e){
        if(e.response != null){
           return ResponseModel(
            estatus: e.response.statusCode,
            respuesta: e.response.data
          );
        }
        return ResponseModel(
            estatus: 408,
            respuesta: 'Tardo mucho tiempo la peticion'
          );
      }
  }


}