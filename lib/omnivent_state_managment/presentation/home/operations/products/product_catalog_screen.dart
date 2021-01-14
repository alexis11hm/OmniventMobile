import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:omnivent_app_wireframe/omnivent_state_managment/colors.dart';
import 'package:omnivent_app_wireframe/omnivent_state_managment/presentation/home/operations/products/details/product_details_screen.dart';


import 'package:omnivent_app_wireframe/omnivent_state_managment/domain/model/ResponseModel.dart';
import 'package:omnivent_app_wireframe/omnivent_state_managment/domain/model/ProductoModel.dart';

import 'package:omnivent_app_wireframe/omnivent_state_managment/data/service/ProductosService.dart';

import 'package:omnivent_app_wireframe/omnivent_state_managment/domain/storage/secure_storage.dart';

import 'package:omnivent_app_wireframe/omnivent_state_managment/domain/provider/ProductosProvider.dart';
import 'package:omnivent_app_wireframe/omnivent_state_managment/presentation/login/login_screen.dart';
import 'package:omnivent_app_wireframe/omnivent_state_managment/presentation/widgets/alert_dialogs.dart';


import 'package:provider/provider.dart';


class ProductsCatalogScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(
          create: (_) => new ProductosProvider(),
          child: _Scaffold());
  }
}

class _Scaffold extends StatelessWidget {


  

  @override
  Widget build(BuildContext context) {

    void _mostrarAlerta() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return CustomAlertDialog(titulo: 'Sesión Expirada', contenido: [
            Text('La sesión ha expirado'),
            SvgPicture.asset(
              'assets/close/salir.svg',
              width: 120,
              height: 120,
              placeholderBuilder: (BuildContext context) {
                return Image.asset(
                  'assets/cargando.gif',
                  width: 100,
                  height: 100,
                );
              },
            ),
          ], botones: [
            FlatButton(
              child: Text('Aceptar'),
              onPressed: () => Navigator.of(context).pushReplacement(
                  CupertinoPageRoute(builder: (_) => LoginScreen())),
            ),
            FlatButton(
              child: Text('Cancelar'),
              onPressed: () => Navigator.of(context).pop(),
            )
          ]);
        });
  }

    final productosService = ProductosService();
    final secure = SecureStorage();
    final almacenamiento = secure.crearAlmacenamiento();
    final productosProvider = Provider.of<ProductosProvider>(context);

    cargarInformacion(){
      almacenamiento.read(key: 'token').then((token) => {
          productosService.ObtenerProductos(token).then((respuesta) => {
              if(respuesta.estatus == 200){
                print('Productos'),
                productosProvider.productos = respuesta.respuesta,
                productosProvider.productosBuscar = respuesta.respuesta,
                productosProvider.cargarInformacion = 0
              }else if(respuesta.estatus==401){
                _mostrarAlerta()
              }else{
                productosProvider.productos = null,
                productosProvider.productosBuscar = null,
                productosProvider.cargarInformacion = 0
              }
          })
      });
    }
 
     if(productosProvider.cargarInformacion == 1){
       cargarInformacion();
     }
      
      return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.sync_rounded),
        backgroundColor: OmniventColors.naranja,
        onPressed: (){
            cargarInformacion();
            }
      ),
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context, delegate: DataSearch(productosProvider: productosProvider), //query: 'Hola'
              );
            },
          ),
        ],
        title: Text('Catalogo de Productos'),
        backgroundColor: OmniventColors.azulMarino,
      ),
      body: Column(
      children: [
        _HeaderFamilyList(),
        _ProductsList(productos: productosProvider.productos),
      ],
        )
    );
  }
}

class _ProductsList extends StatelessWidget {

  final List<ProductoModel> productos;

  const _ProductsList({@required this.productos});

  @override
  Widget build(BuildContext context) {

    return Expanded(
            flex: 5,
              child: (productos != null) ?
              GridView.count(
                        crossAxisCount: 2,
                        shrinkWrap: true,
                        children: List.generate(productos.length, (index){
                          return GestureDetector(
                            onTap: (){
                              Navigator.of(context).push(
                                CupertinoPageRoute(
                                  builder: (_) => ProductDetailsScreen(
                                    producto: productos[index],
                                  ),
                                )
                              );
                            },
                              child: Card(
                              elevation: 10,
                              margin: EdgeInsets.all(10),
                              child: Container(
                                padding: EdgeInsets.all(10),
                                width: double.infinity,
                                height: 310,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Center(
                                      child: Hero(
                                          tag: productos[index].proId,
                                          child: FadeInImage(
                                          width: 85,
                                          height: 85,
                                          placeholder: AssetImage('assets/cargando.gif'),
                                          image: AssetImage('assets/imagen_no_disponible.png')
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Text(productos[index].proDescripcion,
                                      maxLines: 2,
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Row(
                                      children: [
                                        Expanded(
                                            child: Text('\$${productos[index].proPrecioGeneralIva} c/IVA',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey[500]
                                            ),
                                          ),
                                        ),
                                        Icon(
                                          Icons.arrow_forward_ios,
                                          size: 15, 
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        }
                  )
                  )
                  :
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 60),
                        CircularProgressIndicator(
                          backgroundColor: Colors.orange,
                        ),
                        SizedBox(height: 20),
                        Text('Cargando...'),
                      ],
                    ),
                  )
      );
  }
}

class DataSearch extends SearchDelegate {

  final ProductosProvider productosProvider;

  DataSearch({@required this.productosProvider});

  @override
  List<Widget> buildActions(BuildContext context) {

    buscarInformacion(String buscar){
      print(buscar);
      final List<ProductoModel> listaProductos = productosProvider.productosBuscar.where(
                          (producto) => 
                          producto.familia.toLowerCase().contains(buscar.toLowerCase()) ||
                          //producto.proCodigoBarras.toLowerCase().contains(buscar.toLowerCase()) ||
                          producto.proCostoGeneralIva.toString().toLowerCase().contains(buscar.toLowerCase()) ||
                          producto.proDescripcion.toLowerCase().contains(buscar.toLowerCase()) ||
                          producto.proPrecioGeneralIva.toString().toLowerCase().contains(buscar.toLowerCase()) ||
                          producto.proId.toString().toLowerCase().contains(buscar.toLowerCase()) ||
                          //producto.proIdentificacion.toString().toLowerCase().contains(buscar.toLowerCase()) ||
                          producto.subFamilia.toLowerCase().contains(buscar.toLowerCase())
                          ).toList();

      productosProvider.productos = listaProductos;
      print('Se realizo la llamada: ${listaProductos.length}');
    }

    //LAS ACCIONES DE NUESTRO APPBAR
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
          if(query != null || query.isNotEmpty){
            buscarInformacion(query);
          }
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // ICONO A LA IZQUIERDA DEL APPBAR
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // CREA LOS RESULTADOS QUE VAMOS A MOSTRAR
    return ListView(
            children: productosProvider.productos.map((producto) => 
              ListTile(
                leading: Hero(
                       tag: producto.proId,
                       child: FadeInImage(
                       placeholder: AssetImage('assets/cargando.gif'),
                       image: AssetImage('assets/imagen_no_disponible.png'),
                       width: 50.0,
                       fit: BoxFit.contain),
                ),
                title: Text(producto.proDescripcion),
                subtitle: Text(producto.familia),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {
                  close(context, null);
                  Navigator.of(context).push(
                                CupertinoPageRoute(
                                  builder: (_) => ProductDetailsScreen(
                                    producto: producto,
                                  ),
                                )
                              );
                },
              )
            ).toList()
          );
  }

  @override
  Widget buildSuggestions(BuildContext context) {

    buscarInformacion(String buscar){
      print(buscar);
      final List<ProductoModel> listaProductos = productosProvider.productosBuscar.where(
                          (producto) => 
                          producto.familia.toLowerCase().contains(buscar.toLowerCase()) ||
                          //producto.proCodigoBarras.toLowerCase().contains(buscar.toLowerCase()) ||
                          producto.proCostoGeneralIva.toString().toLowerCase().contains(buscar.toLowerCase()) ||
                          producto.proDescripcion.toLowerCase().contains(buscar.toLowerCase()) ||
                          producto.proPrecioGeneralIva.toString().toLowerCase().contains(buscar.toLowerCase()) ||
                          producto.proId.toString().toLowerCase().contains(buscar.toLowerCase()) ||
                          //producto.proIdentificacion.toString().toLowerCase().contains(buscar.toLowerCase()) ||
                          producto.subFamilia.toLowerCase().contains(buscar.toLowerCase())
                          ).toList();

      productosProvider.productos = listaProductos;
      print('Se realizo la llamada: ${listaProductos.length}');
    }

    // LAS SUGERENCIAS QUE APARECEN CUANDO LA PERSONA ESCRIBE
    if (query.isEmpty) return Container();
    if(query != null || query.isNotEmpty){
      buscarInformacion(query);
    }
    return (productosProvider.productos != null) 
            ?
            ListView(
            children: productosProvider.productos.map((producto) => 
              ListTile(
                leading: Hero(
                       tag: producto.proId,
                       child: FadeInImage(
                       placeholder: AssetImage('assets/cargando.gif'),
                       image: AssetImage('assets/imagen_no_disponible.png'),
                       width: 50.0,
                       fit: BoxFit.contain),
                ),
                title: Text(producto.proDescripcion),
                subtitle: Text(producto.familia),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {
                  close(context, null);
                  Navigator.of(context).push(
                                CupertinoPageRoute(
                                  builder: (_) => ProductDetailsScreen(
                                    producto: producto,
                                  ),
                                )
                              );
                },
              )
            ).toList()
          )
          :
          Center(
            child: Container(
              child: Text('Escribe para buscar un producto...'),
            ),
          );
  }
}


class _HeaderFamilyList extends StatelessWidget {

  final familyList = [
    Family(
      icon: Icons.people_outline,
      title: 'General'
    ),
    Family(
      icon: Icons.food_bank_outlined,
      title: 'Botanas'
    ),
    Family(
      icon: Icons.tv_outlined,
      title: 'Electronica'
    ),
    Family(
      icon: Icons.emoji_food_beverage,
      title: 'Abarrotes'
    ),
    Family(
      icon: Icons.cake_outlined,
      title: 'Ropa'
    ),
    Family(
      icon: Icons.icecream,
      title: 'Neveria'
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20,vertical:10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Family',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18
                          ),
                        ),
              SizedBox(height: 10),
              Expanded(
                child: 
                ListView.builder(
                  itemCount: familyList.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index){
                    return Container(
                    decoration: BoxDecoration(
                      color: (index == 0) ? OmniventColors.naranja : Colors.grey[300],
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    width: 90,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: OmniventColors.azulMarino,
                            borderRadius: BorderRadius.circular(60),
                          ),
                          child: Icon(familyList[index].icon,
                            color: Colors.white,
                            size: 40,
                            ),
                        ),
                        SizedBox(height: 10),
                        Text(familyList[index].title,
                          style: TextStyle(
                            color: (index == 0 ) ? Colors.white : Colors.black87,
                            fontWeight: FontWeight.w600,
                            fontSize: 14
                          ),
                        ),
                      ],
                    ),
                  );
                  },
                ),
              ),
            ],
          ),
        ),
    );
  }
}

class Family {

  final String title;
  final IconData icon;

  Family({this.title, this.icon});

}
