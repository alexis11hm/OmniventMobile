import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:omnivent_app_wireframe/omnivent_state_managment/domain/provider/ConfiguracionProvider.dart';
import 'package:omnivent_app_wireframe/omnivent_state_managment/domain/storage/secure_storage.dart';
import 'package:omnivent_app_wireframe/omnivent_state_managment/presentation/home/configuration/service_route/service_route_screen.dart';
import 'package:omnivent_app_wireframe/omnivent_state_managment/presentation/login/login_screen.dart';
import 'package:omnivent_app_wireframe/omnivent_state_managment/presentation/widgets/alert_dialogs.dart';
import 'package:omnivent_app_wireframe/omnivent_state_managment/presentation/widgets/sliver_custom.dart';
import 'package:provider/provider.dart';

class ConfigurationHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    

    return ChangeNotifierProvider(
      create: (_) => new ConfiguracionProvider(),
      child: _SliverCustom());
  }
}

class _SliverCustom extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {

    final configuracionProvider = Provider.of<ConfiguracionProvider>(context);

    final secure = SecureStorage();
    final almacenamiento = secure.crearAlmacenamiento();

    leerDato() async{
      await almacenamiento.read(key: 'rutaAPI').then((ruta) => {
      configuracionProvider.rutaServicio = ruta,
      });
    }

    leerDato();

    final optionStyle = TextStyle(fontSize: 17, fontWeight: FontWeight.w300);

    return SliverCustom(
      title: 'Configuración',
      subtitle: 'Configura tu aplicación',
      icon: Icons.menu,
      iconTitle: Icons.settings,
      maxHeight: 160,
      minHeight: 160,
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Text(
                'Tu Configuracion',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                'En esta pantalla podrás gestionar la configuración de la aplicación',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
              ),
              SizedBox(height: 20),
              Text(
                'SERVICIO',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Ruta Servicio', style: optionStyle),
                  InkWell(
                    child: Text(
                      '${(configuracionProvider.rutaServicio.length <= 20) ? configuracionProvider.rutaServicio : configuracionProvider.rutaServicio.substring(0,20)}',
                      style: optionStyle,
                    ),
                    onTap: () => Navigator.of(context).push(CupertinoPageRoute(
                        builder: (_) => ServiceRouteScreen(
                          rutaServicio: configuracionProvider.rutaServicio,
                        ))),
                  )
                ],
              ),
              SizedBox(height: 20),
              Text(
                'AYUDA Y CONTACTO',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Centro de ayuda', style: optionStyle),
                  Icon(Icons.chevron_right, color: Colors.grey)
                ],
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Deja una reseña', style: optionStyle),
                  Icon(Icons.chevron_right, color: Colors.grey)
                ],
              ),
              SizedBox(height: 20),
              Text(
                'OTROS',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Condiciones generales', style: optionStyle),
                  Icon(Icons.chevron_right, color: Colors.grey)
                ],
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Política de privacidad', style: optionStyle),
                  Icon(Icons.chevron_right, color: Colors.grey)
                ],
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    child: Text(
                      'Cerrar Sesión',
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w400,
                          color: Colors.red),
                    ),
                    onTap: () => showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) {
                          return CustomAlertDialog(
                              titulo: 'Cerrar Sesión',
                              contenido: [
                                Text('¿Estas seguro de cerrar sesión?'),
                                SizedBox(height: 20),
                                SvgPicture.asset(
                                  'assets/close/salir.svg',
                                  width: 150,
                                  height: 150,
                                  placeholderBuilder: (BuildContext context) {
                                    return Image.asset(
                                      'assets/cargando.gif',
                                      width: 100,
                                      height: 100,
                                    );
                                  },
                                ),
                              ],
                              botones: [
                                FlatButton(
                                  child: Text('Aceptar'),
                                  onPressed: () => Navigator.of(context)
                                      .pushReplacement(CupertinoPageRoute(
                                          builder: (_) => LoginScreen())),
                                ),
                                FlatButton(
                                  child: Text('Cancelar'),
                                  onPressed: () => Navigator.of(context).pop(),
                                )
                              ]);
                        }),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Versión 1.0.0 OmniventMovil', style: optionStyle)
                ],
              ),
              SizedBox(height: 100)
            ],
          ),
        ),
      ),
    );
  }
}
