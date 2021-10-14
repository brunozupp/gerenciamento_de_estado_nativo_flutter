import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gerenciamento_de_estado_nativo_flutter/widgets/custom_button_widget.dart';

class OnePage extends StatefulWidget {
  const OnePage({ Key? key }) : super(key: key);

  @override
  _OnePageState createState() => _OnePageState();
}

class _OnePageState extends State<OnePage> {

  ValueNotifier<int> valorAleatorio = ValueNotifier<int>(0);

  random() async {
    for(int i = 0; i < 10; i++) {
      await Future.delayed(const Duration(seconds: 1));
      valorAleatorio.value = Random().nextInt(1000);
    }
  }

  @override
  Widget build(BuildContext context) {

    print("build");

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ValueListenableBuilder(
              valueListenable: valorAleatorio, 
              builder: (_,value,__) { // O segundo argumento tá tipado como int pq meu valueNotifier é do tipo int
                return Text("O valor é ${valorAleatorio.value} - $value");
              }
            ),
            CustomButtonWidget(
              title: "Um botão",
              onPressed: () {
                random();
              },
              titleSize: 18,
            ),
            CustomButtonWidget(
              title: "Página dois",
              onPressed: () {
                Navigator.of(context).pushNamed("/second_page");
              },
              titleSize: 18,
            ),
            CustomButtonWidget(
              title: "Página três",
              onPressed: () {
                Navigator.of(context).pushNamed("/third_page");
              },
              titleSize: 18,
            ),
          ],
        ),
      ),
    );
  }
}