import 'package:flutter/material.dart';
import 'package:omnivent_app_wireframe/omnivent_state_managment/colors.dart';

import 'package:omnivent_app_wireframe/omnivent_state_managment/domain/model/ProductoModel.dart';
import 'package:omnivent_app_wireframe/omnivent_state_managment/colors.dart';


class ProductDetailsScreen extends StatelessWidget {

  final ProductoModel producto;

  const ProductDetailsScreen({@required this.producto});

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

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
                    child: Icon(Icons.arrow_back_ios,color: Colors.white),
                    onTap: (){
                      Navigator.of(context).pop();
                    },
                    ),
                  SizedBox(height:15),
                  Container(
                    width: size.width * 0.6,
                    child: Text(producto.proDescripcion,
                    maxLines: 3,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 30
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  Text((producto.proCodigoBarras != null) ? producto.proCodigoBarras : 'Sin Codigo',
                  style: TextStyle(
                    color: OmniventColors.naranja
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        SizedBox(height: 15),
                        Text('Familia:\n${producto.familia.toLowerCase()}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w300
                            ),
                          ),
                          SizedBox(height: 5),
                          Text('Subfamilia:\n${(producto.subFamilia.length > 12) 
                          ? producto.subFamilia.substring(0,12)+'...' : producto.subFamilia }',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w300
                            ),
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
                          image: AssetImage('assets/imagen_no_disponible.png')
                        ),
                      ),
                    ],
                  ),
                  Text('Descripción',
                    style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                      fontSize: 26
                      ),
                    ),
                  SizedBox(height:20),
                  Container(
                    width: size.width * 0.9,
                    child: Text(producto.proDescripcion.toLowerCase(),
                      style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.w400,
                        fontSize: 15
                        ),
                      ),
                  ),
                  SizedBox(height: 20),
                  Text('Otros Datos:',
                    style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                      fontSize: 18
                      ),
                    ),
                  SizedBox(height:20),
                  Container(
                    width: size.width * 0.9,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('Identificacion: ${producto.proIdentificacion}',
                          style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.w400,
                            fontSize: 15
                            ),
                          ),
                        SizedBox(width: 30),
                        Text('ID: ${producto.proId}',
                          style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.w400,
                            fontSize: 15
                            ),
                          )
                      ],
                    )
                  ),
                  SizedBox(height:30),
                  Row(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Precio: ',
                              style: TextStyle(
                                color: OmniventColors.naranja,
                                fontWeight: FontWeight.bold,
                                fontSize: 14
                                ),
                              ),
                              Text('\$${producto.proPrecioGeneralIva}',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 24
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: 20),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Costo: ',
                              style: TextStyle(
                                color: OmniventColors.naranja,
                                fontWeight: FontWeight.bold,
                                fontSize: 14
                                ),
                              ),
                              Text('\$${producto.proCostoGeneralIva}',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 24
                                ),
                              ),
                            ],
                          ),
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
                topLeft: Radius.circular(50),
                topRight: Radius.circular(50)
              )
            ),

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
          ]
        )
      ),
    );
  }
}