import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hooked_bloc/hooked_bloc.dart';

// SimpleCubit
class SimpleCubit extends Cubit<int> {
  SimpleCubit() : super(0);

  void increment() => emit(state + 1);
}

// SimpleCubitFactory and SimpleCubitA/B
class SimpleCubitFactory extends BlocFactory<SimpleCubit> {
  bool _value = true;

  @override
  SimpleCubit create() {
    return _value ? SimpleCubitA() : SimpleCubitB();
  }

  void configure(bool value) {
    _value = value;
  }
}

class SimpleCubitA extends SimpleCubit {}

class SimpleCubitB extends SimpleCubit {}

// CounterCubit
class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0);

  void increment() => emit(state + 1);
}

// EventCubit
abstract class EventState extends Equatable {
  @override
  List<Object> get props => [];
}

class ShowMessage extends EventState {
  final String message;

  ShowMessage(this.message);

  @override
  List<Object> get props => [message];
}

class EventCubit extends Cubit<EventState> {
  EventCubit() : super(ShowMessage('Initial message'));

  void showMessage(String message) => emit(ShowMessage(message));
}

// MessageActionCubit
class MessageActionCubit extends Cubit<EventState>
    with BlocActionMixin<String, EventState> {
  MessageActionCubit() : super(ShowMessage('Initial message'));

  @override
  void dispatch(String action) {
    super.dispatch(action);
  }
}
