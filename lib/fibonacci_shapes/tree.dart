import 'package:flutter/material.dart';
import 'dart:math' as math;

class FibonacciTreePainter extends CustomPainter {
  final int depth; // Profundidade da árvore, equivalente ao número de ramos

  FibonacciTreePainter(this.depth);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.brown
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    // Define o ponto inicial para o tronco da árvore na parte inferior do canvas
    final Offset root = Offset(size.width / 2, size.height);

    // Desenha a árvore começando pelo tronco
    _drawBranch(canvas, paint, root, depth, -math.pi / 2, size.height / 4);
  }

  void _drawBranch(Canvas canvas, Paint paint, Offset start, int depth,
      double angle, double length) {
    if (depth == 0) return;

    // Calcula o ponto final do ramo atual
    final end = Offset(
      start.dx + length * math.cos(angle),
      start.dy + length * math.sin(angle),
    );

    // Desenha o ramo
    canvas.drawLine(start, end, paint);

    // Desenha o valor de Fibonacci
    drawText(canvas, '$length', end, depth);

    // Calcula o novo comprimento para os próximos ramos
    final double newLength = length / math.pi;

    // Desenha os ramos à esquerda e à direita
    _drawBranch(canvas, paint, end, depth - 1, angle + math.pi / 4, newLength);
    _drawBranch(canvas, paint, end, depth - 1, angle - math.pi / 4, newLength);
  }

  void drawText(Canvas canvas, String text, Offset position, int depth) {
    final textStyle = TextStyle(
      color: Colors.green,
      fontSize: 20.0 /
          depth, // Reduz o tamanho da fonte à medida que a profundidade aumenta
    );
    final textSpan = TextSpan(
      text: text,
      style: textStyle,
    );
    final textPainter = TextPainter(
      text: textSpan,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    textPainter.layout();
    // Ajusta a posição para desenhar o texto para evitar sobreposição
    final offset = Offset(position.dx, position.dy - 10.0 / depth);
    textPainter.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
