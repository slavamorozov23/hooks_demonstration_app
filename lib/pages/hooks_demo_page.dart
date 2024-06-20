import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class HooksDemoPage extends HookWidget {
  const HooksDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hooks Demo'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _useEffectDemo(),
            _useStateDemo(),
            _useMemoizedDemo(),
            _useRefDemo(),
            _useCallbackDemo(),
            _useContextDemo(context),
            _useValueChangedDemo(),
          ],
        ),
      ),
    );
  }

  Widget _useEffectDemo() {
    useEffect(() {
      // Example of useEffect
      print('Effect triggered');
      return () {
        print('Cleanup');
      };
    }, []);

    return const Card(
      child: ListTile(
        title: Text('useEffect Demo'),
        subtitle: Text('отвечает за initState, didUpdateWidget и dispose.'),
      ),
    );
  }

  Widget _useStateDemo() {
    final counter = useState(0);

    return Card(
      child: ListTile(
        title: const Text('useState Demo'),
        subtitle: Text(
            'Counter: ${counter.value} -> |упарвляет состоянием переменных|'),
        trailing: IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {
            counter.value++;
          },
        ),
      ),
    );
  }

  Widget _useMemoizedDemo() {
    final expensiveValue = useMemoized(() {
      // Simulating an expensive operation
      return DateTime.now().toString();
    });

    return Card(
      child: ListTile(
        title: const Text('useMemoized Demo'),
        subtitle:
            Text('Memoized value: $expensiveValue -> |кеширование значения|'),
      ),
    );
  }

  Widget _useRefDemo() {
    final textFieldFocusNode = useRef(FocusNode());

    return Card(
      child: ListTile(
        title: const Text('useRef Demo -> |хранит контроллеры и Focuse ноды|'),
        subtitle: TextField(
          focusNode: textFieldFocusNode.value,
          decoration: const InputDecoration(labelText: 'Focus Node Example'),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.edit),
          onPressed: () {
            textFieldFocusNode.value.requestFocus();
          },
        ),
      ),
    );
  }

  Widget _useCallbackDemo() {
    final callback = useCallback(() {
      // Example callback
      log('Callback triggered');
    }, []);

    return Card(
      child: ListTile(
        title: const Text('useCallback Demo'),
        subtitle: const Text(
            'вызов функции выполнение которой зависит от определенных зависимостей и не требует перерисовки виджета'),
        trailing: IconButton(
          icon: const Icon(Icons.play_arrow),
          onPressed: callback,
        ),
      ),
    );
  }

  Widget _useContextDemo(BuildContext context) {
    final buildContext = useContext();

    return Card(
      child: ListTile(
        title: const Text('useContext Demo'),
        subtitle: Text(
            'Context: ${buildContext.hashCode}, -> |обеспечивает доступ к контексту без необходимости передавать его через параметры|'),
      ),
    );
  }

  Widget _useValueChangedDemo() {
    final value = useState(0);

    useValueChanged<int, void>(value.value, (v, _) {
      // Value changed callback
      print('Value changed: $v');
    });

    return Card(
      child: ListTile(
        title: const Text('useValueChanged Demo'),
        subtitle: Text(
            'Value: ${value.value}, -> |Для отслеживания изменений значений и выполнения действий при их изменении|'),
        trailing: IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {
            value.value++;
          },
        ),
      ),
    );
  }
}
