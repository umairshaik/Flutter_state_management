import 'package:flutter/material.dart';

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
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SliderInheritedNotifier(
        sliderData: sliderData,
        child: Builder(builder: (context) {
          return Column(
            children: [
              Slider(
                  value: SliderInheritedNotifier.of(context),
                  onChanged: (value) {
                    sliderData.value = value;
                  }),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Opacity(
                    opacity: SliderInheritedNotifier.of(context),
                    child: Container(
                      color: Colors.yellow,
                      height: 200,
                    ),
                  ),
                  Opacity(
                    opacity: SliderInheritedNotifier.of(context),
                    child: Container(
                      color: Colors.blue,
                      height: 200,
                    ),
                  )
                ].expandEqually().toList(),
              )
            ],
          );
        }),
      ),
    );
  }
}

class SliderData extends ChangeNotifier {
  double _value = 0.0;

  double get value => _value;

  set value(double newValue) {
    if (newValue != _value) {
      _value = newValue;
      notifyListeners();
    }
  }
}

final sliderData = SliderData();

class SliderInheritedNotifier extends InheritedNotifier<SliderData> {
  const SliderInheritedNotifier(
      {super.key, required super.child, required SliderData sliderData})
      : super(notifier: sliderData);

  static double of(BuildContext context) =>
      context
          .dependOnInheritedWidgetOfExactType<SliderInheritedNotifier>()
          ?.notifier
          ?.value ??
      0.0;
}

extension ExpandEqually on Iterable<Widget> {
  Iterable<Widget> expandEqually() => map((w) => Expanded(child: w));
}
