import 'package:flutter/material.dart';
import 'package:omnivent_app_wireframe/omnivent_state_managment/colors.dart';

class AssistanceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final headerStyle = TextStyle(
        color: OmniventColors.naranja,
        fontSize: 18,
        fontWeight: FontWeight.bold);
    final bodyStyle = TextStyle(fontSize: 14);

    return Scaffold(
      appBar: AppBar(
        title: Text('Contacto'),
        backgroundColor: OmniventColors.azulMarino,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Información de Contacto', style: headerStyle),
              SizedBox(height: 20),
              Text(
                  'Nos encontramos ubicados en el área conurbada de la Ciudad de México. Para cualquier comunicación por favor escríbanos a los correos indicados. Estaremos muy contentos de conversar con usted. \n\n Nuestros horarios de atención son de Lunes a Viernes de 9:00 a 18:00hrs, donde podrá contactarnos para cualquier asunto relacionado con nuestros productos y servicios. \n\n Las peticiones de soporte técnico solo son atendidas en el correo indicado, le pedimos canalice sus comunicaciones de acuerdo al departamento que corresponda.',
                  style: bodyStyle),
              SizedBox(height: 30),
              Text('Soporte Técnico', style: headerStyle),
              SizedBox(height: 20),
              Text(
                  'Productos: soporte@omnisoft.com.mx \n\n Hosting: hosting@omnisoft.com.mx',
                  style: bodyStyle),
              SizedBox(height: 30),
              Text(
                  'Información General acerca de nuestros productos y servicios',
                  style: headerStyle,
                  textAlign: TextAlign.center),
              SizedBox(height: 20),
              Text('contacto@omnisoft.com.mx', style: bodyStyle)
            ],
          ),
        ),
      ),
    );
  }
}
