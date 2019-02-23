import "package:flutter_epics_example/actions/CounterAction.dart";
import "../models/Counter.dart";

Counter counterReducer(Counter state, action) {
  if (action is IncreaseCounter) {
    return state.copyWith(id: action.id);
  }

  if (action is DecreaseCounter) {
    return state.copyWith(id: action.id);
  }

  return state;
}
