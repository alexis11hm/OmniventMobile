// To parse this JSON data, do
//
//     final almacenProducto = almacenProductoFromJson(jsonString);

import 'dart:convert';

AlmacenProductoModel almacenProductoFromJson(String str) => AlmacenProductoModel.fromJson(json.decode(str));

String almacenProductoToJson(AlmacenProductoModel data) => json.encode(data.toJson());

class AlmacenProductoModel {
    AlmacenProductoModel({
        this.proId,
        this.productoDescripcion,
        this.productoIdentificacion,
        this.sucursal,
        this.almacenes,
    });

    int proId;
    String productoDescripcion;
    String productoIdentificacion;
    String sucursal;
    Almacenes almacenes;

    factory AlmacenProductoModel.fromJson(Map<String, dynamic> json) => AlmacenProductoModel(
        proId: json["proId"],
        productoDescripcion: json["productoDescripcion"],
        productoIdentificacion: json["productoIdentificacion"],
        sucursal: json["sucursal"],
        almacenes: Almacenes.fromJson(json["almacenes"]),
    );

    Map<String, dynamic> toJson() => {
        "proId": proId,
        "productoDescripcion": productoDescripcion,
        "productoIdentificacion": productoIdentificacion,
        "sucursal": sucursal,
        "almacenes": almacenes.toJson(),
    };
}

class Almacenes {
    Almacenes({
        this.almacenMerma,
        this.almacenGeneral,
        this.almacnAguascalientes,
    });

    double almacenMerma;
    double almacenGeneral;
    double almacnAguascalientes;

    factory Almacenes.fromJson(Map<String, dynamic> json) => Almacenes(
        almacenMerma: json["Almacen Merma"].toDouble(),
        almacenGeneral: json["Almacen General"].toDouble(),
        almacnAguascalientes: json["Almacén Aguascalientes"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "Almacen Merma": almacenMerma,
        "Almacen General": almacenGeneral,
        "Almacén Aguascalientes": almacnAguascalientes,
    };
}
