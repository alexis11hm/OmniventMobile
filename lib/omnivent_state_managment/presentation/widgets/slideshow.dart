import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:omnivent_app_wireframe/omnivent_state_managment/domain/provider/SlideshowProvider.dart';
import 'package:omnivent_app_wireframe/omnivent_state_managment/presentation/widgets/headers_wave.dart';
import 'package:omnivent_app_wireframe/omnivent_state_managment/presentation/widgets/cross_wave_lines.dart';

import 'package:omnivent_app_wireframe/omnivent_state_managment/presentation/slideshow/slideshow_screen.dart';
import 'package:provider/provider.dart';



class Slideshow extends StatelessWidget {

  final List<SlideModel> slides;
  final double bulletPrimario;
  final double bulletSecundario;
  final Color colorPrimario;
  final Color colorSecundario;

  Slideshow({
    @required this.slides, 
    this.bulletPrimario, 
    this.bulletSecundario, 
    this.colorPrimario, 
    this.colorSecundario
    });
    

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
          create: (_) => new SlideshowProvider(),
          child: Center(
            child: Builder(
              builder: (BuildContext context){
                Provider.of<SlideshowProvider>(context).colorPrimario = this.colorPrimario;
                Provider.of<SlideshowProvider>(context).colorSecundario = this.colorSecundario;
                Provider.of<SlideshowProvider>(context).bulletPrimario = this.bulletPrimario;
                Provider.of<SlideshowProvider>(context).bulletSecundario = this.bulletSecundario;
                return _SlidesShowStructure(slides: this.slides);
              },
            )),
    );
  }
}

class _SlidesShowStructure extends StatelessWidget {

  final List<SlideModel> slides;

  _SlidesShowStructure({@required this.slides});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: _Slides(slides:this.slides),
        ),
        _Dots(dotsAmount: this.slides.length)
      ],
    );
  }
}


class _Dots extends StatelessWidget {

  final int dotsAmount;

  _Dots({this.dotsAmount});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60.0,
      color: Color(0xFFD3DCF0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(dotsAmount, (index) => _Dot(index:index)),
      ),
    );
  }
}

class _Dot extends StatelessWidget {

  final int index;

  _Dot({this.index});

  @override
  Widget build(BuildContext context) {
    final slideshowProvider = Provider.of<SlideshowProvider>(context);
    double tamanio = 0;
    Color color;

    if (slideshowProvider.paginaActual >= (index - 0.5) &&
        slideshowProvider.paginaActual < index + 0.5) {
      tamanio = slideshowProvider.bulletPrimario;
      color = slideshowProvider.colorPrimario;
    } else {
      tamanio = slideshowProvider.bulletSecundario;
      color = slideshowProvider.colorSecundario;
    }

    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      width: tamanio,
      height: tamanio,
      margin: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: color.withOpacity(0.6),
        shape: BoxShape.circle
      ),
    );
  }
}


class _Slides extends StatefulWidget {

  final List<SlideModel> slides;

  _Slides({this.slides});

  @override
  __SlidesState createState() => __SlidesState();
}

class __SlidesState extends State<_Slides> {

  final pageViewController = PageController();

  @override
  void initState() {
    pageViewController.addListener(() {
      //Update sliderModel instance,if provider is in initState listen must be false
     Provider.of<SlideshowProvider>(context, listen: false).paginaActual =
          pageViewController.page;
    });
    //Update sliderModel instance,if provider is in initState listen must be false
    super.initState();
  }

  @override
  void dispose() {
    pageViewController?.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    int index = 1;
    
    return Container(
      child: PageView(
        controller: pageViewController,
        children: widget.slides.map((slide) => _Slide(slide:slide,index: index++)).toList(),
      ),
    );
  }
}

class _Slide extends StatelessWidget{

  final SlideModel slide;
  final int index;

  _Slide({this.slide,this.index});

  @override
  Widget build(BuildContext context) {

    
    final size = MediaQuery.of(context).size;
    final sizeContainer = 300.0;
    final sizeContainerHeight = 530.0;

    return Container(
          color: Color(0xFFD3DCF0),
          child: Center(
            child: Stack(
              children: [
                if(index % 2 == 0) HeaderWaveLeft()
                else HeaderWaveRight(),
                CrossWaveLines(),
                Positioned(
                  top: (size.height / 2) - (sizeContainerHeight / 2),
                  left: (size.width / 2) - (sizeContainer / 2),
                    child: Container(
                      width: sizeContainer,
                      height: sizeContainerHeight,
                      child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('Omnivent Movíl ',
                        style: TextStyle(
                          color: Color(0xFFeff0f4),
                          fontWeight: FontWeight.w300,
                          fontSize: 30
                          ),
                        ),
                        SizedBox(height: 40),
                        Center(
                          child: SvgPicture.asset(
                            slide.image,
                            width: 250,
                            height: 250,
                            placeholderBuilder: (BuildContext context){
                              return Image.asset(
                                'assets/cargando.gif',
                                width: 250,
                                height: 250,
                                );
                            },
                            ),
                        ),
                        SizedBox(height: 10),
                        Container(
                        width: size.width * 0.90,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(slide.subtitle,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                            ),),
                            SizedBox(height: 10,),
                            Text(slide.description,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w300
                            ),),
                          ],
                        ),
                      ),
                      ],
                    ),
                  ),
                ),
                
                
              ],
            ),
          ),
        );
  }



}