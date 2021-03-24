
import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:omnivent_app_wireframe/omnivent_state_managment/domain/model/CorteCajaModel.dart';

import 'package:omnivent_app_wireframe/omnivent_state_managment/domain/model/ResponseModel.dart';



class CorteCajasService{


  Future<ResponseModel> ObtenerCorteCajas(String token, String urlBase) async{
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

          dio.options.headers['Content-Type'] = 'application/json; charset=utf-8';
          dio.options.headers["authorization"] = token;
          dio.options.baseUrl = urlBase;
          response = await dio.get('FlujosEfectivo/Listar');
              
          if(response != null){
            if(response.statusCode == 200){
              final List<dynamic> listaMapaCorteCajas = response.data;
              if(listaMapaCorteCajas == null) return ResponseModel(estatus: 200,respuesta: []);
              final List<CorteCajaModel> listaCorteCajas = new List();
              listaMapaCorteCajas.forEach((corteCajaMapa) {
                final mapa = Map<String, dynamic>.from(corteCajaMapa);
                final corteCaja = CorteCajaModel.fromJson(mapa);
                listaCorteCajas.add(corteCaja);
              });
              return ResponseModel(
                estatus: 200,
                respuesta: listaCorteCajas
              );
            }else{
                return ResponseModel(
                  estatus: response.statusCode,
                  respuesta: response.statusMessage
                );
            }
          }else{
            print("Response is null");
          }
      }on DioError catch(e){
        if(e.response.statusCode == 401){
          return ResponseModel(
            estatus: e.response.statusCode,
            respuesta: e.response.data
          );
        }
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