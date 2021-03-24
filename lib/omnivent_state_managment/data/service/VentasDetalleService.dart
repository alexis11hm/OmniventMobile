
import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:omnivent_app_wireframe/omnivent_state_managment/domain/model/VentaDetalleModel.dart';

import 'package:omnivent_app_wireframe/omnivent_state_managment/domain/model/ResponseModel.dart';



class VentasDetalleService{

  Future<ResponseModel> ObtenerVentasDetalle(String token,String urlBase) async{
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
          response = await dio.get('VentaDetalles/Listar');
              
          if(response != null){
            if(response.statusCode == 200){
              final List<dynamic> listaMapaVentasDetalle = response.data;
              if(listaMapaVentasDetalle == null) return ResponseModel(estatus: 200,respuesta: []);
              final List<VentaDetalleModel> listaVentasDetalle = new List();
              listaMapaVentasDetalle.forEach((ventaDetalleMapa) {
                final mapa = Map<String, dynamic>.from(ventaDetalleMapa);
                final ventaDetalle = VentaDetalleModel.fromJson(mapa);
                listaVentasDetalle.add(ventaDetalle);
              });
              return ResponseModel(
                estatus: 200,
                respuesta: listaVentasDetalle
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