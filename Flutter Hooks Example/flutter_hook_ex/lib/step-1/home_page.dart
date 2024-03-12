import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class HomePage1 extends HookWidget {
  final String title;

  const HomePage1({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final dateTime = useStream(getTimeStream());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: Center(
        child: Text(dateTime.data ?? 'data'),
      ),
    );
  }
}

Stream<String> getTimeStream() => Stream.periodic(
      const Duration(seconds: 1),
      (_) => DateTime.now().toIso8601String(),
    );
