import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:omnivent_app_wireframe/omnivent_state_managment/colors.dart';
import 'package:omnivent_app_wireframe/omnivent_state_managment/presentation/home/operations/sales/products_sales/products_sales_screen.dart';
import 'package:omnivent_app_wireframe/omnivent_state_managment/presentation/home/operations/sales/sales_managment/sales_managment_screen.dart';
import 'package:omnivent_app_wireframe/omnivent_state_managment/presentation/widgets/sliver_custom.dart';


class SalesOptionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SliverCustom(  
        title: 'Ventas', 
        subtitle: 'Opciones de Ventas',
        iconTitle: Ionicons.ios_cash,
        icon: Icons.arrow_back_ios,
        onTapIcon: (){
          Navigator.of(context).pop();
        },
        minHeight: 180,
        maxHeight: 180,
        child: Column(
            children: [
              SizedBox(height: 20),
              _OptionSaleItem(
                title: 'Administrar Ventas',
                icon: Icons.attach_money_sharp,
                onTap: () => Navigator.of(context).push(
                  CupertinoPageRoute(
                    builder: (BuildContext context) => SalesManageScreen()
                                )),
              ),
              _OptionSaleItem(
                title: 'Venta de Productos',
                icon: FontAwesome.shopping_bag,
                onTap: () => Navigator.of(context).push(
                  CupertinoPageRoute(
                    builder: (BuildContext context) => ProductsSalesScreen()
                    )
                  )
              )
            ],
          )
        )
    );
  }
}

class _OptionSaleItem extends StatelessWidget {

  final String title;
  final IconData icon;
  final VoidCallback onTap;

  _OptionSaleItem({
    @required this.title = 'Whitout title',
    @required this.icon = Icons.cloud_circle_outlined,
    this.onTap});

  
  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: this.onTap,
          child: Stack(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20,vertical:10),
            width: size.width,
            height: 100,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[
                  OmniventColors.azulAcento,
                  OmniventColors.azulCielo
                ]
              ),
              borderRadius: BorderRadius.all(Radius.circular(20))
            ),
          ),
          Positioned(
            top: -10,
            left: 10,
            child: Icon(this.icon,
            color: Colors.white.withOpacity(0.1),
            size: 140)),
          Positioned(
            top: 100 / 2,
            right: 35,
            child: Icon(Icons.arrow_forward_ios,
              color: Colors.white,
              size: 25)),
          Positioned(
              top: 100 / 2,
              left: 80,
              child: Text(this.title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold
                  ),
            ),
          )
        ],
      ),
    );
  }
}

