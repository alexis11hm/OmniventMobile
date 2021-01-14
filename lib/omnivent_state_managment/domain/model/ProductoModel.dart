
import 'dart:convert';

ProductoModel productoModelFromJson(String str) => ProductoModel.fromJson(json.decode(str));

String productoModelToJson(ProductoModel data) => json.encode(data.toJson());

class ProductoModel {
    ProductoModel({
        this.proId,
        this.proDescripcion,
        this.proCodigoBarras,
        this.proIdentificacion,
        this.familia,
        this.subFamilia,
        this.proPrecioGeneralIva,
        this.proCostoGeneralIva,
    });

    int proId;
    String proDescripcion;
    String proCodigoBarras;
    String proIdentificacion;
    String familia;
    String subFamilia;
    double proPrecioGeneralIva;
    double proCostoGeneralIva;

    factory ProductoModel.fromJson(Map<String, dynamic> json) => ProductoModel(
        proId: json["proId"],
        proDescripcion: json["proDescripcion"],
        proCodigoBarras: json["proCodigoBarras"],
        proIdentificacion: json["proIdentificacion"],
        familia: json["familia"],
        subFamilia: json["subFamilia"],
        proPrecioGeneralIva: json["proPrecioGeneralIva"].toDouble(),
        proCostoGeneralIva: json["proCostoGeneralIva"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "proId": proId,
        "proDescripcion": proDescripcion,
        "proCodigoBarras": proCodigoBarras,
        "proIdentificacion": proIdentificacion,
        "familia": familia,
        "subFamilia": subFamilia,
        "proPrecioGeneralIva": proPrecioGeneralIva,
        "proCostoGeneralIva": proCostoGeneralIva,
    };
}
