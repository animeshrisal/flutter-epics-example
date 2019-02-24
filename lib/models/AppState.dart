import 'package:flutter/foundation.dart';
import './Counter.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

class AppState {
  final Counter counterState;

  AppState({@required this.counterState});

  AppState.initialState() : counterState = Counter(id: 0);

  static AppState fromJson(dynamic json) {
    if (json != null) {
      return AppState(counterState: Counter.fromJson(json['counterState']));
    } else {
      return AppState.initialState();
    }
  }

  dynamic toJson() => {'counterState': counterState.toJson()};
}
