import 'package:flutter/material.dart';
import 'package:omnivent_app_wireframe/omnivent_state_managment/domain/provider/HomeProvider.dart';
import 'package:omnivent_app_wireframe/omnivent_state_managment/presentation/home/operations/operations_screen.dart';
import 'package:omnivent_app_wireframe/omnivent_state_managment/presentation/home/profile/profile_screen.dart';
import 'package:omnivent_app_wireframe/omnivent_state_managment/colors.dart';


import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => new HomeProvider(), child: _Scaffold());
  }
}

class _Scaffold extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final homeProvider = Provider.of<HomeProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          IndexedStack(
            index: homeProvider.paginaPrincipal??1,
            children: [
              Container(
                  color: Colors.amber,
                  height: double.infinity,
                  width: double.infinity),
              Container(
                  color: Colors.red,
                  height: double.infinity,
                  width: double.infinity),
              OperationsScreen(),
              Container(
                  color: Colors.green,
                  height: double.infinity,
                  width: double.infinity),
              ProfileScreen()
            ],
          ),
          _BottomNavigation()
        ],
      ),
    );
  }
}

class _BottomNavigation extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {

    final homeProvider = Provider.of<HomeProvider>(context);

    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        margin: EdgeInsets.all(20),
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          color: OmniventColors.azulMarino,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
                child: Icon(
                  Icons.settings,
                  color: Colors.white,
                ),
                onTap: () => homeProvider.paginaPrincipal = 0),
            InkWell(
                child: Icon(
                  Icons.inventory,
                  color: Colors.white,
                ),
                onTap: () => homeProvider.paginaPrincipal = 1),
            InkWell(
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  child: Icon(Icons.home, color: Colors.white),
                ),
                onTap: () => homeProvider.paginaPrincipal = 2),
            InkWell(
                child: Icon(
                  Icons.monetization_on_outlined,
                  color: Colors.white,
                ),
                onTap: () => homeProvider.paginaPrincipal = 3),
            InkWell(
                child: CircleAvatar(
                  backgroundColor: Color(0xFFF9A826),
                  radius: 15,
                  child: Text('U'),
                ),
               onTap: () => homeProvider.paginaPrincipal = 4),
          ],
        ),
      ),
    );
  }
}
