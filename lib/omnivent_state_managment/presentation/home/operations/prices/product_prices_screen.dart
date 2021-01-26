import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:omnivent_app_wireframe/omnivent_state_managment/colors.dart';
import 'package:omnivent_app_wireframe/omnivent_state_managment/data/service/PreciosService.dart';
import 'package:omnivent_app_wireframe/omnivent_state_managment/domain/model/PrecioModel.dart';
import 'package:omnivent_app_wireframe/omnivent_state_managment/domain/provider/PreciosProvider.dart';
import 'package:omnivent_app_wireframe/omnivent_state_managment/domain/storage/secure_storage.dart';
import 'package:omnivent_app_wireframe/omnivent_state_managment/presentation/home/operations/sales/products_sales/products_sales_details/products_sales_details_screen.dart';
import 'package:omnivent_app_wireframe/omnivent_state_managment/presentation/login/login_screen.dart';
import 'package:omnivent_app_wireframe/omnivent_state_managment/presentation/widgets/alert_dialogs.dart';
import 'package:omnivent_app_wireframe/omnivent_state_managment/presentation/widgets/sliver_custom.dart';
import 'package:provider/provider.dart';

class ProductPriceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => new PreciosProvider(),
      child: _Scaffold(),
    );
  }
}

class _Scaffold extends StatefulWidget {
  @override
  __ScaffoldState createState() => __ScaffoldState();
}

class __ScaffoldState extends State<_Scaffold> {
  TextEditingController _controllerBuscar;

  @override
  void initState() {
    super.initState();
    _controllerBuscar = TextEditingController();
  }

  @override
  void dispose() {
    _controllerBuscar?.dispose();
    super.dispose();
  }

  void _mostrarAlerta() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return CustomAlertDialog(titulo: 'Sesión Expirada', contenido: [
            Text('La sesión ha expirado'),
            SvgPicture.asset(
              'assets/close/salir.svg',
              width: 120,
              height: 120,
              placeholderBuilder: (BuildContext context) {
                return Image.asset(
                  'assets/cargando.gif',
                  width: 100,
                  height: 100,
                );
              },
            ),
          ], botones: [
            FlatButton(
              child: Text('Aceptar'),
              onPressed: () => Navigator.of(context).pushReplacement(
                  CupertinoPageRoute(builder: (_) => LoginScreen())),
            ),
            FlatButton(
              child: Text('Cancelar'),
              onPressed: () => Navigator.of(context).pop(),
            )
          ]);
        });
  }

  @override
  Widget build(BuildContext context) {
    final preciosService = PreciosService();
    final secure = SecureStorage();
    final almacenamiento = secure.crearAlmacenamiento();
    final preciosProvider = Provider.of<PreciosProvider>(context);

    cargarInformacion() {
      almacenamiento.read(key: 'token').then((token) => {
            preciosService.ObtenerPrecios(token).then((respuesta) => {
                  if (respuesta.estatus == 200)
                    {
                      print('Precios'),
                      preciosProvider.precios = respuesta.respuesta,
                      preciosProvider.preciosBuscar = respuesta.respuesta,
                      preciosProvider.cargarInformacion = 0
                    }
                  else if (respuesta.estatus == 401)
                    {_mostrarAlerta()}
                  else
                    {
                      preciosProvider.precios = null,
                      preciosProvider.preciosBuscar = null,
                      preciosProvider.cargarInformacion = 0
                    }
                })
          });
    }

    buscarInformacion(String buscar) {
      final List<PrecioModel> listaPrecios = preciosProvider.preciosBuscar
          .where((precio) =>
              precio.lipDetConIva
                  .toString()
                  .toLowerCase()
                  .contains(buscar.toLowerCase()) ||
              precio.lipDetSinIva
                  .toString()
                  .toLowerCase()
                  .contains(buscar.toLowerCase()) ||
              precio.lipId
                  .toString()
                  .toLowerCase()
                  .contains(buscar.toLowerCase()) ||
              precio.listaPrecio.toLowerCase().contains(buscar.toLowerCase()) ||
              precio.proId
                  .toString()
                  .toLowerCase()
                  .contains(buscar.toLowerCase()) ||
              precio.productoDescripcion
                  .toLowerCase()
                  .contains(buscar.toLowerCase()))
          .toList();

      preciosProvider.precios = listaPrecios;
      print('Se realizo la llamada: ${listaPrecios.length}');
    }

    if (preciosProvider.cargarInformacion == 1) {
      cargarInformacion();
    }

    return Scaffold(
      floatingActionButton: Roulette(
        delay: Duration(milliseconds: 1500),
        child: FloatingActionButton(
          child: Icon(Icons.sync_rounded),
          backgroundColor: OmniventColors.naranja,
          onPressed: () {
            cargarInformacion();
          },
        ),
      ),
      body: Stack(
        children: [
          SliverCustom(
              title: 'Precio de Productos',
              subtitle: 'Lista de Precio por Producto',
              iconTitle: Icons.attach_money_rounded,
              icon: Icons.arrow_back_ios,
              onTapIcon: () {
                Navigator.of(context).pop();
              },
              minHeight: 210,
              maxHeight: 210,
              sliverChild: Container(
                height: 45,
                child: CupertinoTextField(
                  controller: _controllerBuscar,
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  placeholder: '¿Que estas buscando?',
                  prefix: Container(
                      padding: EdgeInsets.only(left: 20, right: 10),
                      child: Icon(Icons.search, color: Colors.black45)),
                  onChanged: (valor) {
                    print("Buscando: $valor");
                    buscarInformacion(valor);
                  },
                ),
              ),
              child: _ContentSales(precios: preciosProvider.precios)),
        ],
      ),
    );
  }
}

class _ContentSales extends StatelessWidget {
  final List<PrecioModel> precios;

  const _ContentSales({@required this.precios});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: (precios != null)
            ? Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: precios.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Dismissible(
                        background: Container(
                          color: Colors.red,
                        ),
                        key: GlobalKey(),
                        child: Column(
                          children: [
                            ListTile(
                              leading: FadeInImage(
                                  placeholder:
                                      AssetImage('assets/cargando.gif'),
                                  image: AssetImage(
                                      'assets/imagen_no_disponible.png')),
                              title: Text(precios[index].productoDescripcion),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      '${precios[index].listaPrecio} \nCB: ${(precios[index].productoCodigoBarras != null) ? precios[index].productoCodigoBarras : 'Sin Codigo'}'),
                                  SizedBox(height: 3),
                                  Row(
                                    children: [
                                      Text(
                                          'c/i: \$${precios[index].lipDetConIva.toStringAsFixed(2)}'),
                                      SizedBox(width: 10),
                                      Text(
                                          's/i: \$${precios[index].lipDetSinIva.toStringAsFixed(2)}'),
                                    ],
                                  ),
                                ],
                              ),
                              isThreeLine: false,
                            ),
                            Divider()
                          ],
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 10)
                ],
              )
            : Center(
                child: Container(
                child: Text('Cargando...'),
              )));
  }
}
