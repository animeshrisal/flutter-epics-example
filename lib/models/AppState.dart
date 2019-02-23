import 'package:flutter/foundation.dart';
import './Counter.dart';

class AppState {
  final Counter counterState;

  AppState({@required this.counterState});

  AppState.initialState() : counterState = Counter(id: 0);
}
