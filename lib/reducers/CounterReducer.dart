import "package:flutter_epics_example/actions/CounterAction.dart";
import "../models/Counter.dart";

Counter counterReducer(Counter state, action) {
  if (action is IncreaseCounter) {
    state.id++;
    return state.copyWith();
  }

  if (action is DecreaseCounter) {
    state.id--;
    return state.copyWith();
  }

  return state;
}
