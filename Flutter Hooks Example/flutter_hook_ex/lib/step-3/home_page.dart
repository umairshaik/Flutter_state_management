import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

extension CompactMap<T> on Iterable<T?> {
  Iterable<T> compactMap<E>([
    E? Function(T?)? transform,
  ]) =>
      map(transform ?? (e) => e).where((e) => e != null).cast();
}

const url = 'https://bit.ly/3qYOtDm';

class HomePage3 extends HookWidget {
  const HomePage3({super.key});

  @override
  Widget build(BuildContext context) {
    final Future<Image> future = useMemoized(() =>
        NetworkAssetBundle(Uri.parse(url))
            .load(url)
            .then((value) => value.buffer.asUint8List())
            .then((value) => Image.memory(value)));
    final AsyncSnapshot<Image> snapshot = useFuture(future);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Hooks2'),
      ),
      body: Center(
          child: Column(
        children: [
          snapshot.data,
        ].compactMap().toList(),
      )),
    );
  }
}
