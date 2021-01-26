import 'package:flutter/material.dart';
import 'package:omnivent_app_wireframe/omnivent_state_managment/colors.dart';

class HeaderWaveLogin extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: size.height,
      child: CustomPaint(
        painter: _HeaderWaveLoginPainter(),
      ),
    );
  }
}

class _HeaderWaveLoginPainter extends CustomPainter {

  @override
  void paint(Canvas canvas, Size size) {

    final rect = Offset.zero & size;

    final Gradient gradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.topRight,
      colors: <Color>[
        OmniventColors.azulAcento,
        OmniventColors.azulCielo
      ]
    );

    final paint = Paint()..shader = gradient.createShader(rect);
    paint.style = PaintingStyle.fill;
    paint.strokeWidth=10;
    final path = Path();
    path.lineTo(0, size.height * 0.4);
    path.quadraticBezierTo(size.width * 0.05, size.height*0.5, size.width * 0.2, size.height * 0.5);
    path.lineTo(size.width*0.8, size.height * 0.5);
    path.quadraticBezierTo(size.width * 0.95, size.height*0.50, size.width, size.height * 0.6);
     path.lineTo(size.width, 0);
    canvas.drawPath(path, paint);

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;

  
}


class HeaderWaveRight extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: size.height,
      child: CustomPaint(
        painter: _HeaderWaveRightPainter(),
      ),
    );
  }
}

class _HeaderWaveRightPainter extends CustomPainter {

  @override
  void paint(Canvas canvas, Size size) {

    final rect = Rect.fromCircle(
      center: Offset(0,155.0),
      radius: 300
    );

    final Gradient gradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: <Color>[
        OmniventColors.azulAcento,
        OmniventColors.azulCielo
      ]
    );

    final paint = Paint()..shader = gradient.createShader(rect);
    paint.style = PaintingStyle.fill;
    paint.strokeWidth=10;
    final path = Path();
    path.lineTo(0, size.height * 0.3);
    path.quadraticBezierTo(size.width * 0.40, size.height*0.3, size.width * 0.5, size.height * 0.5);
    path.quadraticBezierTo(size.width * 0.60, size.height*0.70, size.width, size.height * 0.7);
    path.lineTo(size.width, 0);
    canvas.drawPath(path, paint);

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;

  
}

class HeaderWaveLeft extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: size.height,
      child: CustomPaint(
        painter: _HeaderWaveLeftPainter(),
      ),
    );
  }
}

class _HeaderWaveLeftPainter extends CustomPainter {

  @override
  void paint(Canvas canvas, Size size) {

    final rect = Rect.fromCircle(
      center: Offset(0,155.0),
      radius: 300
    );

    final Gradient gradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: <Color>[
        OmniventColors.azulAcento,
        OmniventColors.azulCielo
      ]
    );

    final paint = Paint()..shader = gradient.createShader(rect);
    paint.style = PaintingStyle.fill;
    paint.strokeWidth=10;
    final path = Path();
    path.lineTo(0, size.height * 0.7);
    path.quadraticBezierTo(size.width * 0.4, size.height*0.7, size.width * 0.5, size.height * 0.5);
    path.quadraticBezierTo(size.width * 0.6, size.height*0.3, size.width, size.height * 0.3);
    path.lineTo(size.width, 0);
    canvas.drawPath(path, paint);

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}


class HeaderBottomWave extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Container(
      height: size.height,
      width: size.width,
      child: CustomPaint(
        painter: _HeaderBottomWavePainter(),
      ),
    );
  }
}

class _HeaderBottomWavePainter extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size) {

      final rect = Rect.fromCircle(
      center: Offset(0,155.0),
      radius: 300
      );

      final Gradient gradient = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: <Color>[
         OmniventColors.azulMarino,
         OmniventColors.azulAcento
        ]
      );

      final paint = Paint()..shader = gradient.createShader(rect);
      paint.strokeWidth = 10;
      paint.style = PaintingStyle.fill;

      final path = Path();
      path.lineTo(0, size.height * 0.4);
      path.quadraticBezierTo(size.width * 0.5, size.height * 0.6   , size.width,size.height * 0.4);
      path.lineTo(size.width, 0);
      canvas.drawPath(path, paint);
    }
  
    @override
    bool shouldRepaint(CustomPainter oldDelegate) => true;

}

class HeaderAndFooterWave extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Container(
      height: size.height,
      width: size.width,
      child: CustomPaint(
        painter: _HeaderAndFooterWave(),
      ),
    );
  }
}

class _HeaderAndFooterWave extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size) {

      final rect = Rect.fromCircle(
      center: Offset(0,155.0),
      radius: 300
      );

      final Gradient gradient = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: <Color>[
         OmniventColors.azulMarino,
         OmniventColors.azulAcento
        ]
      );

      final paint = Paint()..shader = gradient.createShader(rect);
      paint.strokeWidth = 10;
      paint.style = PaintingStyle.fill;

      final path = Path();
      path.lineTo(0, size.height * 0.2);
      path.quadraticBezierTo(size.width * 0.25, size.height * 0.15   , size.width * 0.5, size.height * 0.2);
      path.quadraticBezierTo(size.width * 0.75, size.height * 0.25   , size.width, size.height * 0.2);
      path.lineTo(size.width, 0);
      canvas.drawPath(path, paint);
    }
  
    @override
    bool shouldRepaint(CustomPainter oldDelegate) => true;

}
