import 'package:flutter/material.dart';
import 'package:omnivent_app_wireframe/omnivent_state_managment/colors.dart';
import 'package:omnivent_app_wireframe/omnivent_state_managment/domain/provider/ConfiguracionProvider.dart';
import 'package:omnivent_app_wireframe/omnivent_state_managment/domain/storage/secure_storage.dart';
import 'package:omnivent_app_wireframe/omnivent_state_managment/presentation/widgets/alert_dialogs.dart';
import 'package:provider/provider.dart';

class ServiceRouteScreen extends StatelessWidget {

  final String rutaServicio;

  const ServiceRouteScreen({@required this.rutaServicio});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => new ConfiguracionProvider(),
      child: _Scaffold(rutaServicio: rutaServicio));
  }
}

class _Scaffold extends StatefulWidget {

  final String rutaServicio;

  const _Scaffold({@required this.rutaServicio});

  @override
  __ScaffoldState createState() => __ScaffoldState();
}

class __ScaffoldState extends State<_Scaffold> {

  final controladorRuta = TextEditingController();

  bool tieneRelacion(String ruta) {
    RegExp expression =
        new RegExp(r'(?:(?:https?|ftp):\/\/)?[\w/\-?=%.]+\.[\w/\-?=%.]+');
    return expression.hasMatch(ruta);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    controladorRuta?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final secure = SecureStorage();
    final almacenamiento = secure.crearAlmacenamiento();
    final configuracionProvider = Provider.of<ConfiguracionProvider>(context);

    controladorRuta.text = widget.rutaServicio;

    void mostrarAlerta(
        String titulo, List<Widget> contenido, List<Widget> botones) {
      showDialog(
          context: context,
          barrierDismissible: true,
          builder: (context) {
            return CustomAlertDialog(
                titulo: titulo, contenido: contenido, botones: botones);
          });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Configuracion del Servicio'),
        backgroundColor: OmniventColors.azulMarino,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Establece la ruta del Servicio',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      '¡ADVERTENCIA!',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.red),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Te recomendamos no editar esta propiedad, a menos de que seas el proveedor de este producto.',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
                    ),
                    SizedBox(height: 40),
                    Text(
                      'Dirección del Servicio',
                      textAlign: TextAlign.start,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      controller: controladorRuta,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                        labelText: 'Dirección',
                        hintText: 'https://www.myshop.com/...',
                        prefixIcon: Icon(Icons.link),
                      ),
                    ),
                    SizedBox(height: 30),
                    RaisedButton(
                        child: Text('Guardar Cambios',
                            style: TextStyle(color: Colors.white)),
                        color: OmniventColors.azulMarino,
                        onPressed: () {
                          final ruta = controladorRuta.text.toString();
                          mostrarAlerta('Configuración', [
                            SizedBox(height: 20),
                            CircularProgressIndicator(),
                            SizedBox(height: 30),
                            Text(
                              'Cargando...',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w300),
                            )
                          ], []);
                          if (ruta.isNotEmpty) {
                            if (tieneRelacion(ruta)) {
                              Future.delayed(Duration(seconds: 4), () {
                                secure.escribirValorAlmacenamiento(
                                    almacenamiento, 'rutaAPI', ruta);
                                configuracionProvider.rutaServicio = ruta;
                                Navigator.of(context).pop();
                                Navigator.of(context).pop();
                              });
                            } else {
                              Navigator.of(context).pop();
                              mostrarAlerta('Configuración', [
                                SizedBox(height: 10),
                                Text(
                                  'La ruta parece no tener un patron valido de dominio',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w300),
                                )
                              ], [
                                FlatButton(
                                  child: Text('Aceptar'),
                                  onPressed: () => Navigator.of(context).pop(),
                                )
                              ]);
                            }
                          } else {
                            Navigator.of(context).pop();
                            mostrarAlerta('Configuración', [
                              SizedBox(height: 10),
                              Text(
                                'No se ha especificado alguna ruta, intentalo de nuevo',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w300),
                              )
                            ], [
                              FlatButton(
                                child: Text('Aceptar'),
                                onPressed: () => Navigator.of(context).pop(),
                              )
                            ]);
                          }
                        })
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
