
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomAlertDialog extends StatelessWidget {

  const CustomAlertDialog({this.titulo, 
                          this.contenido, 
                          this.botones});


  final String titulo;
  final List<Widget> contenido;
  final List<Widget> botones;

  
  @override
  Widget build(BuildContext context) {
    return AlertDialog(

            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            title: Center(child: Text(titulo)),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: contenido,
            ),
            actions: botones
          );
  }
}