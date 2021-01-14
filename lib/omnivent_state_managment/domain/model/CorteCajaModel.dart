import 'dart:convert';

CorteCajaModel corteCajaModelFromJson(String str) => CorteCajaModel.fromJson(json.decode(str));

String corteCajaModelToJson(CorteCajaModel data) => json.encode(data.toJson());

class CorteCajaModel {
    CorteCajaModel({
        this.fleId,
        this.fleFecha,
        this.fleImporte,
        this.fopId,
        this.fleTipo,
        this.fleReferencia,
        this.fleObservaciones,
        this.fleDescripcion,
        this.sucursal,
        this.cacId,
        this.formaPago,
    });

    int fleId;
    String fleFecha;
    double fleImporte;
    int fopId;
    String fleTipo;
    String fleReferencia;
    String fleObservaciones;
    String fleDescripcion;
    String sucursal;
    int cacId;
    String formaPago;

    factory CorteCajaModel.fromJson(Map<String, dynamic> json) => CorteCajaModel(
        fleId: json["fleId"],
        fleFecha: json["fleFecha"],
        fleImporte: json["fleImporte"].toDouble(),
        fopId: json["fopId"],
        fleTipo: json["fleTipo"],
        fleReferencia: json["fleReferencia"],
        fleObservaciones: json["fleObservaciones"],
        fleDescripcion: json["fleDescripcion"],
        sucursal: json["sucursal"],
        cacId: json["cacId"],
        formaPago: json["formaPago"],
    );

    Map<String, dynamic> toJson() => {
        "fleId": fleId,
        "fleFecha": fleFecha,
        "fleImporte": fleImporte,
        "fopId": fopId,
        "fleTipo": fleTipo,
        "fleReferencia": fleReferencia,
        "fleObservaciones": fleObservaciones,
        "fleDescripcion": fleDescripcion,
        "sucursal": sucursal,
        "cacId": cacId,
        "formaPago": formaPago,
    };
}
