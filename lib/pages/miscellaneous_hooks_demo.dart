import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class MiscellaneousHooksDemo extends HookWidget {
  const MiscellaneousHooksDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Miscellaneous Hooks Demo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _useReducerExample(),
              _usePreviousExample(),
              _useTextEditingControllerExample(),
              _useFocusNodeExample(),
              _useTabControllerExample(),
              _useScrollControllerExample(),
              _usePageControllerExample(),
              _useAppLifecycleStateExample(),
              _useOnAppLifecycleStateChangeExample(),
              _useTransformationControllerExample(),
              _useIsMountedExample(context),
              _useAutomaticKeepAliveExample(),
              _useOnPlatformBrightnessChangeExample(),
              _useSearchControllerExample(),
              _useMaterialStatesControllerExample(),
              _useExpansionTileControllerExample(),
              _useDebouncedExample(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _useReducerExample() {
    final store = useReducer<int, String>(
      (state, action) {
        if (action == 'increment') {
          return state + 1;
        }
        return state;
      },
      initialState: 0,
      initialAction: '',
    );

    return Card(
      child: ListTile(
        title: const Text('useReducer Example'),
        subtitle: const Text(
            'Используется для управления более сложным состоянием, чем useState. Например, для реализации счетчика.'),
        trailing: Text('Count: ${store.state}'),
        onTap: () => store.dispatch('increment'),
      ),
    );
  }

  Widget _usePreviousExample() {
    final count = useState(0);
    final previousCount = usePrevious(count.value);

    return Card(
      child: ListTile(
        title: const Text('usePrevious Example'),
        subtitle: const Text(
            'Возвращает предыдущее значение, переданное usePrevious. Полезно для отслеживания изменений состояния.'),
        trailing: Column(
          children: [
            Text('Current: ${count.value}'),
            Text('Previous: $previousCount'),
          ],
        ),
        onTap: () => count.value += 1,
      ),
    );
  }

  Widget _useTextEditingControllerExample() {
    final controller = useTextEditingController();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('useTextEditingController Example'),
            const SizedBox(height: 8),
            const Text(
                'Создает TextEditingController, который автоматически очищается. Полезно для управления текстовым вводом.'),
            const SizedBox(height: 16),
            TextField(
              controller: controller,
              decoration: const InputDecoration(labelText: 'Enter text...'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => controller.clear(),
              child: const Text('Clear'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _useFocusNodeExample() {
    final focusNode = useFocusNode();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('useFocusNode Example'),
            const SizedBox(height: 8),
            const Text(
                'Создает FocusNode, который автоматически очищается. Полезно для управления фокусом ввода.'),
            const SizedBox(height: 16),
            TextField(
              focusNode: focusNode,
              decoration: const InputDecoration(labelText: 'Focus me'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => focusNode.requestFocus(),
              child: const Text('Focus TextField'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _useTabControllerExample() {
    final tabController = useTabController(initialLength: 3);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('useTabController Example'),
            const SizedBox(height: 8),
            const Text(
                'Создает TabController, который автоматически очищается. Полезно для управления вкладками.'),
            const SizedBox(height: 16),
            TabBar(
              controller: tabController,
              tabs: const [
                Tab(text: 'Tab 1'),
                Tab(text: 'Tab 2'),
                Tab(text: 'Tab 3'),
              ],
            ),
            SizedBox(
              height: 100,
              child: TabBarView(
                controller: tabController,
                children: const [
                  Center(child: Text('Content 1')),
                  Center(child: Text('Content 2')),
                  Center(child: Text('Content 3')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _useScrollControllerExample() {
    final scrollController = useScrollController();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('useScrollController Example'),
            const SizedBox(height: 8),
            const Text(
                'Создает ScrollController, который автоматически очищается. Полезно для управления скроллингом.'),
            const SizedBox(height: 16),
            SizedBox(
              height: 100,
              child: ListView.builder(
                controller: scrollController,
                itemCount: 20,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('Item $index'),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => scrollController.animateTo(
                0.0,
                duration: const Duration(seconds: 1),
                curve: Curves.easeInOut,
              ),
              child: const Text('Scroll to Top'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _usePageControllerExample() {
    final pageController = usePageController();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('usePageController Example'),
            const SizedBox(height: 8),
            const Text(
                'Создает PageController, который автоматически очищается. Полезно для управления страницами.'),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: PageView(
                controller: pageController,
                children: [
                  Container(color: Colors.red),
                  Container(color: Colors.green),
                  Container(color: Colors.blue),
                ],
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => pageController.animateToPage(
                0,
                duration: const Duration(seconds: 1),
                curve: Curves.easeInOut,
              ),
              child: const Text('Go to First Page'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _useAppLifecycleStateExample() {
    final appLifecycleState = useAppLifecycleState();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('useAppLifecycleState Example'),
            const SizedBox(height: 8),
            const Text(
                'Возвращает текущее состояние жизненного цикла приложения и обновляет виджет при изменении. Полезно для отслеживания состояния приложения.'),
            const SizedBox(height: 16),
            Text('Current state: $appLifecycleState'),
          ],
        ),
      ),
    );
  }

  Widget _useOnAppLifecycleStateChangeExample() {
    final appLifecycleState = useAppLifecycleState();
    useOnAppLifecycleStateChange((previousState, currentState) {
      print('App lifecycle state changed from $previousState to $currentState');
    });

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('useOnAppLifecycleStateChange Example'),
            const SizedBox(height: 8),
            const Text(
                'Слушает изменения состояния жизненного цикла приложения и вызывает обратный вызов при изменении. Полезно для выполнения действий при изменении состояния приложения.'),
            const SizedBox(height: 16),
            Text('Current state: $appLifecycleState'),
          ],
        ),
      ),
    );
  }

  Widget _useTransformationControllerExample() {
    final transformationController = useTransformationController();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('useTransformationController Example'),
            const SizedBox(height: 8),
            const Text(
                'Создает и очищает TransformationController. Полезно для интерактивных трансформаций, например, для масштабирования и перемещения изображений.'),
            const SizedBox(height: 16),
            InteractiveViewer(
              transformationController: transformationController,
              child: Container(
                color: Colors.blue,
                width: 200,
                height: 200,
                child: const Center(child: Text('Zoom me')),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _useIsMountedExample(BuildContext context) {
    final isMounted = useIsMounted();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('useIsMounted Example'),
            const SizedBox(height: 8),
            const Text(
                'Возвращает объект IsMounted для проверки, смонтирован ли виджет. Полезно для асинхронных операций, чтобы избежать выполнения действий после размонтирования виджета.'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                await Future.delayed(const Duration(seconds: 1));
                if (isMounted()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Widget is still mounted')),
                  );
                }
              },
              child: const Text('Check if mounted after delay'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _useAutomaticKeepAliveExample() {
    useAutomaticKeepAlive(wantKeepAlive: true);

    return const Card(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('useAutomaticKeepAlive Example'),
            SizedBox(height: 8),
            Text(
                'Маркирует виджет для сохранения его состояния в ленивых списках. Полезно для сохранения состояния в списках.'),
          ],
        ),
      ),
    );
  }

  Widget _useOnPlatformBrightnessChangeExample() {
    final brightness = usePlatformBrightness();
    useOnPlatformBrightnessChange((previousBrightness, newBrightness) {
      print(
          'Platform brightness changed from $previousBrightness to $newBrightness');
    });

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('useOnPlatformBrightnessChange Example'),
            const SizedBox(height: 8),
            const Text(
                'Слушает изменения яркости платформы и вызывает обратный вызов при изменении. Полезно для адаптации UI к изменениям яркости.'),
            const SizedBox(height: 16),
            Text('Current brightness: $brightness'),
          ],
        ),
      ),
    );
  }

  Widget _useSearchControllerExample() {
    final searchController = useSearchController();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('useSearchController Example'),
            const SizedBox(height: 8),
            const Text(
                'Создает SearchController, который автоматически очищается. Полезно для управления поисковым состоянием.'),
            const SizedBox(height: 16),
            TextField(
              controller: searchController,
              decoration: const InputDecoration(labelText: 'Search...'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _useMaterialStatesControllerExample() {
    final materialStatesController = useMaterialStatesController();

    return const Card(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('useMaterialStatesController Example'),
            SizedBox(height: 8),
            Text(
                'Создает и очищает MaterialStatesController. Полезно для управления состояниями материала, например, для кнопок.'),
          ],
        ),
      ),
    );
  }

  Widget _useExpansionTileControllerExample() {
    final expansionTileController = useExpansionTileController();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('useExpansionTileController Example'),
            const SizedBox(height: 8),
            const Text(
                'Создает и очищает ExpansionTileController. Полезно для управления состоянием ExpansionTile.'),
            const SizedBox(height: 16),
            ExpansionTile(
              controller: expansionTileController,
              title: const Text('Tap to expand'),
              children: const [
                ListTile(title: Text('Expanded content')),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _useDebouncedExample() {
    final userInput = useState('');
    final debouncedInput =
        useDebounced(userInput.value, const Duration(milliseconds: 500));

    useEffect(() {
      // Assume a fetch method fetchData(String query) exists
      print('Fetch data with: $debouncedInput');
      return null;
    }, [debouncedInput]);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('useDebounced Example'),
            const SizedBox(height: 8),
            const Text(
                'Возвращает версию значения с задержкой, вызывающую обновление виджета после указанного таймаута. Полезно для оптимизации частых изменений ввода.'),
            const SizedBox(height: 16),
            TextField(
              onChanged: (value) => userInput.value = value,
              decoration: const InputDecoration(labelText: 'Type something...'),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: MiscellaneousHooksDemo(),
  ));
}
