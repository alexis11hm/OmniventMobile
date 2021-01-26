import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:omnivent_app_wireframe/omnivent_state_managment/colors.dart';
import 'package:omnivent_app_wireframe/omnivent_state_managment/presentation/home/operations/sales/products_sales/products_sales_details/products_sales_details_screen.dart';
import 'package:omnivent_app_wireframe/omnivent_state_managment/presentation/login/login_screen.dart';
import 'package:omnivent_app_wireframe/omnivent_state_managment/presentation/widgets/alert_dialogs.dart';
import 'package:omnivent_app_wireframe/omnivent_state_managment/presentation/widgets/sliver_custom.dart';
import 'package:omnivent_app_wireframe/omnivent_state_managment/domain/provider/VentasDetalleProvider.dart';

import 'package:omnivent_app_wireframe/omnivent_state_managment/data/service/VentasDetalleService.dart';
import 'package:provider/provider.dart';

import 'package:omnivent_app_wireframe/omnivent_state_managment/domain/model/VentaDetalleModel.dart';

import 'package:omnivent_app_wireframe/omnivent_state_managment/domain/storage/secure_storage.dart';

class ProductsSalesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => new VentasDetalleProvider(), child: _Scaffold());
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
    final ventasDetalleService = VentasDetalleService();
    final secure = SecureStorage();
    final almacenamiento = secure.crearAlmacenamiento();
    final ventasDetalleProvider = Provider.of<VentasDetalleProvider>(context);

    cargarInformacion() {
      almacenamiento.read(key: 'token').then((token) => {
            ventasDetalleService.ObtenerVentasDetalle(token)
                .then((respuesta) => {
                      if (respuesta.estatus == 200)
                        {
                          print('Ventas Detalle'),
                          ventasDetalleProvider.ventasDetalle =
                              respuesta.respuesta,
                          ventasDetalleProvider.ventasDetalleBuscar =
                              respuesta.respuesta,
                          ventasDetalleProvider.cargarInformacion = 0
                        }
                      else if (respuesta.estatus == 401)
                        {_mostrarAlerta()}
                      else
                        {
                          ventasDetalleProvider.ventasDetalle = null,
                          ventasDetalleProvider.ventasDetalleBuscar = null,
                          ventasDetalleProvider.cargarInformacion = 0
                        }
                    })
          });
    }

    buscarInformacion(String buscar) {
      final List<VentaDetalleModel> listaVentasDetalle = ventasDetalleProvider
          .ventasDetalleBuscar
          .where((ventaDetalle) =>
              ventaDetalle.producto
                  .toLowerCase()
                  .contains(buscar.toLowerCase()) ||
              ventaDetalle.venta.toLowerCase().contains(buscar.toLowerCase()) ||
              ventaDetalle.vedDescuento
                  .toString()
                  .toLowerCase()
                  .contains(buscar.toLowerCase()) ||
              ventaDetalle.vedPrecio
                  .toString()
                  .toLowerCase()
                  .contains(buscar.toLowerCase()) ||
              ventaDetalle.vedCantidad
                  .toString()
                  .toLowerCase()
                  .contains(buscar.toLowerCase()))
          .toList();

      ventasDetalleProvider.ventasDetalle = listaVentasDetalle;
      print('Se realizo la llamada: ${listaVentasDetalle.length}');
    }

    if (ventasDetalleProvider.cargarInformacion == 1) {
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
              title: 'Venta de Productos',
              subtitle: 'Verificar ventas de Productos',
              iconTitle: FontAwesome.check,
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
                  )),
              child: _ContentSales(
                  ventasDetalle: ventasDetalleProvider.ventasDetalle)),
        ],
      ),
    );
  }
}

class _ContentSales extends StatelessWidget {
  final List<VentaDetalleModel> ventasDetalle;

  const _ContentSales({@required this.ventasDetalle});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: (ventasDetalle != null)
            ? Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: ventasDetalle.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Dismissible(
                        background: Container(
                          color: Colors.red,
                        ),
                        key: GlobalKey(),
                        child: Column(
                          children: [
                            ListTile(
                                onTap: () => Navigator.of(context).push(
                                    CupertinoPageRoute(
                                        builder: (BuildContext context) =>
                                            ProductsSalesDetailsScreen(
                                              ventaDetalle:
                                                  ventasDetalle[index],
                                            ))),
                                leading:FadeInImage(
                                      placeholder:
                                          AssetImage('assets/cargando.gif'),
                                      image: AssetImage(
                                          'assets/imagen_no_disponible.png')),
                                
                                title: Text(ventasDetalle[index].producto),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(ventasDetalle[index].venta),
                                    SizedBox(height: 3),
                                    Row(
                                      children: [
                                        Text(
                                            'Precio: \$${ventasDetalle[index].vedPrecio}'),
                                        SizedBox(width: 10),
                                        Text(
                                            'Cantidad: ${ventasDetalle[index].vedCantidad}'),
                                      ],
                                    ),
                                  ],
                                ),
                                isThreeLine: false,
                                trailing: Icon(Icons.arrow_forward_ios)),
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 60),
                    CircularProgressIndicator(
                      backgroundColor: Colors.orange,
                    ),
                    SizedBox(height: 20),
                    Text('Cargando...'),
                  ],
                ),
              ));
  }
}

class _BotonFiltrar extends StatelessWidget {
  final DateTime selectedDate = DateTime.now();

  Future<void> _selectInitialDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    /* if (picked != null && picked != selectedDate)
        selectedDate = picked;
      } */
  }

  Future<void> _selectFinalDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    /* if (picked != null && picked != selectedDate)
        selectedDate = picked;
      } */
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return RaisedButton(
      color: OmniventColors.azulAcento,
      child: Text('Filtrar', style: TextStyle(color: Colors.white)),
      onPressed: () => showCupertinoModalBottomSheet(
          isDismissible: true,
          barrierColor: Colors.black.withOpacity(0.6),
          context: context,
          builder: (BuildContext context) {
            return Container(
              height: 500,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Scaffold(
                  body: SingleChildScrollView(
                    child: Column(
                      children: [
                        Text(
                          'Filtrar Ventas de Productos',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Divider(),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Checkbox(value: false, onChanged: (value) {}),
                            Text(
                              'Definir Periodo',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              'F. Inicial',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            Text('10/12/2020'),
                            RaisedButton.icon(
                                color: OmniventColors.azulMarino,
                                icon: Icon(Icons.calendar_today_outlined,
                                    color: Colors.white),
                                label: Text(
                                  'Seleccionar',
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () {
                                  _selectInitialDate(context);
                                })
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              'F. Final',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            Text('12/12/2020'),
                            RaisedButton.icon(
                                color: OmniventColors.azulMarino,
                                icon: Icon(Icons.calendar_today_outlined,
                                    color: Colors.white),
                                label: Text(
                                  'Seleccionar',
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () {
                                  _selectFinalDate(context);
                                })
                          ],
                        ),
                        Row(
                          children: [
                            Checkbox(value: false, onChanged: (value) {}),
                            Text(
                              'Sucursal',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          width: size.width,
                          child: DropdownButton(items: <DropdownMenuItem>[
                            DropdownMenuItem(
                                child: Text('Almacenes la Mexicana')),
                            DropdownMenuItem(child: Text('Almacenes el Sur')),
                            DropdownMenuItem(child: Text('Almacenes Juan'))
                          ], onChanged: (value) {}),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Cliente',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          width: size.width,
                          child: DropdownButton(items: <DropdownMenuItem>[
                            DropdownMenuItem(
                                child:
                                    Text('P.V. por Fecha, F. Venta y Corte')),
                            DropdownMenuItem(
                                child: Text('P.V. por Fecha y Producto'))
                          ], onChanged: (value) {}),
                        ),
                        RaisedButton(
                            elevation: 5,
                            child: Text('Filtar',
                                style: TextStyle(color: Colors.white)),
                            color: OmniventColors.azulAcento,
                            onPressed: () {})
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
