import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:omnivent_app_wireframe/omnivent_state_managment/colors.dart';
import 'package:omnivent_app_wireframe/omnivent_state_managment/domain/model/VentaModel.dart';
import 'package:omnivent_app_wireframe/omnivent_state_managment/presentation/login/login_screen.dart';
import 'package:omnivent_app_wireframe/omnivent_state_managment/presentation/widgets/alert_dialogs.dart';
import 'package:omnivent_app_wireframe/omnivent_state_managment/presentation/widgets/sliver_custom.dart';

import 'package:omnivent_app_wireframe/omnivent_state_managment/data/service/VentasService.dart';

import 'package:omnivent_app_wireframe/omnivent_state_managment/domain/storage/secure_storage.dart';

import 'package:provider/provider.dart';

import 'package:omnivent_app_wireframe/omnivent_state_managment/domain/provider/VentasProvider.dart';

class SalesManageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => new VentasProvider(), child: _Scaffold());
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
    final ventasService = VentasService();
    final secure = SecureStorage();
    final almacenamiento = secure.crearAlmacenamiento();
    final ventasProvider = Provider.of<VentasProvider>(context);

    cargarInformacion() {
      almacenamiento.read(key: 'token').then((token) => {
            ventasService.ObtenerVentas(token).then((respuesta) => {
                  if (respuesta.estatus == 200)
                    {
                      print('Ventas'),
                      ventasProvider.ventas = respuesta.respuesta,
                      ventasProvider.ventasBuscar = respuesta.respuesta,
                      ventasProvider.cargarInformacion = 0
                    }
                  else if (respuesta.estatus == 401)
                    {_mostrarAlerta()}
                  else
                    {
                      ventasProvider.ventas = null,
                      ventasProvider.ventasBuscar = null,
                      ventasProvider.cargarInformacion = 0
                    }
                })
          });
    }

    buscarInformacion(String buscar) {
      final List<VentaModel> listaVentas = ventasProvider.ventasBuscar
          .where((venta) =>
              venta.sucursal.toLowerCase().contains(buscar.toLowerCase()) ||
              venta.listaPrecios.toLowerCase().contains(buscar.toLowerCase()) ||
              venta.vendedor.toLowerCase().contains(buscar.toLowerCase()) ||
              venta.vtaEstatus.toLowerCase().contains(buscar.toLowerCase()) ||
              venta.vtaFecha.toLowerCase().contains(buscar.toLowerCase()) ||
              venta.vtaFolioVenta
                  .toString()
                  .toLowerCase()
                  .contains(buscar.toLowerCase()) ||
              venta.vtaId
                  .toString()
                  .toLowerCase()
                  .contains(buscar.toLowerCase()) ||
              venta.vtaTotal
                  .toString()
                  .toLowerCase()
                  .contains(buscar.toLowerCase()))
          .toList();

      ventasProvider.ventas = listaVentas;
      print('Se realizo la llamada: ${listaVentas.length}');
    }

    if (ventasProvider.cargarInformacion == 1) {
      cargarInformacion();
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.sync_rounded),
        backgroundColor: OmniventColors.naranja,
        onPressed: () {
          cargarInformacion();
        },
      ),
      body: Stack(
        children: [
          SliverCustom(
              title: 'Administracion de Ventas',
              subtitle: 'Verificar ventas',
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
                  /*suffix: Padding(
                  padding: EdgeInsets.only(right: 20.0),
                  child: InkWell(
                      onTap: (){
                        _controllerBuscar.text = 'e';
                      },
                      child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(30)
                      ),
                      child: Icon(Icons.close),
                    ),
                  ),
                ),*/
                  onChanged: (valor) {
                    print("Buscando: $valor");
                    buscarInformacion(valor);
                  },
                ),
              ),
              child: _ContentSales(ventas: ventasProvider.ventas)),
        ],
      ),
    );
  }
}

class _ContentSales extends StatelessWidget {
  final List<VentaModel> ventas;

  const _ContentSales({@required this.ventas});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: (ventas != null)
            ? Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: ventas.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        elevation: 5,
                        margin:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        child: Container(
                          padding: EdgeInsets.all(15),
                          height: 270,
                          child: Column(
                            children: [
                              Text(ventas[index].sucursal,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18)),
                              SizedBox(height: 10),
                              Divider(),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Folio: ${ventas[index].vtaFolioVenta}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 15)),
                                  Text(ventas[index].vtaFecha,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 15))
                                ],
                              ),
                              SizedBox(height: 10),
                              Text(
                                  '${(ventas[index].vendedor != null) ? ventas[index].vendedor : 'Sin Vendedor'}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16)),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Subtotal',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 15)),
                                  Text('\$ 0.0',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 15))
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Descuento',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 15)),
                                  Text('\$ 0.0',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 15))
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('IVA',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 15)),
                                  Text('\$ 0.0',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 15))
                                ],
                              ),
                              Divider(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Total',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 15)),
                                  Text('\$${ventas[index].vtaTotal}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          color: Colors.green,
                                          fontSize: 15))
                                ],
                              ),
                              SizedBox(height: 30),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Estatus: ${ventas[index].vtaEstatus}'),
                                  Text(
                                      '${(ventas[index].listaPrecios != null) ? ventas[index].listaPrecios : 'Sin Lista de Precios'}')
                                ],
                              )
                            ],
                          ),
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
      child: Text(
        'Filtrar',
        style: TextStyle(color: Colors.white),
      ),
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
                          'Filtrar Ventas',
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
                        Row(
                          children: [
                            Checkbox(value: false, onChanged: (value) {}),
                            Text(
                              'Cliente',
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
                            DropdownMenuItem(child: Text('1 - Daniel')),
                            DropdownMenuItem(child: Text('2 - Fernando')),
                            DropdownMenuItem(child: Text('3 - Jaime'))
                          ], onChanged: (value) {}),
                        ),
                        Row(
                          children: [
                            Checkbox(value: false, onChanged: (value) {}),
                            Text(
                              'Tipo de Venta',
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
                            DropdownMenuItem(child: Text('Ventas de Contado')),
                            DropdownMenuItem(child: Text('Ventas de Credito')),
                            DropdownMenuItem(child: Text('Ventas Canceladas'))
                          ], onChanged: (value) {}),
                        ),
                        Row(
                          children: [
                            Checkbox(value: false, onChanged: (value) {}),
                            Text(
                              'Usuario',
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
                                child: Text('1 - Administrador Omnisoft')),
                            DropdownMenuItem(
                                child: Text('2 - Albert Einstein')),
                            DropdownMenuItem(
                                child: Text('3 - Alejandro Fernandez'))
                          ], onChanged: (value) {}),
                        ),
                        RaisedButton(
                            elevation: 5,
                            child: Text('Filtrar',
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
