import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class HomePage extends HookWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = useTextEditingController();
    final ValueNotifier<String> text = useState('');
    useEffect(() {
      controller.addListener(() {
        text.value = controller.text;
      });
      return null;
    }, [controller]);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Hooks2'),
      ),
      body: Center(
        child: Column(
          children: [
            TextField(
              controller: controller,
            ),
            Text('You have typed ${text.value}'),
          ],
        ),
      ),
    );
  }
}
