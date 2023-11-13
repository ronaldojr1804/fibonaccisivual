import 'dart:math';

import 'package:fibonaccisivual/fibonacci_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sequência de Fibonacci',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController textEditingController =
      TextEditingController(text: '1');
  Color circleColor = Colors.blue;
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        circleColor = Theme.of(context).primaryColor;
        fibonacciWidget = FibonacciWidget(
          key: Key(Random().nextInt(50).toString()),
          initialValue: 1,
          circleColor: circleColor,
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Sequência de Fibonacci'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: Wrap(
                spacing: 5,
                runSpacing: 5,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        fibonacciWidget = FibonacciWidget(
                          key: Key(Random().nextInt(50).toString()),
                          initialValue: 1,
                          circleColor: circleColor,
                        );
                      });
                    },
                    child: const Text('Circulo'),
                  ),
                ],
              ),
            ),
            Expanded(
              child: fibonacciWidget,
            ),
          ],
        ),
      ),
    );
  }

  Widget fibonacciWidget = Container();
}

Future<Color> showColorPickerDialog(
    BuildContext context, Color currentColor) async {
  Color selectedColor = currentColor;

  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Escolha uma cor'),
        content: SingleChildScrollView(
          child: ColorPicker(
            pickerColor: currentColor,
            onColorChanged: (color) => selectedColor = color,
          ),
        ),
        actions: <Widget>[
          ElevatedButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );

  return selectedColor;
}
