import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BreadCrumbProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        routes: {'/new': (_) => const NewBreadCrumbWidget()},
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
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
      body: Column(
        children: [
          Consumer<BreadCrumbProvider>(
            builder: (BuildContext context, BreadCrumbProvider value,
                Widget? child) {
              return BreadCrumbWidget(breadCrumbs: value.items);
            },
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/new');
            },
            child: const Text('Add new Bread Crumb'),
          ),
          TextButton(
            onPressed: () {
              context.read<BreadCrumbProvider>().reset();
            },
            child: const Text('Reset'),
          ),
        ],
      ),
    );
  }
}

class BreadCrumb {
  bool isActive = false;
  final String name;
  final String uuid;

  BreadCrumb({required this.name}) : uuid = const Uuid().v4();

  void activate() {
    isActive = true;
  }

  @override
  bool operator ==(covariant BreadCrumb other) => uuid == other.uuid;

  @override
  int get hashCode => uuid.hashCode;

  String getName() => name + (isActive ? ' > ' : '');
}

class BreadCrumbProvider extends ChangeNotifier {
  final List<BreadCrumb> _items = [];

  UnmodifiableListView<BreadCrumb> get items => UnmodifiableListView(_items);

  void add(BreadCrumb breadCrumb) {
    for (final item in _items) {
      item.activate();
    }
    _items.add(breadCrumb);
    notifyListeners();
  }

  void reset() {
    _items.clear();
    notifyListeners();
  }
}

class BreadCrumbWidget extends StatelessWidget {
  final UnmodifiableListView<BreadCrumb> breadCrumbs;

  const BreadCrumbWidget({super.key, required this.breadCrumbs});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: breadCrumbs.map((breadCrumb) {
        return Text(
          breadCrumb.getName(),
          style: TextStyle(
            color: breadCrumb.isActive ? Colors.blue : Colors.black,
          ),
        );
      }).toList(),
    );
  }
}

class NewBreadCrumbWidget extends StatefulWidget {
  const NewBreadCrumbWidget({super.key});

  @override
  State<NewBreadCrumbWidget> createState() => _NewBreadCrumbWidgetState();
}

class _NewBreadCrumbWidgetState extends State<NewBreadCrumbWidget> {
  late final TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new Breadcrumb'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          TextField(
            controller: _controller,
            decoration: const InputDecoration(
                hintText: 'Enter a new bread crumb here...'),
          ),
          TextButton(
            onPressed: () {
              final text = _controller.text;
              if (text.isNotEmpty) {
                BreadCrumb crumb = BreadCrumb(name: text);
                context.read<BreadCrumbProvider>().add(crumb);
                Navigator.of(context).pop();
              }
            },
            child: const Text('Add'),
          )
        ],
      ),
    );
  }
}
