import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:omnivent_app_wireframe/omnivent_state_managment/presentation/login/login_screen.dart';
import 'package:omnivent_app_wireframe/omnivent_state_managment/presentation/widgets/alert_dialogs.dart';

class SliverCustom extends StatelessWidget {

  final Widget child;
  final Widget sliverChild;
  final double minHeight;
  final double maxHeight;
  final String title;
  final String subtitle;
  final IconData icon;
  final IconData iconTitle;
  final VoidCallback onTapIcon;
  

  SliverCustom({
    @required this.child,
    this.sliverChild = const SizedBox(height: 0), 
    this.minHeight = 170, 
    this.maxHeight = 205, 
    @required this.title, 
    @required this.subtitle,
    this.icon = Icons.arrow_back_ios, 
    this.onTapIcon, 
    this.iconTitle = Icons.face
  });
  

  @override
  Widget build(BuildContext context) {

     

    final size = MediaQuery.of(context).size;
    return CustomScrollView(
      physics: PageScrollPhysics(),
      slivers: [
        SliverPersistentHeader(
          floating: true,
          delegate: _SliverCustomDelegate(
            minHeight: this.minHeight,
            maxHeight: this.maxHeight,
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF264e86),
                    Color(0xFF0074e4),
                  ]
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30)
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: onTapIcon,
                        child: Icon(
                        this.icon,
                        color: Colors.white,
                      ),
                    ),
                    InkWell(
                          child: Icon(
                          Icons.logout,
                          color: Colors.white,
                      ),
                      onTap: (){
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context){
                            return CustomAlertDialog(
                              titulo: 'Cerrar Sesión',
                              contenido: [
                                Text('¿Estas seguro de cerrar sesión?'),
                                SvgPicture.asset(
                                  'assets/close/salir.svg',
                                  width: 120,
                                  height: 120,
                                  placeholderBuilder: (BuildContext context){
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
                                  onPressed: () => Navigator.of(context).pushReplacement(
                                                    CupertinoPageRoute(
                                                      builder: (_) => LoginScreen()
                                                  )),
                                ),
                                FlatButton(
                                  child: Text('Cancelar'),
                                  onPressed: () => Navigator.of(context).pop()
                                  ,
                                )
                              ]);
                          }
                        );
                      },
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                  Text(this.title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                    )),
                  SizedBox(height: 3),
                  Row(
                    children: [
                      Text(this.subtitle,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold
                        )),
                        SizedBox(width: 5,),
                        Icon(this.iconTitle,color: Colors.white,)
                    ],
                  ),
                  SizedBox(height: 15),
                  this.sliverChild
                ],
              )

            
            )
          )
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              child
            ]))
      ],
    );
  }
}

class _SliverCustomDelegate extends SliverPersistentHeaderDelegate{

  final double minHeight;
  final double maxHeight;
  final Widget child;

  _SliverCustomDelegate({this.minHeight, this.maxHeight, this.child});


  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
      return SizedBox.expand(child: child,);
    }
  
    @override
    double get maxExtent => (this.minHeight > this.maxHeight) ? minHeight : maxHeight;
  
    @override
    double get minExtent => (this.minHeight < this.maxHeight) ? maxHeight : minHeight;
  
    @override
    bool shouldRebuild(_SliverCustomDelegate oldDelegate) {
      return maxHeight != oldDelegate.maxHeight ||
              minHeight != oldDelegate.minHeight ||
                child != oldDelegate.child;
  }



}