import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:omnivent_app_wireframe/omnivent_state_managment/colors.dart';
import 'package:omnivent_app_wireframe/omnivent_state_managment/data/service/PreciosService.dart';
import 'package:omnivent_app_wireframe/omnivent_state_managment/domain/model/PrecioModel.dart';

import 'package:omnivent_app_wireframe/omnivent_state_managment/domain/model/ProductoModel.dart';
import 'package:omnivent_app_wireframe/omnivent_state_managment/colors.dart';
import 'package:omnivent_app_wireframe/omnivent_state_managment/domain/storage/secure_storage.dart';
import 'package:omnivent_app_wireframe/omnivent_state_managment/presentation/widgets/alert_dialogs.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

class ProductDetailsScreen extends StatelessWidget {
  final ProductoModel producto;

  const ProductDetailsScreen({@required this.producto});

  @override
  Widget build(BuildContext context) {
    return _Scaffold(context: context, producto: producto);
  }
}

class _Scaffold extends StatefulWidget {
  const _Scaffold({@required this.producto, @required this.context});

  final ProductoModel producto;
  final BuildContext context;

  @override
  __ScaffoldState createState() => __ScaffoldState();
}

class __ScaffoldState extends State<_Scaffold> {
  TutorialCoachMark tutorialCoachMark;

  GlobalKey keyPrices = new GlobalKey();
  GlobalKey keyBack = new GlobalKey();

  List<TargetFocus> targets = List<TargetFocus>();

  TextStyle estiloEncabezado =
      TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.white);

  TextStyle estiloCuerpo =
      TextStyle(fontWeight: FontWeight.w400, fontSize: 14, color: Colors.white);

  @override
  void initState() {
    final secure = SecureStorage();
    final almacenamiento = secure.crearAlmacenamiento();

    almacenamiento.read(key: 'coachMark').then((cm) {
      if (cm == null || cm.isEmpty) {
        initTarget();
        WidgetsBinding.instance.addPostFrameCallback(_afterLayout);
      }
      super.initState();
    });
  }

  void _afterLayout(_) {
    Future.delayed(Duration(microseconds: 2000));
    _showTutorial();
  }

  void _showTutorial() {
    final secure = SecureStorage();
    final almacenamiento = secure.crearAlmacenamiento();
    tutorialCoachMark = TutorialCoachMark(widget.context,
        targets: targets,
        colorShadow: Colors.black,
        opacityShadow: 0.8,
        textSkip: 'Omitir', onClickSkip: () {
      almacenamiento.write(key: 'coachMark', value: 'noshow');
      Navigator.of(context).pop();
      Navigator.of(context).pop();
    }, onFinish: () {
      almacenamiento.write(key: 'coachMark', value: 'noshow');
      Navigator.of(context).pop();
      Navigator.of(context).pop();
    })
      ..show();
  }

  void initTarget() {
    targets.add(
      TargetFocus(identify: 'target 0', keyTarget: keyPrices, contents: [
        ContentTarget(
            align: AlignContent.top,
            child: Container(
              child: Column(
                children: [
                  Text('Precios',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 24)),
                  SizedBox(height: 10),
                  Text('Consulta los precios',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 14))
                ],
              ),
            ))
      ]),
    );
    targets.add(
      TargetFocus(identify: 'target 0', keyTarget: keyBack, contents: [
        ContentTarget(
            align: AlignContent.bottom,
            child: Container(
              child: Column(
                children: [
                  Text('Regresar', style: estiloEncabezado),
                  SizedBox(height: 10),
                  Text('Regresa a la pantalla anterior',
                      textAlign: TextAlign.center, style: estiloCuerpo)
                ],
              ),
            ))
      ]),
    );
  }

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
            almacenamiento.read(key: 'rutaAPI').then((ruta) => {
                  preciosService.ObtenerPrecioProducto(token, id, ruta)
                      .then((respuesta) => {
                            if (respuesta.estatus == 200)
                              {
                                print('Se obtuvo precios por producto'),
                                precios = respuesta.respuesta,
                                print(precios.length)
                              }
                            else if (respuesta.estatus == 401)
                              {
                                //_mostrarAlerta()
                              }
                            else
                              {print('no hay precios'), precios = null}
                          })
                })
          });
    }

    int id = widget.producto.proId;
    cargarInformacion(id);

    return Scaffold(
      body: Stack(
        children: [
          _TopBackground(),
          _BottomBackground(size: size),
          _HeaderProductContent(keyBack: keyBack, size: size, widget: widget),
          Positioned(
            top:(size.height / 2),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                height: 500,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                        widget.producto.proDescripcion.toLowerCase(),
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
                              'Identificacion: ${widget.producto.proIdentificacion}',
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15),
                            ),
                            SizedBox(width: 30),
                            Text(
                              'ID: ${widget.producto.proId}',
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
                              '\$${widget.producto.proPrecioGeneralIva.toStringAsFixed(2)}',
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
                              '\$${widget.producto.proCostoGeneralIva.toStringAsFixed(2)}',
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
                            key: keyPrices,
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
                                          titulo: widget.producto.proDescripcion,
                                          contenido: List.generate(
                                              precios.length,
                                              (index) => Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.start,
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
                                          titulo:
                                              'No hay precios para este producto',
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
            ),
          )
        ],
      ),
    );
  }
}

class _HeaderProductContent extends StatelessWidget {
  const _HeaderProductContent({
    Key key,
    @required this.keyBack,
    @required this.size,
    @required this.widget,
  });

  final GlobalKey<State<StatefulWidget>> keyBack;
  final Size size;
  final _Scaffold widget;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 40,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              key: keyBack,
              child: Icon(Icons.arrow_back_ios, color: Colors.white),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            SizedBox(height: 15),
            Container(
              width: size.width * 0.6,
              child: Text(
                widget.producto.proDescripcion,
                maxLines: 3,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 30),
              ),
            ),
            SizedBox(height: 15),
            Text(
              (widget.producto.proCodigoBarras != null)
                  ? widget.producto.proCodigoBarras
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
                      'Familia:\n${widget.producto.familia.toLowerCase()}',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w300),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Subfamilia:\n${(widget.producto.subFamilia.length > 12) ? widget.producto.subFamilia.substring(0, 12) + '...' : widget.producto.subFamilia}',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
                SizedBox(width: 40),
                Hero(
                  tag: widget.producto.proId,
                  child: FadeInImage(
                      width: 200,
                      height: 150,
                      placeholder: AssetImage('assets/cargando.gif'),
                      image: AssetImage('assets/imagen_no_disponible.png')),
                ),
              ],
            ),
          ],
        ),
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
