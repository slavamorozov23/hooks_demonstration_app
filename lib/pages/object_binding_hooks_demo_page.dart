import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'dart:async';

class ObjectBindingHooksDemoPage extends HookWidget {
  const ObjectBindingHooksDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Object-binding Hooks Demo'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _useStreamDemo(),
            _useStreamControllerDemo(),
            _useOnStreamChangeDemo(),
            _useFutureDemo(),
            _useAnimationControllerDemo(),
            _useAnimationDemo(),
            _useListenableDemo(),
            _useValueNotifierDemo(),
            _useValueListenableDemo(),
          ],
        ),
      ),
    );
  }

  Widget _useStreamDemo() {
    final stream = useMemoized(
        () => Stream.periodic(const Duration(seconds: 1), (count) => count));
    final snapshot = useStream(stream);

    return Card(
      child: ListTile(
        title: const Text('useStream Demo'),
        subtitle: Text(
          'Stream value: ${snapshot.data}\n\n'
          'Используется для подписки на поток данных и получения их текущего состояния.',
        ),
      ),
    );
  }

  Widget _useStreamControllerDemo() {
    final controller = useStreamController<int>();

    useEffect(() {
      Future<void> addEvents() async {
        // Добавляем события в StreamController с паузами между ними
        for (int i = 0; i < 10; i++) {
          if (controller.isClosed) break;
          controller.add(i);
          await Future.delayed(const Duration(seconds: 1));
        }
      }

      addEvents();

      // Возвращаем функцию для очистки, которая закрывает StreamController
      return () => controller.close();
    }, [controller]);

    final snapshot = useStream(controller.stream);

    return Card(
      child: ListTile(
        title: const Text('useStreamController Demo'),
        subtitle: Text(
          'StreamController value: ${snapshot.data}\n\n'
          'Используется для создания StreamController, который автоматически диспозится.',
        ),
      ),
    );
  }

  Widget _useOnStreamChangeDemo() {
    final stream = useMemoized(
        () => Stream.periodic(const Duration(seconds: 1), (count) => count));
    final streamSubscription = useOnStreamChange<int>(stream, onData: (value) {
      log('Stream value changed: $value');
    });

    return const Card(
      child: ListTile(
        title: Text('useOnStreamChange Demo'),
        subtitle: Text(
          'Check console for stream value changes\n\n'
          'Используется для подписки на поток, регистрации обработчиков и получения подписки на поток.',
        ),
      ),
    );
  }

  Widget _useFutureDemo() {
    final future = useMemoized(() =>
        Future.delayed(const Duration(seconds: 2), () => 'Hello from Future!'));
    final snapshot = useFuture(future);

    return Card(
      child: ListTile(
        title: const Text('useFuture Demo'),
        subtitle: Text(
          'Future value: ${snapshot.data}\n\n'
          'Используется для подписки на Future и получения его текущего состояния.',
        ),
      ),
    );
  }

  Widget _useAnimationControllerDemo() {
    final controller =
        useAnimationController(duration: const Duration(seconds: 2));
    useEffect(() {
      controller.repeat(reverse: true);
      return controller.dispose;
    }, [controller]);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('useAnimationController Demo'),
            AnimatedBuilder(
              animation: controller,
              builder: (context, child) {
                return Text(
                  'AnimationController value: ${controller.value.toStringAsFixed(2)}\n\n'
                  'Используется для создания AnimationController, который автоматически диспозится.',
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _useAnimationDemo() {
    final controller =
        useAnimationController(duration: const Duration(seconds: 2));
    final animation = useAnimation(controller);

    useEffect(() {
      controller.repeat(reverse: true);
      return controller.dispose;
    }, [controller]);

    return Card(
      child: ListTile(
        title: const Text('useAnimation Demo'),
        subtitle: AnimatedBuilder(
          animation: controller,
          builder: (context, child) {
            return Text(
              'Animation value: ${animation.toStringAsFixed(2)}\n\n'
              'Используется для подписки на Animation и получения его текущего значения.',
            );
          },
        ),
      ),
    );
  }

  Widget _useListenableDemo() {
    final controller =
        useAnimationController(duration: const Duration(seconds: 2));
    useListenable(controller);

    useEffect(() {
      controller.repeat(reverse: true);
      return controller.dispose;
    }, [controller]);

    return Card(
      child: ListTile(
        title: const Text('useListenable Demo'),
        subtitle: AnimatedBuilder(
          animation: controller,
          builder: (context, child) {
            return Text(
              'AnimationController value: ${controller.value.toStringAsFixed(2)}\n\n'
              'Используется для подписки на Listenable и пометки виджета для перестройки при вызове слушателя.',
            );
          },
        ),
      ),
    );
  }

  Widget _useValueNotifierDemo() {
    final notifier = useValueNotifier<int>(0);

    return Card(
      child: ListTile(
        title: const Text('useValueNotifier Demo'),
        subtitle: Text(
          'ValueNotifier value: ${notifier.value}\n\n'
          'Используется для создания ValueNotifier, который автоматически диспозится.',
        ),
        trailing: IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {
            notifier.value++;
          },
        ),
      ),
    );
  }

  Widget _useValueListenableDemo() {
    final notifier = useValueNotifier<int>(0);
    final value = useValueListenable(notifier);

    return Card(
      child: ListTile(
        title: const Text('useValueListenable Demo'),
        subtitle: Text(
          'ValueNotifier value: $value\n\n'
          'Используется для подписки на ValueListenable и получения его текущего значения.',
        ),
        trailing: IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {
            notifier.value++;
          },
        ),
      ),
    );
  }
}
