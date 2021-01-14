
import 'dart:convert';

VentaModel ventaModelFromJson(String str) => VentaModel.fromJson(json.decode(str));

String ventaModelToJson(VentaModel data) => json.encode(data.toJson());

class VentaModel {
    VentaModel({
        this.vtaId,
        this.vtaFolioVenta,
        this.vtaFecha,
        this.vtaTotal,
        this.vtaEstatus,
        this.sucursal,
        this.vendedor,
        this.listaPrecios,
    });

    int vtaId;
    int vtaFolioVenta;
    String vtaFecha;
    double vtaTotal;
    String vtaEstatus;
    String sucursal;
    String vendedor;
    String listaPrecios;

    factory VentaModel.fromJson(Map<String, dynamic> json) => VentaModel(
        vtaId: json["vtaId"],
        vtaFolioVenta: json["vtaFolioVenta"],
        vtaFecha: json["vtaFecha"],
        vtaTotal: json["vtaTotal"].toDouble(),
        vtaEstatus: json["vtaEstatus"],
        sucursal: json["sucursal"],
        vendedor: (json["vendedor"] != null) ? json["vendedor"] : '',
        listaPrecios: (json["listaPrecios"] != null) ? json["listaPrecios"] : '',
    );

    Map<String, dynamic> toJson() => {
        "vtaId": vtaId,
        "vtaFolioVenta": vtaFolioVenta,
        "vtaFecha": vtaFecha,
        "vtaTotal": vtaTotal,
        "vtaEstatus": vtaEstatus,
        "sucursal": sucursal,
        "vendedor": vendedor,
        "listaPrecios": listaPrecios,
    };
}
