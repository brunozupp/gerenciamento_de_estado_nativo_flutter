import 'package:flutter/material.dart';
import 'package:gerenciamento_de_estado_nativo_flutter/pages/one_page.dart';
import 'package:gerenciamento_de_estado_nativo_flutter/pages/second_page.dart';
import 'package:gerenciamento_de_estado_nativo_flutter/pages/third_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        "/": (context) => const OnePage(),
        "/second_page": (context) => const SecondPage(),
        "/third_page": (context) => const ThirdPage(),
      },
      initialRoute: "/",
    );
  }
}