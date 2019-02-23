import '../models/AppState.dart';
import './CounterReducer.dart';

AppState appReducer(AppState state, dynamic action) =>
    new AppState(counterState: counterReducer(state.counterState, action));
