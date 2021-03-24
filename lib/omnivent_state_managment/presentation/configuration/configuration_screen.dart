import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:omnivent_app_wireframe/omnivent_state_managment/colors.dart';
import 'package:omnivent_app_wireframe/omnivent_state_managment/domain/storage/secure_storage.dart';
import 'package:omnivent_app_wireframe/omnivent_state_managment/presentation/login/login_screen.dart';
import 'package:omnivent_app_wireframe/omnivent_state_managment/presentation/widgets/alert_dialogs.dart';
import 'package:omnivent_app_wireframe/omnivent_state_managment/presentation/widgets/headers_wave.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

class ConfigurationScreen extends StatefulWidget {

  @override
  _ConfigurationScreenState createState() => _ConfigurationScreenState();
}

class _ConfigurationScreenState extends State<ConfigurationScreen> {

  final controladorRuta = TextEditingController();

  bool tieneRelacion(String ruta) {
    RegExp expression =
        new RegExp(r'(?:(?:https?|ftp):\/\/)?[\w/\-?=%.]+\.[\w/\-?=%.]+');
    return expression.hasMatch(ruta);
  }

  @override
  void dispose() {
    controladorRuta?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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

    final secure = SecureStorage();
    final almacenamiento = secure.crearAlmacenamiento();

    final size = MediaQuery.of(context).size;
    final containerSize = size.width * 0.8;

    return Scaffold(
      floatingActionButton: Bounce(
        delay: Duration(milliseconds: 1500),
        child: FloatingActionButton(
          child: Icon(Icons.check),
          backgroundColor: OmniventColors.naranja,
          onPressed: () {
            final ruta = controladorRuta.text.toString();
            mostrarAlerta('Configuración', [
              SizedBox(height: 20),
              CircularProgressIndicator(),
              SizedBox(height: 30),
              Text(
                'Cargando...',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
              )
            ], []);
            if (ruta.isNotEmpty) {
              if (tieneRelacion(ruta)) {
                Future.delayed(Duration(seconds: 4), () {

                  secure.escribirValorAlmacenamiento(almacenamiento,
                              'rutaAPI', ruta);

                  almacenamiento.write(key: 'slider', value: 'noshow');

                  Navigator.of(context).pushReplacement(
                      CupertinoPageRoute(builder: (_) => LoginScreen()));
                });
              } else {
                Navigator.of(context).pop();
                mostrarAlerta('Configuración', [
                  SizedBox(height: 10),
                  Text(
                    'La ruta parece no tener un patron valido de dominio',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
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
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
                )
              ], [
                FlatButton(
                  child: Text('Aceptar'),
                  onPressed: () => Navigator.of(context).pop(),
                )
              ]);
            }
          }
          /*Navigator.of(context)
              .pushReplacement(CupertinoPageRoute(builder: (_) => LoginScreen()))*/
          ,
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              HeaderAndFooterWave(),
              Positioned(
                  left: (size.width / 2) - (containerSize / 2),
                  top: size.height * 0.28,
                  child: Container(
                    width: containerSize,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Configuracion Inicial',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Antes de iniciar la aplicacion es necesario agregar una configuracion, por lo que te recomendamos que pidas al proveedor de este producto que configure la aplicación por ti, de otra manera, puede que no funcione de manera correcta la aplicación.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w300),
                        ),
                        SizedBox(height: 40),
                        Text(
                          'Dirección del Servicio',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
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
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
