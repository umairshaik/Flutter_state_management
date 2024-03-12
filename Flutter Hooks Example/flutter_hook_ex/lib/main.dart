import 'package:flutter/material.dart';
import 'package:flutter_hook_ex/step-5/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: //const HomePage1(title: 'Flutter Demo Home Page'),
          //const HomePage2(),
          //const HomePage3(),
          //const HomePage4(),
          const HomePage5(),
    );
  }
}
