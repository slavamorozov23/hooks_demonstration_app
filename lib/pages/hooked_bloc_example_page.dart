import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import '../cubit.dart';

class HookedBlocExamplePage extends HookWidget {
  const HookedBlocExamplePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hooked Bloc Example')),
      body: ListView(
        children: [
          _buildUseBlocExample(),
          // _buildUseBlocFactoryExample(),
          _buildUseBlocBuilderExample(),
          _buildUseBlocComparativeBuilderExample(),
          _buildUseBlocListenerExample(),
          _buildUseBlocComparativeListenerExample(),
          _buildUseActionListenerExample(context),
        ],
      ),
    );
  }

  Widget _buildUseBlocExample() {
    final cubit = useBloc<SimpleCubit>();

    return Card(
      child: ListTile(
        title: const Text('useBloc Example'),
        subtitle: const Text(
            'Хук useBloc предназначен для поиска и предоставления Cubit/Bloc в дереве виджетов.'),
        trailing: ElevatedButton(
          onPressed: () => cubit.increment(),
          child: const Text('Increment'),
        ),
      ),
    );
  }

  Widget _buildUseBlocFactoryExample() {
    final cubit = useBlocFactory<SimpleCubit, SimpleCubitFactory>(
      onBlocCreate: (cubitFactory) {
        cubitFactory.configure(true);
      },
    );

    return Card(
      child: ListTile(
        title: const Text('useBlocFactory Example'),
        subtitle: const Text(
            'Хук useBlocFactory создает Cubit/Bloc через предоставленную фабрику.'),
        trailing: ElevatedButton(
          onPressed: () => cubit.increment(),
          child: const Text('Increment'),
        ),
      ),
    );
  }

  Widget _buildUseBlocBuilderExample() {
    final cubit = useBloc<CounterCubit>();
    final state = useBlocBuilder(cubit);

    return Card(
      child: ListTile(
        title: const Text('useBlocBuilder Example'),
        subtitle: const Text(
            'Хук useBlocBuilder обновляет виджет при появлении нового состояния.'),
        trailing: Text('State: $state'),
      ),
    );
  }

  Widget _buildUseBlocComparativeBuilderExample() {
    final cubit = useBloc<CounterCubit>();
    final state = useBlocComparativeBuilder(
      cubit,
      buildWhen: (previous, current) => previous != current,
    );

    return Card(
      child: ListTile(
        title: const Text('useBlocComparativeBuilder Example'),
        subtitle: const Text(
            'Хук useBlocComparativeBuilder обновляет виджет при положительном результате сравнения состояний.'),
        trailing: Text('State: $state'),
      ),
    );
  }

  Widget _buildUseBlocListenerExample() {
    final cubit = useBloc<EventCubit>();

    useBlocListener<EventCubit, EventState>(
      cubit,
      (_, state, context) {
        if (state is ShowMessage) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      listenWhen: (state) => state is ShowMessage,
    );

    return Card(
      child: ListTile(
        title: const Text('useBlocListener Example'),
        subtitle: const Text(
            'Хук useBlocListener позволяет наблюдать за состояниями cubit, представляющими действие.'),
        trailing: ElevatedButton(
          onPressed: () => cubit.showMessage('Hello from useBlocListener!'),
          child: const Text('Show Message'),
        ),
      ),
    );
  }

  Widget _buildUseBlocComparativeListenerExample() {
    final cubit = useBloc<EventCubit>();

    useBlocComparativeListener<EventCubit, EventState>(
      cubit,
      (_, state, context) {
        if (state is ShowMessage) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      listenWhen: (previousState, currentState) =>
          previousState is! ShowMessage && currentState is ShowMessage,
    );

    return Card(
      child: ListTile(
        title: const Text('useBlocComparativeListener Example'),
        subtitle: const Text(
            'Хук useBlocComparativeListener позволяет наблюдать и сравнивать состояния cubit, представляющие действие.'),
        trailing: ElevatedButton(
          onPressed: () =>
              cubit.showMessage('Hello from useBlocComparativeListener!'),
          child: const Text('Show Message'),
        ),
      ),
    );
  }

  Widget _buildUseActionListenerExample(BuildContext context) {
    final cubit = useBloc<MessageActionCubit>();

    useActionListener<String>(
      cubit,
      (action) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Action: $action')),
        );
      },
      actionWhen: (_, __) => true,
    );

    return Card(
      child: ListTile(
        title: const Text('useActionListener Example'),
        subtitle: const Text(
            'Хук useActionListener позволяет слушать поток действий, отличный от потока состояний.'),
        trailing: ElevatedButton(
          onPressed: () => cubit.dispatch('Action dispatched!'),
          child: const Text('Dispatch Action'),
        ),
      ),
    );
  }
}
