
import 'dart:io';
import 'dart:convert';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';

import 'package:omnivent_app_wireframe/omnivent_state_managment/domain/model/ResponseModel.dart';

import 'package:omnivent_app_wireframe/omnivent_state_managment/domain/model/ProductoModel.dart';


class ProductosService{

  final String urlBase = 'https://192.168.1.106:5001/api/';

  Future<ResponseModel> ObtenerProductos(String token) async{
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
          response = await dio.get('Productos/Listar');
              
          if(response != null){
            if(response.statusCode == 200){
              final List<dynamic> listaMapaProductos = response.data;
              if(listaMapaProductos == null) return ResponseModel(estatus: 200,respuesta: []);
              final List<ProductoModel> listaProductos = new List();
              listaMapaProductos.forEach((productoMapa) {
                final mapa = Map<String, dynamic>.from(productoMapa);
                final producto = ProductoModel.fromJson(mapa);
                listaProductos.add(producto);
              });
              return ResponseModel(
                estatus: 200,
                respuesta: listaProductos
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