import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:omnivent_app_wireframe/omnivent_state_managment/domain/provider/SlideshowProvider.dart';
import 'package:omnivent_app_wireframe/omnivent_state_managment/presentation/login/login_screen.dart';

import 'package:omnivent_app_wireframe/omnivent_state_managment/presentation/widgets/slideshow.dart';
import 'package:provider/provider.dart';
 

class SlideshowScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

        return Scaffold(
                    body: Slideshow(
                      bulletPrimario: 16,
                      bulletSecundario: 12,
                      colorPrimario: Colors.orange,
                      colorSecundario: Colors.blueGrey,
                      slides: [
                        SlideModel(
                          title:'Sales Control', 
                          subtitle: 'Controla tus Ventas',
                          description: 'Ahora puedes monitorear todas las ventas que sucedan en tu negocio desde el dispositivo movil', 
                          image:'assets/slideshow/sales_control.svg'),
                        SlideModel(
                          title:'Inventory Control',
                          subtitle: 'Controla tus Inventarios', 
                          description: 'Monitorea tu inventario para conocer que tienes en existencia y asi tomar decisiones', 
                          image:'assets/slideshow/inventory_control.svg'),
                        SlideModel(
                          title:'Products Control', 
                          subtitle: 'Controla tus Productos',
                          description: 'Verifica todos los productos y sus caracteristicas con los que cuenta tu negocio', 
                          image:'assets/slideshow/products_control.svg'),
                        SlideModel(
                          title:'Cash Register Control', 
                          subtitle: 'Controla el Corte de Cajas',
                          description: 'Conoce los cortes de caja que sucen cada dia en tu negocio desde cualquier lugar que te encuentres', 
                          image:'assets/slideshow/corte_caja_control.svg')
                  ],
    ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
            Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (_) => LoginScreen()));
        },
        backgroundColor: Color(0xFF264e86),
        child: Icon(Icons.login),
        )
    );
  }
}


class SlideModel{

   final String title;
   final String subtitle;
   final String description;
   final String image;

  SlideModel({this.title, this.subtitle, this.description, this.image});


}