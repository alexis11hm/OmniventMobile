import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:omnivent_app_wireframe/omnivent_state_managment/colors.dart';
import 'package:omnivent_app_wireframe/omnivent_state_managment/data/service/CorteCajasService.dart';
import 'package:omnivent_app_wireframe/omnivent_state_managment/domain/model/CorteCajaModel.dart';
import 'package:omnivent_app_wireframe/omnivent_state_managment/domain/provider/CorteCajasProvider.dart';
import 'package:omnivent_app_wireframe/omnivent_state_managment/domain/storage/secure_storage.dart';
import 'package:omnivent_app_wireframe/omnivent_state_managment/presentation/login/login_screen.dart';
import 'package:omnivent_app_wireframe/omnivent_state_managment/presentation/widgets/alert_dialogs.dart';
import 'package:provider/provider.dart';

class CashClosingScreen extends StatelessWidget {

  
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => new CorteCajasProvider(),
      child: _Scaffold());
  }
}

class _Scaffold extends StatelessWidget {
  
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

    final corteCajasService = CorteCajasService();
    final secure = SecureStorage();
    final almacenamiento = secure.crearAlmacenamiento();
    final corteCajasProvider = Provider.of<CorteCajasProvider>(context);

    cargarInformacion(){
      almacenamiento.read(key: 'token').then((token) => {
          corteCajasService.ObtenerCorteCajas(token).then((respuesta) => {
              if(respuesta.estatus == 200){
                print('Corte Cajas'),
                corteCajasProvider.cortesCaja = respuesta.respuesta,
                corteCajasProvider.cortesCajaBuscar = respuesta.respuesta,
                corteCajasProvider.cargarInformacion = 0
              }else if(respuesta.estatus==401){
                _mostrarAlerta()
              }else{
                corteCajasProvider.cortesCaja = null,
                corteCajasProvider.cortesCajaBuscar = null,
                corteCajasProvider.cargarInformacion = 0
              }
          })
      });
    }

    if(corteCajasProvider.cargarInformacion == 1){
       cargarInformacion();
     }


    return Scaffold(
      floatingActionButton: FloatingActionButton(
      child: Icon(Icons.sync_rounded),
      backgroundColor: OmniventColors.naranja,
      onPressed: (){
        cargarInformacion();
        },
      ),
      appBar: AppBar(
        title: Text('Corte de Cajas'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context, delegate: DataSearch(corteCajasProvider: corteCajasProvider), //query: 'Hola'
              );
            },
          ),
        ],
        backgroundColor: OmniventColors.azulMarino,
      ),
      body: (corteCajasProvider.cortesCaja != null)
            ?
            ListView.builder(
              itemCount: corteCajasProvider.cortesCaja.length,
              itemBuilder: (BuildContext context, int index){
                return Card(
                  margin: EdgeInsets.all(10),
                    elevation: 10,
                    child: Container(
                      padding: EdgeInsets.all(30),
                      width: double.infinity,
                      height: 300,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(corteCajasProvider.cortesCaja[index].sucursal,
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              )),
                              SizedBox(width: 10),
                              Icon(Icons.store_sharp,size: 30,color: OmniventColors.naranja)
                            ],
                          ),
                          Text(corteCajasProvider.cortesCaja[index].fleDescripcion,
                          style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w300,
                              )
                            ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Fecha de Corte:',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              )
                              ),
                              Text(corteCajasProvider.cortesCaja[index].fleFecha,
                                style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w300,
                              )
                              )
                            ],
                          ),
                          SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Referencia:',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              )
                              ),
                              Text((corteCajasProvider.cortesCaja[index].fleReferencia.isNotEmpty)
                                  ? '${(corteCajasProvider.cortesCaja[index].fleReferencia.length >= 20) ? corteCajasProvider.cortesCaja[index].fleReferencia.substring(0,20)+'...' : corteCajasProvider.cortesCaja[index].fleReferencia}'
                                  : 'Sin Referencia'
                                ,
                                style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w300,
                              )
                              )
                            ],
                          ),
                          SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Forma Pago:',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              )
                              ),
                              Text(corteCajasProvider.cortesCaja[index].formaPago,
                                style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w300,
                              )
                              )
                            ],
                          ),
                          SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Observaciones:',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              )
                              ),
                              Text((corteCajasProvider.cortesCaja[index].fleObservaciones.isNotEmpty)
                                    ? '${(corteCajasProvider.cortesCaja[index].fleObservaciones.length >= 20) ? corteCajasProvider.cortesCaja[index].fleObservaciones.substring(0,20)+'...' : corteCajasProvider.cortesCaja[index].fleObservaciones}'
                                    : 'Sin Observaciones'
                                ,
                                style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w300,
                              )
                              )
                            ],
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Importe:',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              )
                              ),
                            Text('\$${corteCajasProvider.cortesCaja[index].fleImporte}',
                                style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: OmniventColors.azulMarino
                              )
                              )
                            ],
                          ),
                          SizedBox(height: 5),
                          Divider(),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Flujo ID: ',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300,
                                  )
                                  ),
                                Text(corteCajasProvider.cortesCaja[index].fleId.toString(),
                                    style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300,
                                    color:  Colors.black
                                  )
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Fop ID: ',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300,
                                  )
                                  ),
                                Text(corteCajasProvider.cortesCaja[index].fopId.toString(),
                                    style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300,
                                    color:  Colors.black
                                            
                                  )
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Tipo Flujo: ',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300,
                                  )
                                  ),
                                Text(corteCajasProvider.cortesCaja[index].fleTipo.toString(),
                                    style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300,
                                    color:  Colors.black
                                            
                                  )
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Cac ID: ',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300,
                                  )
                                  ),
                                Text(corteCajasProvider.cortesCaja[index].cacId.toString(),
                                    style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300,
                                    color:  Colors.black
                                  )
                                  )
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }
              )
            :
          Container()
    );
  }
}

class DataSearch extends SearchDelegate {

  final CorteCajasProvider corteCajasProvider;

  DataSearch({@required this.corteCajasProvider});

  buscarInformacion(String buscar){
      print(buscar);
      final List<CorteCajaModel> listaCorteCajas = corteCajasProvider.cortesCajaBuscar.where(
                          (corteCaja) => 
                          corteCaja.fleDescripcion.toLowerCase().contains(buscar.toLowerCase()) ||
                          //corteCaja.sucursal.toLowerCase().contains(buscar.toLowerCase()) ||
                          corteCaja.fleFecha.toString().toLowerCase().contains(buscar.toLowerCase()) ||
                          corteCaja.fleReferencia.toString().toLowerCase().contains(buscar.toLowerCase()) ||
                          corteCaja.formaPago.toLowerCase().contains(buscar.toLowerCase()) ||
                          corteCaja.fleObservaciones.toLowerCase().contains(buscar.toLowerCase()) ||
                          corteCaja.fleImporte.toString().toLowerCase().contains(buscar.toLowerCase()) ||
                          corteCaja.fleTipo.toLowerCase().contains(buscar.toLowerCase())
                          ).toList();

      corteCajasProvider.cortesCaja = listaCorteCajas;
      print('Se realizo la llamada: ${listaCorteCajas.length}');
    }

  @override
  List<Widget> buildActions(BuildContext context) {

    //LAS ACCIONES DE NUESTRO APPBAR
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
          if(query != null || query.isNotEmpty){
            buscarInformacion(query);
          }
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // ICONO A LA IZQUIERDA DEL APPBAR
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // CREA LOS RESULTADOS QUE VAMOS A MOSTRAR
    return ListView(
            children: corteCajasProvider.cortesCaja.map((corteCaja) => 
              ListTile(
                leading: Hero(
                       tag: corteCaja.fleId,
                       child: FadeInImage(
                       placeholder: AssetImage('assets/cargando.gif'),
                       image: AssetImage('assets/imagen_no_disponible.png'),
                       width: 50.0,
                       fit: BoxFit.contain),
                ),
                title: Text(corteCaja.sucursal??'Sin sucursal'),
                subtitle: Text('${corteCaja.fleDescripcion??'S/Desc.'} \n Imp: ${corteCaja.fleImporte??'S/Imp.'} - Ref: ${corteCaja.fleReferencia??'S/Ref.'}'),
                isThreeLine: false,
                trailing:  Icon(Icons.arrow_forward_ios),
                onTap: () {
                  buscarInformacion('');
                  close(context, null);
                  /*Navigator.of(context).push(
                                CupertinoPageRoute(
                                  builder: (_) => ProductDetailsScreen(
                                    producto: producto,
                                  ),
                                )
                              );*/
                },
              )
            ).toList()
          );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // LAS SUGERENCIAS QUE APARECEN CUANDO LA PERSONA ESCRIBE
    if (query.isEmpty) return Container();
    if(query != null || query.isNotEmpty){
      buscarInformacion(query);
    }
    return (corteCajasProvider.cortesCaja != null) 
            ?
            ListView(
            children: corteCajasProvider.cortesCaja.map((corteCaja) => 
              ListTile(
                leading: Hero(
                       tag: corteCaja.fleId,
                       child: FadeInImage(
                       placeholder: AssetImage('assets/cargando.gif'),
                       image: AssetImage('assets/imagen_no_disponible.png'),
                       width: 50.0,
                       fit: BoxFit.contain),
                ),
                title: Text(corteCaja.sucursal??'Sin sucursal'),
                subtitle: Text('${corteCaja.fleDescripcion??'S/Desc.'} \n Imp: ${corteCaja.fleImporte??'S/Imp.'} - Ref: ${corteCaja.fleReferencia??'S/Ref.'}'),
                isThreeLine: false,
                trailing:  Icon(Icons.arrow_forward_ios),
                onTap: () {
                  buscarInformacion('');
                  close(context, null);
                  /*Navigator.of(context).push(
                                CupertinoPageRoute(
                                  builder: (_) => ProductDetailsScreen(
                                    producto: producto,
                                  ),
                                )
                              );*/
                },
              )
            ).toList()
          )
          :
          Center(
            child: Container(
              child: Text('Escribe para buscar un producto...'),
            ),
          );
  }
}