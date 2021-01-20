import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:omnivent_app_wireframe/omnivent_state_managment/colors.dart';
import 'package:omnivent_app_wireframe/omnivent_state_managment/data/service/LoginService.dart';
import 'package:omnivent_app_wireframe/omnivent_state_managment/domain/model/LoginModel.dart';
import 'package:omnivent_app_wireframe/omnivent_state_managment/domain/storage/secure_storage.dart';
import 'package:omnivent_app_wireframe/omnivent_state_managment/presentation/home/home_screen.dart';
import 'package:omnivent_app_wireframe/omnivent_state_managment/presentation/widgets/alert_dialogs.dart';
import 'package:omnivent_app_wireframe/omnivent_state_managment/presentation/widgets/headers_wave.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width;
    final sizeContainer = 300.0;
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(children: [
          HeaderWaveLogin(),
          _HeaderLogin(size: size, sizeContainer: sizeContainer),
          _TextFields()
        ]),
      ),
    );
  }
}

class _TextFields extends StatefulWidget {
  @override
  __TextFieldsState createState() => __TextFieldsState();
}

class __TextFieldsState extends State<_TextFields> {
  final controladorUsuario = TextEditingController();
  final controladorContrasenia = TextEditingController();

  @override
  void dispose() {
    controladorUsuario?.dispose();
    controladorContrasenia?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loginService = LoginService();
    final secure = SecureStorage();
    final almacenamiento = secure.crearAlmacenamiento();

    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: (size.height / 2) + 20),
          Center(
            child: Text('Identificacion de Usuario',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18)),
          ),
          SizedBox(height: 10),
          Text('Usuario', style: TextStyle(color: Color(0xFF181F35))),
          SizedBox(
            height: 10,
          ),
          TextField(
            controller: controladorUsuario,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              labelText: 'Usuario',
              hintText: 'example',
              prefixIcon: Icon(Icons.person),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text('Contraseña',
              textAlign: TextAlign.start,
              style: TextStyle(color: Color(0xFF181F35))),
          SizedBox(height: 10),
          TextField(
            controller: controladorContrasenia,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              labelText: 'Contraseña',
              prefixIcon: Icon(Icons.lock),
            ),
            obscureText: true,
          ),
          SizedBox(
            height: 25,
          ),
          Center(
            child: InkWell(
              onTap: () {
                final loginModel = new LoginModel();

                loginModel.usuario = controladorUsuario.text.toString();
                loginModel.password = controladorContrasenia.text.toString();

                showDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (context) {
                      return CustomAlertDialog(
                          titulo: 'Iniciando Sesión',
                          contenido: [
                            SizedBox(height: 20),
                            CircularProgressIndicator(
                            ),
                            SizedBox(height: 30),
                            Text('Cargando...',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w300
                              ),
                            )
                          ],
                          botones: []);
                    });
                

                Future.delayed(const Duration(milliseconds: 5000), () {
                  loginService.iniciarSesion(loginModel).then((value) => {
                      if (value.estatus == 200)
                        {
                          secure.escribirValorAlmacenamiento(almacenamiento,
                              'token', 'Bearer ${value.respuesta}'),
                          Navigator.of(context).pushReplacement(
                              CupertinoPageRoute(builder: (_) => HomeScreen()))
                        }
                      else
                        {
                          Navigator.of(context).pop(),
                          showDialog(
                              context: context,
                              barrierDismissible: true,
                              builder: (context) {
                                return CustomAlertDialog(
                                    titulo: 'No fue posible iniciar sesión',
                                    contenido: [
                                      Text((value.respuesta == null ||
                                              value.respuesta
                                                  .toString()
                                                  .isEmpty)
                                          ? 'Verifica tus datos e intentalo de nuevo'
                                          : value.respuesta)
                                    ],
                                    botones: [
                                      FlatButton(
                                        child: Text('Aceptar'),
                                        onPressed: () =>
                                            Navigator.of(context).pop(),
                                      )
                                    ]);
                              }),
                        }
                    });
                });

                
              },
              child: Container(
                width: size.width,
                height: 50,
                decoration: BoxDecoration(
                    color: OmniventColors.azulMarino,
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                child: Center(
                    child: Text(
                  'Iniciar',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                )),
              ),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Center(
            child: Text('Esquema: OmniventMovil', style: TextStyle()),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}

class _HeaderLogin extends StatelessWidget {
  _HeaderLogin({
    @required this.size,
    @required this.sizeContainer,
  });

  final double size;
  final double sizeContainer;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 40,
      left: (size / 2) - (sizeContainer / 2),
      child: Container(
        width: sizeContainer,
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Text(
            'Inicio de Sesión',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w400, fontSize: 30),
          ),
          SizedBox(
            height: 30,
          ),
          SvgPicture.asset(
            'assets/login/login.svg',
            width: 180,
            height: 180,
          ),
        ]),
      ),
    );
  }
}
