import 'package:flutter/material.dart';
import 'package:omnivent_app_wireframe/omnivent_state_managment/presentation/widgets/headers_wave.dart';

import 'package:omnivent_app_wireframe/omnivent_state_managment/domain/model/VentaDetalleModel.dart';

class ProductsSalesDetailsScreen extends StatelessWidget {
  ProductsSalesDetailsScreen({@required this.ventaDetalle});

  final VentaDetalleModel ventaDetalle;

  final TextStyle _styleText = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w300,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            HeaderBottomWave(),
            Padding(
              padding: const EdgeInsets.only(top: 50, left: 30, right: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        child: Icon(Icons.arrow_back_ios, color: Colors.white),
                        onTap: () => Navigator.of(context).pop(),
                      ),
                      Icon(Icons.logout, color: Colors.white)
                    ],
                  ),
                  SizedBox(height: 40),
                  Center(
                    child: Text(
                      ventaDetalle.producto,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 30),
                    ),
                  ),
                  SizedBox(height: 10),
                  Center(
                    child: Text(
                      ventaDetalle.venta,
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.5),
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                  SizedBox(height: 30),
                  Center(
                    child: FadeInImage(
                        width: 150,
                        height: 150,
                        placeholder: AssetImage('assets/cargando.gif'),
                        image: AssetImage('assets/imagen_no_disponible.png')),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Detalles',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 22),
                  ),
                  Divider(),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Sucursal',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey),
                      ),
                      Text(
                        'Usuario',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey),
                      )
                    ],
                  ),
                  SizedBox(height: 10),
                  /*Center(child: Text('Fecha: 12/12/2020',style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),)),
              SizedBox(height: 10),*/
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Venta #', style: _styleText),
                      Text(ventaDetalle.venta, style: _styleText)
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('VED ID', style: _styleText),
                      Text(ventaDetalle.vedId.toString(), style: _styleText)
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('VTA ID', style: _styleText),
                      Text(ventaDetalle.vtaId.toString(), style: _styleText)
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('PRO ID', style: _styleText),
                      Text(ventaDetalle.proId.toString(), style: _styleText)
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Cantidad', style: _styleText),
                      Text(ventaDetalle.vedCantidad.toString(),
                          style: _styleText)
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Precio', style: _styleText),
                      Text('\$${ventaDetalle.vedPrecio}', style: _styleText)
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Descuento', style: _styleText),
                      Text('\$${ventaDetalle.vedDescuento}', style: _styleText)
                    ],
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Importe Venta', style: _styleText),
                      Text(
                          '\$${(ventaDetalle.vedPrecio * ventaDetalle.vedCantidad) - ventaDetalle.vedDescuento}',
                          style: _styleText)
                    ],
                  ),
                  SizedBox(height: 30)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
