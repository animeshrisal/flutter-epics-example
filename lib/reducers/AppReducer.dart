import '../models/AppState.dart';
import './CounterReducer.dart';

AppState appReducer(AppState state, dynamic action) =>
    new AppState(counter: counterReducer(state.counter, action));
