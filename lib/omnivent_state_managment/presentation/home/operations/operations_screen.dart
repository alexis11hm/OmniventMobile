import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:omnivent_app_wireframe/omnivent_state_managment/colors.dart';
import 'package:omnivent_app_wireframe/omnivent_state_managment/presentation/home/operations/cash_closing/cash_closing_screen.dart';
import 'package:omnivent_app_wireframe/omnivent_state_managment/presentation/home/operations/inventory/inventory_screen.dart';
import 'package:omnivent_app_wireframe/omnivent_state_managment/presentation/home/operations/prices/product_prices_screen.dart';
import 'package:omnivent_app_wireframe/omnivent_state_managment/presentation/home/operations/products/product_catalog_screen.dart';
import 'package:omnivent_app_wireframe/omnivent_state_managment/presentation/home/operations/sales/sales_options_screen.dart';
import 'package:omnivent_app_wireframe/omnivent_state_managment/presentation/widgets/sliver_custom.dart';

import 'package:omnivent_app_wireframe/omnivent_state_managment/domain/provider/OperacionesProvider.dart';


import 'package:provider/provider.dart';


class OperationsScreen extends StatelessWidget {


  final List<GlobalKey> globalKeys;

  const OperationsScreen({@required this.globalKeys});
  

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(
              create: (_) => new OperacionesProvider(),
              child: _SliverCustom(globalKeys: globalKeys));
  }
}

class _SliverCustom extends StatelessWidget {

  final List<GlobalKey> globalKeys;

  const _SliverCustom({@required this.globalKeys});

  @override
  Widget build(BuildContext context) {

     final options = [
      OptionItem(
        title: 'Productos',
        subtitle: 'Catalogo de productos',
        icon: Icons.shop_two,
        onPressed: (){
          Navigator.of(context).push(
            CupertinoPageRoute(
              builder: (BuildContext context) => ProductsCatalogScreen()
              )
            );
        }
      ),
      OptionItem(
        title: 'Flujos de Efectivo',
        subtitle: 'Consulta el efectivo',
        icon: Icons.point_of_sale,
        onPressed: (){
          Navigator.of(context).push(
            CupertinoPageRoute(
              builder: (BuildContext context) => CashClosingScreen()
              )
            );
        }
      ),
      OptionItem(
        title: 'Ventas',
        subtitle: 'Venta de productos',
        icon: Icons.monetization_on_outlined,
        onPressed: (){
          Navigator.of(context).push(
            CupertinoPageRoute(
              builder: (BuildContext context) => SalesOptionsScreen()
              )
            );
        }
      ),
      OptionItem(
        title: 'Almacen e Inventario',
        subtitle: 'Panel de existencias',
        icon: Icons.inventory,
        onPressed: (){
          Navigator.of(context).push(
            CupertinoPageRoute(
              builder: (BuildContext context) => InventoryScreen()
              )
            );
        }
      ),
      OptionItem(
        title: 'Precios',
        subtitle: 'Precio de Productos',
        icon: Icons.monetization_on_rounded,
        onPressed: (){
          Navigator.of(context).push(
            CupertinoPageRoute(
              builder: (BuildContext context) => ProductPriceScreen()
              )
            );
        }
      ),
      
      
    ];

    final operacionesProvider = Provider.of<OperacionesProvider>(context);

    buscarInformacion(String buscar){

      final List<OptionItem> listaOpciones = operacionesProvider.operacionesBuscar.where(
                          (operacion) => 
                          operacion.title.toLowerCase().contains(buscar.toLowerCase()) ||
                          operacion.subtitle.toLowerCase().contains(buscar.toLowerCase())
                          ).toList();

      operacionesProvider.operaciones = listaOpciones;
      print('Se realizo la llamada: ${listaOpciones.length}');
    }

    if(operacionesProvider.cargarInformacion == 1){
      operacionesProvider.operaciones = options;
      operacionesProvider.operacionesBuscar = options;
      operacionesProvider.cargarInformacion = 0;
     }

    
    return SliverCustom(
                    title: 'Hola usuario',
                    subtitle: 'Bienvenido de Nuevo',
                    maxHeight: 225,
                    minHeight: 190,
                    icon: Icons.storefront,
                    iconTitle: FontAwesome5.smile_wink,
                    sliverChild: Container(
                      height: 45,
                      child: CupertinoTextField(
                      key: ( globalKeys.length > 1) ? globalKeys[1] : null,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20))
                        ),
                        placeholder: '¿Que categoria estas buscando?',
                        cursorColor: OmniventColors.naranja,
                        prefix: Container(
                          padding: EdgeInsets.only(left: 20,right: 10),
                          child: Icon(Icons.search,color: Colors.black45
                        )),
                        onChanged: (valor){ 
                          print("Buscando: $valor");
                          buscarInformacion(valor);
                        },
                      ),
                    ),
                    child:Container(
                      child: Column(
                        children: [
                          GridView.count(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            crossAxisCount: 2,
                            children: 
                              List.generate(operacionesProvider.operaciones.length, (index){
                                return GestureDetector(
                                key: (index==0 && globalKeys.length > 0) ? globalKeys[0] : null,
                                child: Card(
                                    elevation: 5,
                                    margin: EdgeInsets.all(10),
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                              child: Align(
                                                alignment: Alignment.topRight,                              child: Container(
                                                width: 60,
                                                height: 60,
                                                decoration: BoxDecoration(
                                                  color: OmniventColors.naranja.withOpacity(0.8),
                                                  borderRadius: BorderRadius.circular(30)
                                                ),
                                                child: Icon(
                                                  operacionesProvider.operaciones[index].icon,
                                                  color: Colors.white,
                                                  size: 35,
                                                  ),
                                              ),
                                            ),
                                          ),
                                          
                                          Text(operacionesProvider.operaciones[index].title,
                                            style: TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold
                                            ),
                                          ),
                                          Text(operacionesProvider.operaciones[index].subtitle,
                                           style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.black54
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  onTap: operacionesProvider.operaciones[index].onPressed,
                                );
                              })
                          ),
                          SizedBox(height: 80)
                        ],
                      ),
                    )
                  );
  }
}

class OptionItem {

  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onPressed;

  OptionItem({this.title, this.subtitle, this.icon,this.onPressed});

}