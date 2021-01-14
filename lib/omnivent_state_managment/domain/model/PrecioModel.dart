import 'dart:convert';

PrecioModel precioModelFromJson(String str) => PrecioModel.fromJson(json.decode(str));

String precioModelToJson(PrecioModel data) => json.encode(data.toJson());

class PrecioModel {
    PrecioModel({
        this.lipId,
        this.proId,
        this.lipDetSinIva,
        this.lipDetConIva,
        this.listaPrecio,
        this.productoId,
        this.productoDescripcion,
        this.productoCodigoBarras,
    });

    int lipId;
    int proId;
    double lipDetSinIva;
    double lipDetConIva;
    String listaPrecio;
    int productoId;
    String productoDescripcion;
    String productoCodigoBarras;

    factory PrecioModel.fromJson(Map<String, dynamic> json) => PrecioModel(
        lipId: json["lipId"],
        proId: json["proId"],
        lipDetSinIva: json["lipDetSinIva"].toDouble(),
        lipDetConIva: json["lipDetConIva"].toDouble(),
        listaPrecio: json["listaPrecio"],
        productoId: json["productoId"],
        productoDescripcion: json["productoDescripcion"],
        productoCodigoBarras: json["productoCodigoBarras"],
    );

    Map<String, dynamic> toJson() => {
        "lipId": lipId,
        "proId": proId,
        "lipDetSinIva": lipDetSinIva,
        "lipDetConIva": lipDetConIva,
        "listaPrecio": listaPrecio,
        "productoId": productoId,
        "productoDescripcion": productoDescripcion,
        "productoCodigoBarras": productoCodigoBarras,
    };
}
