import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:omnivent_app_wireframe/omnivent_state_managment/colors.dart';
import 'package:omnivent_app_wireframe/omnivent_state_managment/presentation/login/login_screen.dart';
import 'package:omnivent_app_wireframe/omnivent_state_managment/presentation/widgets/alert_dialogs.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Container(
          height: double.infinity,
          child: Stack(
            children: [
              _BackgroundFrameHeader(),
              _FrameHeaderContent(),
              _DataCardProfile(),
            ],
          ),
        ),
      ),
    );
  }
}

class _DataCardProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 240),
        Card(
          margin: EdgeInsets.symmetric(horizontal: 30),
          elevation: 2,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(100))),
            width: double.infinity,
            height: 280,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Informacion del Usuario',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 30),
                  Text('Nombre: Gustavo Diaz',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w300)),
                  SizedBox(height: 10),
                  Text('Perfil: Gerente de Almacen',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w300)),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Modo Obscuro'),
                      Switch(value: false, onChanged: (value) {}),
                    ],
                  ),
                  SizedBox(height: 10),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: FlatButton.icon(
                        onPressed: () {
                          showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (context) {
                                return CustomAlertDialog(
                                    titulo: 'Cerrar Sesión',
                                    contenido: [
                                      Text('¿Estas seguro de cerrar sesión?'),
                                      SvgPicture.asset(
                                        'assets/close/salir.svg',
                                        width: 120,
                                        height: 120,
                                        placeholderBuilder:
                                            (BuildContext context) {
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
                                        onPressed: () =>
                                            Navigator.of(context).pop(),
                                      )
                                    ]);
                              });
                        },
                        icon: Icon(
                          Icons.logout,
                          color: Colors.white,
                        ),
                        label: Text(
                          'Salir',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        color: OmniventColors.azulMarino),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _FrameHeaderContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Positioned(
      top: 40,
      left: (size.width * 0.5) - 50,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              width: 100,
              height: 100,
              child: Stack(
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset('assets/profile/profile.jpg')),
                  Positioned(
                    left: 20,
                    bottom: 0,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      child: IconButton(
                        icon: Icon(Icons.camera_alt,
                            color: OmniventColors.azulAcento),
                        onPressed: () {},
                      ),
                    ),
                  )
                ],
              )),
          SizedBox(
            height: 30,
          ),
          Text(
            'Usuario',
            style: TextStyle(
                color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            'Cargo',
            style: TextStyle(
              color: Colors.white54,
              fontSize: 15,
            ),
          )
        ],
      ),
    );
  }
}

class _BackgroundFrameHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      height: 250,
      width: double.infinity,
      decoration: BoxDecoration(
          color: OmniventColors.azulMarino,
          borderRadius: BorderRadius.all(Radius.circular(30))),
      child: CustomPaint(
        painter: ProfileCustomPainter(),
      ),
    );
  }
}

class ProfileCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();

    paint.strokeWidth = 5;
    paint.color = OmniventColors.azulAcento;
    paint.style = PaintingStyle.fill;

    final path = Path();

    path.moveTo(0, size.height * 0.5);
    path.lineTo(size.width * 0.2, size.height * 0.6);
    path.quadraticBezierTo(size.width * 0.23, size.height * 0.64,
        size.height * 0.3, size.height * 0.7);
    path.lineTo(size.width * 0.15, size.height);
    path.lineTo(0, size.height);

    path.moveTo(size.width * 0.8, 0);
    path.lineTo(size.width * 0.75, size.height * 0.3);
    path.quadraticBezierTo(size.width * 0.75, size.height * 0.38,
        size.width * 0.85, size.height * 0.4);
    path.lineTo(size.width, size.height * 0.45);
    path.lineTo(size.width, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
