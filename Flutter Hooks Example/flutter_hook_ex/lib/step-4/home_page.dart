import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class HomePage4 extends HookWidget {
  const HomePage4({super.key});

  @override
  Widget build(BuildContext context) {
    final CountDown countDown = useMemoized(() => CountDown(from: 5));
    final notifier = useListenable(countDown);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Hooks2'),
      ),
      body: Center(child: Text(notifier.value.toString())),
    );
  }
}

class CountDown extends ValueNotifier<int> {
  late StreamSubscription sub;

  CountDown({required int from}) : super(from) {
    sub = Stream.periodic(const Duration(seconds: 1), (value) => from - value)
        .takeWhile((element) => element >= 0)
        .listen((event) {
      value = event;
    });
  }

  @override
  void dispose() {
    sub.cancel();
    super.dispose();
  }
}
