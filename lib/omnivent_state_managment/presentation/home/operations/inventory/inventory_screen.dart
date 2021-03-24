import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';
//import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:omnivent_app_wireframe/omnivent_state_managment/colors.dart';
import 'package:omnivent_app_wireframe/omnivent_state_managment/data/service/AlmacenProductoService.dart';
import 'package:omnivent_app_wireframe/omnivent_state_managment/domain/model/AlmacenProductoModel.dart';
import 'package:omnivent_app_wireframe/omnivent_state_managment/domain/provider/AlmacenProductoProvider.dart';
import 'package:omnivent_app_wireframe/omnivent_state_managment/domain/storage/secure_storage.dart';
import 'package:omnivent_app_wireframe/omnivent_state_managment/presentation/login/login_screen.dart';
import 'package:omnivent_app_wireframe/omnivent_state_managment/presentation/widgets/alert_dialogs.dart';
import 'package:omnivent_app_wireframe/omnivent_state_managment/presentation/widgets/sliver_custom.dart';
import 'package:provider/provider.dart';

class InventoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return ChangeNotifierProvider(
        create: (_) => new AlmacenProductoProvider(), child: _Scaffold());
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

  @override
  Widget build(BuildContext context) {
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

    final almacenProductoService = AlmacenProductoService();
    final secure = SecureStorage();
    final almacenamiento = secure.crearAlmacenamiento();
    final almacenProductoProvider =
        Provider.of<AlmacenProductoProvider>(context);

    cargarInformacion() {
      almacenamiento.read(key: 'token').then((token) => {
            almacenamiento.read(key: 'rutaAPI').then((ruta) => {
                  almacenProductoService.ObtenerAlmacenProductos(token, ruta)
                      .then((respuesta) => {
                            if (respuesta.estatus == 200)
                              {
                                print('almacen productos'),
                                almacenProductoProvider.almacenProductos =
                                    respuesta.respuesta,
                                almacenProductoProvider.almacenProductosBuscar =
                                    respuesta.respuesta,
                                almacenProductoProvider.cargarInformacion = 0,
                                print(
                                    'almacen productos: ${almacenProductoProvider.almacenProductosBuscar.length}')
                              }
                            else if (respuesta.estatus == 401)
                              {_mostrarAlerta()}
                            else
                              {
                                almacenProductoProvider.almacenProductos = null,
                                almacenProductoProvider.almacenProductosBuscar =
                                    null,
                                almacenProductoProvider.cargarInformacion = 0
                              }
                          })
                })
          });
    }

    buscarInformacion(String buscar) {
      final List<AlmacenProductoModel> listaAlmacenProductos =
          almacenProductoProvider.almacenProductosBuscar
              .where((almacen) =>
                  almacen.proId
                      .toString()
                      .toLowerCase()
                      .contains(buscar.toLowerCase()) ||
                  almacen.productoDescripcion
                      .toString()
                      .toLowerCase()
                      .contains(buscar.toLowerCase()) ||
                  almacen.productoIdentificacion
                      .toString()
                      .toLowerCase()
                      .contains(buscar.toLowerCase()) ||
                  almacen.sucursal.toLowerCase().contains(buscar.toLowerCase()))
              .toList();

      almacenProductoProvider.almacenProductos = listaAlmacenProductos;
      print('Se realizo la llamada: ${listaAlmacenProductos.length}');
    }

    if (almacenProductoProvider.cargarInformacion == 1) {
      cargarInformacion();
    }

    return Scaffold(
      body: Stack(
        children: [
          SliverCustom(
              title: 'Inventario',
              subtitle: 'Verificar Inventario',
              iconTitle: Icons.inventory,
              icon: Icons.arrow_back_ios,
              onTapIcon: () {
                Navigator.of(context).pop();
              },
              minHeight: 220,
              maxHeight: 220,
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
              child: _ContentSales(
                  almacenProductos: almacenProductoProvider.almacenProductos)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.sync_rounded, color: Colors.white),
        backgroundColor: OmniventColors.naranja,
        onPressed: () {
          cargarInformacion();
        },
      ),
    );
  }
}

class _ContentSales extends StatelessWidget {
  final List<AlmacenProductoModel> almacenProductos;

  _ContentSales({this.almacenProductos});

  @override
  Widget build(BuildContext context) {
    final _textStyle = TextStyle(fontWeight: FontWeight.w400, fontSize: 13);

    return ( almacenProductos != null || almacenProductos.length != 0)
        ? Container(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: almacenProductos.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Stack(
                        children: [
                          Card(
                            elevation: 5,
                            child: Container(
                              padding: EdgeInsets.all(10),
                              height: 185,
                              child: Row(
                                children: [
                                  FadeInImage(
                                      width: 120,
                                      height: 120,
                                      placeholder:
                                          AssetImage('assets/cargando.gif'),
                                      image: AssetImage(
                                          'assets/imagen_no_disponible.png')),
                                  SizedBox(width: 0),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 5),
                                      Text(almacenProductos[index].sucursal,
                                          style: _textStyle),
                                      SizedBox(height: 5),
                                      Text(
                                        (almacenProductos[index]
                                                    .productoDescripcion
                                                    .length <=
                                                20)
                                            ? almacenProductos[index]
                                                .productoDescripcion
                                            : almacenProductos[index]
                                                    .productoDescripcion
                                                    .substring(0, 20) +
                                                '...',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                          almacenProductos[index]
                                              .productoIdentificacion
                                              .toString(),
                                          style: _textStyle),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                          'Almacen Merma: ${almacenProductos[index].almacenes.almacenMerma}',
                                          style: _textStyle),
                                      SizedBox(height: 5),
                                      Text(
                                          'Almacen General: ${almacenProductos[index].almacenes.almacenGeneral}',
                                          style: _textStyle),
                                      SizedBox(height: 5),
                                      Text(
                                          'Almacen Aguascalientes: ${almacenProductos[index].almacenes.almacnAguascalientes}',
                                          style: _textStyle),
                                      SizedBox(height: 5),
                                      Text(
                                          'Total: ${almacenProductos[index].almacenes.almacenMerma + almacenProductos[index].almacenes.almacenGeneral + almacenProductos[index].almacenes.almacnAguascalientes}',
                                          style: TextStyle(
                                              color: (almacenProductos[index]
                                                              .almacenes
                                                              .almacenMerma +
                                                          almacenProductos[
                                                                  index]
                                                              .almacenes
                                                              .almacenGeneral +
                                                          almacenProductos[
                                                                  index]
                                                              .almacenes
                                                              .almacnAguascalientes >
                                                      0)
                                                  ? Colors.green
                                                  : Colors.red,
                                              fontWeight: FontWeight.bold))
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                color: (almacenProductos[index]
                                                .almacenes
                                                .almacenMerma +
                                            almacenProductos[index]
                                                .almacenes
                                                .almacenGeneral +
                                            almacenProductos[index]
                                                .almacenes
                                                .almacnAguascalientes >
                                        0)
                                    ? Colors.green
                                    : Colors.red,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                              ),
                              child: (almacenProductos[index]
                                              .almacenes
                                              .almacenMerma +
                                          almacenProductos[index]
                                              .almacenes
                                              .almacenGeneral +
                                          almacenProductos[index]
                                              .almacenes
                                              .almacnAguascalientes >
                                      0)
                                  ? Icon(
                                      FontAwesome.check,
                                      color: Colors.white,
                                    )
                                  : Icon(FontAwesome.close,
                                      color: Colors.white),
                            ),
                          )
                        ],
                      );
                    },
                  ),
                  SizedBox(height: 10)
                ],
              ),
            ),
          )
        : Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/close/no_data.svg',
                  width: 100,
                  height: 100,
                  placeholderBuilder: (BuildContext context) {
                    return Image.asset(
                      'assets/cargando.gif',
                      width: 80,
                      height: 80,
                    );
                  },
                ),
                SizedBox(height: 15),
                Text(
                  'No hay informacion sobre esta categoria',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                ),
              ],
            ),
          );
  }
}
