import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:omnivent_app_wireframe/omnivent_state_managment/colors.dart';
import 'package:omnivent_app_wireframe/omnivent_state_managment/presentation/home/operations/sales/products_sales/products_sales_details/products_sales_details_screen.dart';
import 'package:omnivent_app_wireframe/omnivent_state_managment/presentation/widgets/sliver_custom.dart';

class InventoryScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Scaffold(
        body: Stack(
          children: [
            SliverCustom(
            title: 'Inventario', 
            subtitle: 'Verificar Inventario', 
            iconTitle: Icons.inventory,
            icon: Icons.arrow_back_ios,
            onTapIcon: (){
              Navigator.of(context).pop();
            },
            minHeight: 160,
            maxHeight: 160,
            sliverChild: Container(),
            child: _ContentSales()
            ),
            
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.update,color: Colors.white),
          backgroundColor: OmniventColors.naranja,
          onPressed: (){},
        ),
    );
  }
}

class _ContentSales extends StatelessWidget {

  final existingProducts = [
    ExistingProduct(
      identifier: '5123',
      codeBar: '16650298',
      name: 'Cerveza Victoria 12 Pack',
      total: 75,
      image: 'https://tuabarrote.com/4217-large_default/cerveza-victoria-355ml-liquido.jpg'
    ),
    ExistingProduct(
      identifier: '1232',
      codeBar: '16653298',
      name: 'Tictac Naranja',
      total: 120,
      image: 'https://www.superama.com.mx/Content/images/products/img_large/0000007860375L.jpg'
    ),
    ExistingProduct(
      identifier: '3412',
      codeBar: '166509821',
      name: 'Jabor Ariel 500g',
      total: 0,
      image: 'https://comercialmexicanaint.com/wp-content/uploads/2019/01/VR31.png'
    ),
    ExistingProduct(
      identifier: '2314',
      codeBar: '166504321',
      name: 'Agua Ciel 500ml',
      total: 798,
      image: 'https://www.coca-colaentuhogar.com/media/catalog/product/cache/9376f1eb816eda0af02b0c0436fe42c0/7/5/750105531088_-_ciel_1lt_pet_4_1.png'
    ),
    ExistingProduct(
      identifier: '2356',
      codeBar: '166514321',
      name: 'Nestle Tea',
      total: 0,
      image: 'https://www.bcrek-shop.com/entrepans/42-large_default/nestea-de-limon-50cl.jpg'
    ),
    ExistingProduct(
      identifier: '2376',
      codeBar: '156514341',
      name: 'Trident Splash Sweettmint',
      total: 87,
      image: 'https://www.trident.com.mx/assets/img/GRID_Productos/9s.png'
    ),
    
    
  ];

  @override
  Widget build(BuildContext context) {

    final _textStyle = TextStyle(fontWeight: FontWeight.w400,fontSize: 13);

    return Container(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: existingProducts.length,
                itemBuilder: (BuildContext context, int index) { 
                  return Stack(
                    children: [
                      Card(
                        elevation: 5,
                        child: Container(
                          padding: EdgeInsets.all(10),
                          height: 140,
                          child: Row(
                            children: [
                              FadeInImage(
                                width: 120,
                                height: 120,
                                placeholder: NetworkImage('https://i.pinimg.com/originals/58/4b/60/584b607f5c2ff075429dc0e7b8d142ef.gif'),
                                image: NetworkImage(existingProducts[index].image)
                              ),
                              SizedBox(width: 0),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(existingProducts[index].identifier,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w300
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(existingProducts[index].name,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(existingProducts[index].codeBar,
                                    style: _textStyle
                                  ),
                                  SizedBox(height: 5,),
                                  Text('General',
                                    style: _textStyle
                                  ),
                                  SizedBox(height: 5),
                                  Text('Refrescos',
                                    style: _textStyle
                                  ),
                                  SizedBox(height: 5),
                                  Text('Total: ${existingProducts[index].total}',
                                    style: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold
                                    )
                                  )
                                ],
                                )
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                          child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: (existingProducts[index].total > 0) ? Colors.green : Colors.red,
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                          child: (existingProducts[index].total > 0) 
                                      ? Icon(FontAwesome.check,color: Colors.white,)
                                      : Icon(FontAwesome.close,color:Colors.white),
                        ),
                      )
                    ],
                  );
                },
              ),
              SizedBox(height: 10)
            ],
        ),
          ),
    );
  }
}

class ExistingProduct{

  final String name;
  final String codeBar;
  final String identifier;
  final String family;
  final String sbufamily;
  final int total;  
  final String image;

  ExistingProduct({this.image,this.total,this.name, this.codeBar, this.identifier, this.family, this.sbufamily});

  

  

}