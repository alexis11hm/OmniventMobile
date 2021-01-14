import 'package:flutter/material.dart';
import 'package:omnivent_app_wireframe/omnivent_state_managment/colors.dart';

class CrossWaveLines extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: size.height,
      child: CustomPaint(
        painter: _CrossWaveLinesPainter(),
      )
    );
  }
}

class _CrossWaveLinesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
      
    final paint = Paint();

    paint.strokeWidth = 1;
    paint.color = OmniventColors.azulMarinoOscuro.withOpacity(0.3);
    paint.style = PaintingStyle.stroke;

    final path = Path();

    path.moveTo(0, size.height * 0.47);
    path.quadraticBezierTo(size.width * 0.2, size.height * 0.4, size.width * 0.5, size.height * 0.6);
    path.quadraticBezierTo(size.width * 0.7, size.height * 0.7, size.width, size.height * 0.6);

    path.moveTo(0, size.height * 0.53);
    path.quadraticBezierTo(size.width * 0.25, size.height * 0.45, size.width * 0.5, size.height * 0.6);
    path.quadraticBezierTo(size.width * 0.7, size.height * 0.75, size.width, size.height * 0.6);

    canvas.drawPath(path, paint);

    }
  
    @override
    bool shouldRepaint(CustomPainter oldDelegate) => true;
  
}