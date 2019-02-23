import 'package:redux_epics/redux_epics.dart';
import 'package:flutter_epics_example/actions/CounterAction.dart';
import '../models/AppState.dart';
import 'package:flutter/foundation.dart';

Stream<dynamic> counterEpic(
  Stream<dynamic> actions,
  EpicStore<AppState> store
) async* {
  await for(var action in actions){
    if(action is IncreaseCounter){
      new IncreaseCounter();
    }
  }
}