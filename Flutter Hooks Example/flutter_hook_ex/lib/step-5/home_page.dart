import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class HomePage5 extends HookWidget {
  const HomePage5({super.key});

  @override
  Widget build(BuildContext context) {
    final AnimationController opacity = useAnimationController(
      duration: const Duration(seconds: 1),
      initialValue: 1,
      lowerBound: 0,
      upperBound: 1,
    );
    final AnimationController size = useAnimationController(
      duration: const Duration(seconds: 1),
      initialValue: 1,
      lowerBound: 0,
      upperBound: 1,
    );
    final controller = useScrollController();
    useEffect(() {
      controller.addListener(() {
        final double newOpacity = max(imageHeight - controller.offset, 0.0);
        final double normalized =
            newOpacity.normalize(0.0, imageHeight).toDouble();
        opacity.value = normalized;
        size.value = normalized;
      });
      return null;
    }, [controller]);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Hooks2'),
      ),
      body: Column(
        children: [
          SizeTransition(
            sizeFactor: size,
            axis: Axis.vertical,
            axisAlignment: -1,
            child: FadeTransition(
              opacity: opacity,
              child: Image.network(
                url,
                height: imageHeight,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
                controller: controller,
                itemBuilder: (context, position) {
                  return ListTile(title: Text('Person ${position + 1}'));
                },
                itemCount: 100),
          )
        ],
      ),
    );
  }
}

const String url = 'https://bit.ly/3qYOtDm';

const double imageHeight = 300.0;

extension Normalize on num {
  num normalize(
    num selfRangeMin,
    num selfRangeMax, [
    num normalizedRangeMin = 0.0,
    num normalizedRangeMax = 1.0,
  ]) =>
      (normalizedRangeMax - normalizedRangeMin) *
          ((this - selfRangeMin) / (selfRangeMax - selfRangeMin)) +
      normalizedRangeMin;
}
