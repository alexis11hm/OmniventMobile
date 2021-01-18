import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:omnivent_app_wireframe/omnivent_state_managment/colors.dart';
import 'package:omnivent_app_wireframe/omnivent_state_managment/data/service/PreciosService.dart';
import 'package:omnivent_app_wireframe/omnivent_state_managment/domain/model/PrecioModel.dart';

import 'package:omnivent_app_wireframe/omnivent_state_managment/domain/model/ProductoModel.dart';
import 'package:omnivent_app_wireframe/omnivent_state_managment/colors.dart';
import 'package:omnivent_app_wireframe/omnivent_state_managment/domain/storage/secure_storage.dart';
import 'package:omnivent_app_wireframe/omnivent_state_managment/presentation/login/login_screen.dart';
import 'package:omnivent_app_wireframe/omnivent_state_managment/presentation/widgets/alert_dialogs.dart';

class ProductDetailsScreen extends StatelessWidget {
  final ProductoModel producto;

  const ProductDetailsScreen({@required this.producto});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    List<PrecioModel> precios = new List<PrecioModel>();

    cargarInformacion(int id) {
      print('realizar peticion');
      final preciosService = PreciosService();
      final secure = SecureStorage();
      final almacenamiento = secure.crearAlmacenamiento();

      almacenamiento.read(key: 'token').then((token) => {
            preciosService.ObtenerPrecioProducto(token, id)
                .then((respuesta) => {
                      if (respuesta.estatus == 200)
                        {
                          print('Se obtuvo precios'),
                          precios = respuesta.respuesta
                        }
                      else if (respuesta.estatus == 401)
                        {
                          //_mostrarAlerta()
                        }
                      else
                        {print('no hay precios'), precios = null}
                    })
          });
    }

    int id = producto.proId;
    cargarInformacion(id);

    return Scaffold(
      body: Stack(
        children: [
          _TopBackground(),
          _BottomBackground(size: size),
          Positioned(
            top: 30,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    child: Icon(Icons.arrow_back_ios, color: Colors.white),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  SizedBox(height: 15),
                  Container(
                    width: size.width * 0.6,
                    child: Text(
                      producto.proDescripcion,
                      maxLines: 3,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 30),
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(
                    (producto.proCodigoBarras != null)
                        ? producto.proCodigoBarras
                        : 'Sin Codigo',
                    style: TextStyle(color: OmniventColors.naranja),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 15),
                          Text(
                            'Familia:\n${producto.familia.toLowerCase()}',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w300),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Subfamilia:\n${(producto.subFamilia.length > 12) ? producto.subFamilia.substring(0, 12) + '...' : producto.subFamilia}',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w300),
                          ),
                        ],
                      ),
                      SizedBox(width: 40),
                      Hero(
                        tag: producto.proId,
                        child: FadeInImage(
                            width: 200,
                            height: 150,
                            placeholder: AssetImage('assets/cargando.gif'),
                            image:
                                AssetImage('assets/imagen_no_disponible.png')),
                      ),
                    ],
                  ),
                  Text(
                    'Descripción',
                    style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                        fontSize: 26),
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: size.width * 0.9,
                    child: Text(
                      producto.proDescripcion.toLowerCase(),
                      style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.w400,
                          fontSize: 15),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Otros Datos:',
                    style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  SizedBox(height: 20),
                  Container(
                      width: size.width * 0.9,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Identificacion: ${producto.proIdentificacion}',
                            style: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.w400,
                                fontSize: 15),
                          ),
                          SizedBox(width: 30),
                          Text(
                            'ID: ${producto.proId}',
                            style: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.w400,
                                fontSize: 15),
                          )
                        ],
                      )),
                  SizedBox(height: 30),
                  Row(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Precio: ',
                            style: TextStyle(
                                color: OmniventColors.naranja,
                                fontWeight: FontWeight.bold,
                                fontSize: 14),
                          ),
                          Text(
                            '\$${producto.proPrecioGeneralIva.toStringAsFixed(2)}',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 24),
                          ),
                        ],
                      ),
                      SizedBox(width: 20),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Costo: ',
                            style: TextStyle(
                                color: OmniventColors.naranja,
                                fontWeight: FontWeight.bold,
                                fontSize: 14),
                          ),
                          Text(
                            '\$${producto.proCostoGeneralIva.toStringAsFixed(2)}',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 24),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      RaisedButton(
                          child: Text(
                            'Consultar lista de precios',
                            style: TextStyle(color: Colors.white),
                          ),
                          color: OmniventColors.azulMarino,
                          onPressed: () {
                            if (precios != null && precios.length > 0) {
                              showDialog(
                                  context: context,
                                  barrierDismissible: true,
                                  builder: (context) {
                                    return CustomAlertDialog(
                                        titulo: producto.proDescripcion,
                                        contenido: List.generate(
                                            precios.length,
                                            (index) => Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                        '${precios[index].listaPrecio}'),
                                                    SizedBox(height: 10),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          'C/Iva: \$${precios[index].lipDetConIva.toStringAsFixed(2)}',
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              color: OmniventColors
                                                                  .azulMarino),
                                                        ),
                                                        SizedBox(width: 10),
                                                        Text(
                                                          'S/Iva: \$${precios[index].lipDetSinIva.toStringAsFixed(2)}',
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              color: OmniventColors
                                                                  .azulMarino),
                                                        ),
                                                      ],
                                                    ),
                                                    Divider(color: Colors.grey)
                                                  ],
                                                )),
                                        botones: [
                                          FlatButton(
                                            child: Text('Aceptar'),
                                            onPressed: () =>
                                                Navigator.of(context).pop(),
                                          )
                                        ]);
                                  });
                            } else if (precios.length == 0) {
                              showDialog(
                                  context: context,
                                  barrierDismissible: true,
                                  builder: (context) {
                                    return CustomAlertDialog(
                                        titulo: 'No hay precios para este producto',
                                        contenido: [],
                                        botones: [
                                          FlatButton(
                                            child: Text('Aceptar'),
                                            onPressed: () =>
                                                Navigator.of(context).pop(),
                                          )
                                        ]);
                                  });
                            }
                          })
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _BottomBackground extends StatelessWidget {
  const _BottomBackground({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: size.height * 0.5),
        Container(
          height: size.height * 0.5,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50), topRight: Radius.circular(50))),
        ),
      ],
    );
  }
}

class _TopBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[
            OmniventColors.azulMarino,
            OmniventColors.azulCielo
          ])),
    );
  }
}
