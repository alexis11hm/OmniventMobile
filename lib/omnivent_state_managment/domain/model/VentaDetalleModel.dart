import 'dart:convert';

VentaDetalleModel ventaDetalleModelFromJson(String str) => VentaDetalleModel.fromJson(json.decode(str));

String ventaDetalleModelToJson(VentaDetalleModel data) => json.encode(data.toJson());

class VentaDetalleModel {
    VentaDetalleModel({
        this.vedId,
        this.vtaId,
        this.proId,
        this.vedPrecio,
        this.vedDescuento,
        this.vedCantidad,
        this.venta,
        this.producto,
    });

    int vedId;
    int vtaId;
    int proId;
    double vedPrecio;
    double vedDescuento;
    double vedCantidad;
    String venta;
    String producto;

    factory VentaDetalleModel.fromJson(Map<String, dynamic> json) => VentaDetalleModel(
        vedId: json["vedId"],
        vtaId: json["vtaId"],
        proId: json["proId"],
        vedPrecio: json["vedPrecio"].toDouble(),
        vedDescuento: json["vedDescuento"].toDouble(),
        vedCantidad: json["vedCantidad"].toDouble(),
        venta: json["venta"],
        producto: json["producto"],
    );

    Map<String, dynamic> toJson() => {
        "vedId": vedId,
        "vtaId": vtaId,
        "proId": proId,
        "vedPrecio": vedPrecio,
        "vedDescuento": vedDescuento,
        "vedCantidad": vedCantidad,
        "venta": venta,
        "producto": producto,
    };
}
