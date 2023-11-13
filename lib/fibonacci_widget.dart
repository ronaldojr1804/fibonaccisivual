import 'package:fibonaccisivual/fibonacci_shapes/circle.dart';
import 'package:fibonaccisivual/fibonacci_shapes/tree.dart';
import 'package:flutter/material.dart';

class FibonacciWidget extends StatefulWidget {
  final int initialValue;
  final Color circleColor;
  final int idShape;
  const FibonacciWidget({
    super.key,
    this.initialValue = 0,
    this.circleColor = Colors.blue,
    this.idShape = 0,
  });

  @override
  FibonacciWidgetState createState() => FibonacciWidgetState();
}

class FibonacciWidgetState extends State<FibonacciWidget>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller)
      ..addListener(() {
        setState(() {});
      });

    _controller.forward();
  }

  @override
  void didUpdateWidget(FibonacciWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialValue != oldWidget.initialValue) {
      _controller.reset();
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: (widget.idShape == 0)
          ? FibonacciCirclePainter(
              widget.initialValue,
              widget.circleColor,
              _animation.value,
            )
          : FibonacciTreePainter(
              1,
            ),
      size: Size(
        MediaQuery.of(context).size.width,
        MediaQuery.of(context).size.height,
      ),
    );
  }
}
