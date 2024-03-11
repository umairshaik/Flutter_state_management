import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
      home: const MyHomePage(title: 'Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;

  const MyHomePage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(title),
        ),
        body: MultiProvider(
          providers: [
            StreamProvider<Seconds>(
                create: (context) => Stream.periodic(
                      const Duration(seconds: 1),
                      (value) => Seconds(),
                    ),
                initialData: Seconds()),
            StreamProvider<Minutes>(
                create: (context) => Stream.periodic(
                      const Duration(seconds: 5),
                      (value) => Minutes(),
                    ),
                initialData: Minutes()),
          ],
          child: const Row(
            children: [
              SecondsWidget(),
              MinutesWidget(),
            ],
          ),
        ));
  }
}

class SecondsWidget extends StatelessWidget {
  const SecondsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final Seconds seconds = context.watch<Seconds>();
    return Expanded(
      child: Container(
        height: 100,
        color: Colors.yellow,
        child: Text(seconds.value),
      ),
    );
  }
}

class MinutesWidget extends StatelessWidget {
  const MinutesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final Minutes minutes = context.watch<Minutes>();
    return Expanded(
      child: Container(
        height: 100,
        color: Colors.blue,
        child: Text(minutes.value),
      ),
    );
  }
}

String now() => DateTime.now().toIso8601String();

@immutable
class Seconds {
  final String value;

  Seconds() : value = now();
}

@immutable
class Minutes {
  final String value;

  Minutes() : value = now();
}
