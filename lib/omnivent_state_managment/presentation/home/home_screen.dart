import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:omnivent_app_wireframe/omnivent_state_managment/domain/provider/HomeProvider.dart';
import 'package:omnivent_app_wireframe/omnivent_state_managment/domain/storage/secure_storage.dart';
import 'package:omnivent_app_wireframe/omnivent_state_managment/presentation/home/configuration/configuration_home_screen.dart';
import 'package:omnivent_app_wireframe/omnivent_state_managment/presentation/home/operations/operations_screen.dart';
import 'package:omnivent_app_wireframe/omnivent_state_managment/presentation/home/operations/products/product_catalog_screen.dart';
import 'package:omnivent_app_wireframe/omnivent_state_managment/presentation/home/profile/profile_screen.dart';
import 'package:omnivent_app_wireframe/omnivent_state_managment/colors.dart';

import 'package:provider/provider.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => new HomeProvider(), child: _Scaffold(context: context));
  }
}

class _Scaffold extends StatefulWidget {
  final BuildContext context;

  const _Scaffold({@required this.context});

  @override
  __ScaffoldState createState() => __ScaffoldState();
}

class __ScaffoldState extends State<_Scaffold> {
  TutorialCoachMark tutorialCoachMark;

  GlobalKey keyConfiguration = new GlobalKey();
  GlobalKey keyHome = new GlobalKey();
  GlobalKey keyProfile = new GlobalKey();
  GlobalKey keyOperationItem = new GlobalKey();
  GlobalKey keyFieldSearch = new GlobalKey();

  List<TargetFocus> targets = List<TargetFocus>();

  TextStyle estiloEncabezado =
      TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.white);

  TextStyle estiloCuerpo =
      TextStyle(fontWeight: FontWeight.w400, fontSize: 14, color: Colors.white);

  @override
  void initState() {
    final secure = SecureStorage();
    final almacenamiento = secure.crearAlmacenamiento();

    almacenamiento.read(key: 'coachMark').then((cm) {
      if(cm == null || cm.isEmpty){
        initTarget();
        WidgetsBinding.instance.addPostFrameCallback(_afterLayout);
      }
      super.initState();
    });
  }

  void _afterLayout(_) {
    Future.delayed(Duration(microseconds: 2000));
    _showTutorial();
  }

  void _showTutorial() {
    tutorialCoachMark = TutorialCoachMark(widget.context,
        targets: targets,
        colorShadow: Colors.black,
        opacityShadow: 0.8,
        textSkip: 'Omitir',
        onClickSkip: () => Navigator.of(context)
            .push(CupertinoPageRoute(builder: (_) => ProductsCatalogScreen())),
        onFinish: () => Navigator.of(context)
            .push(CupertinoPageRoute(builder: (_) => ProductsCatalogScreen())))
      ..show();
  }

  void initTarget() {
    targets.add(
      TargetFocus(identify: 'target 0', keyTarget: keyConfiguration, contents: [
        ContentTarget(
            align: AlignContent.top,
            child: Container(
              child: Column(
                children: [
                  Text('Configuracion', style: estiloEncabezado),
                  SizedBox(height: 10),
                  Text('Aqui puedes configurar tu aplicación',
                      textAlign: TextAlign.center, style: estiloCuerpo)
                ],
              ),
            ))
      ]),
    );
    targets.add(
      TargetFocus(identify: 'target 0', keyTarget: keyHome, contents: [
        ContentTarget(
            align: AlignContent.top,
            child: Container(
              child: Column(
                children: [
                  Text('Principal', style: estiloEncabezado),
                  SizedBox(height: 10),
                  Text(
                      'Accede a esta pantalla, para ver todas las acciones que pudes realizar',
                      textAlign: TextAlign.center,
                      style: estiloCuerpo)
                ],
              ),
            ))
      ]),
    );
    targets.add(
      TargetFocus(identify: 'target 0', keyTarget: keyProfile, contents: [
        ContentTarget(
            align: AlignContent.top,
            child: Container(
              child: Column(
                children: [
                  Text('Perfil', style: estiloEncabezado),
                  SizedBox(height: 10),
                  Text('Puedes visualizar tu perfil como usuario',
                      textAlign: TextAlign.center, style: estiloCuerpo)
                ],
              ),
            ))
      ]),
    );
    targets.add(
      TargetFocus(identify: 'target 0', keyTarget: keyFieldSearch, contents: [
        ContentTarget(
            align: AlignContent.bottom,
            child: Container(
              child: Column(
                children: [
                  Text('Busqueda Avanzada',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 24)),
                  SizedBox(height: 10),
                  Text('Realiza una busqueda avanzada',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 14))
                ],
              ),
            ))
      ]),
    );
    targets.add(
      TargetFocus(identify: 'target 0', keyTarget: keyOperationItem, contents: [
        ContentTarget(
            align: AlignContent.top,
            child: Container(
              child: Column(
                children: [
                  Text('Secciones', style: estiloEncabezado),
                  SizedBox(height: 10),
                  Text('Accede a una operacion con solo tocar la seccion',
                      textAlign: TextAlign.center, style: estiloCuerpo)
                ],
              ),
            ))
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          IndexedStack(
            index: homeProvider.paginaPrincipal ?? 1,
            children: [
              ConfigurationHomeScreen(),
              OperationsScreen(globalKeys: [keyOperationItem, keyFieldSearch]),
              ProfileScreen()
            ],
          ),
          _BottomNavigation(
              keys: <GlobalKey>[keyConfiguration, keyHome, keyProfile])
        ],
      ),
    );
  }
}

class _BottomNavigation extends StatelessWidget {
  final List<GlobalKey> keys;

  const _BottomNavigation({@required this.keys});

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context);

    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          color: OmniventColors.azulMarino,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
                key: keys[0],
                child: Icon(
                  Icons.settings,
                  color: Colors.white,
                ),
                onTap: () => homeProvider.paginaPrincipal = 0),
            InkWell(
                key: keys[1],
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  child: Icon(Icons.home, color: Colors.white),
                ),
                onTap: () => homeProvider.paginaPrincipal = 1),
            InkWell(
                key: keys[2],
                child: CircleAvatar(
                  backgroundColor: Color(0xFFF9A826),
                  radius: 15,
                  child: Text('U'),
                ),
                onTap: () => homeProvider.paginaPrincipal = 2),
          ],
        ),
      ),
    );
  }
}
